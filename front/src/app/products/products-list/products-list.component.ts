import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Product } from 'src/app/models/product.model';
import { ProductsService } from 'src/app/services/products.service';
import { createEnumMember } from 'typescript';

@Component({
  selector: 'app-products-list',
  templateUrl: './products-list.component.html',
  styleUrls: ['./products-list.component.scss']
})
export class ProductsListComponent implements OnInit {

  products : Product[] = [];

  productsRequest : Product = {
    id : 0,
    name: '',
    price: 0,
    userId: 0,
    imagePath : ''
  }

  constructor(private productsService : ProductsService, private router : Router) {}
ngOnInit(): void {
  this.productsService.getAllProducts()
  .subscribe({
    next : (products) => {
      this.products = products;
    },
    error: (response) => {
      console.log(response);
    }
  });
  
} 
 displayMemeDetail(id : number) {
  this.productsService.getProductById(id).subscribe({
    next : (product) => {
      this.productsRequest = product;
    },
    error :  (response) => {
      console.log(response);
    }
  });
 }
createMeme() {
  const id = localStorage.getItem('id');
  const idUser = id ? parseInt(id) : 0;
  this.productsRequest.userId = idUser;
  this.productsService.createProduct(this.productsRequest).subscribe({
    next : (product) => {
    },
    error : (response) => {
      console.log(response);
    }
  });
}
}
