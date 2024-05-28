import { Component, OnInit } from '@angular/core';
import { Product } from 'src/app/models/product.model';
import { ProductsService } from 'src/app/services/products.service';
import { User } from 'src/app/models/user.model';
import { ActivatedRoute, Router } from '@angular/router';
@Component({
  selector: 'app-product-id-list',
  templateUrl: './product-id-list.component.html',
  styleUrls: ['./product-id-list.component.scss']
})
export class ProductIdListComponent implements OnInit {
  products: Product[] = [];
  idUser? : any;
  id? : number;
  constructor(private route: ActivatedRoute,private router : Router, private productsService : ProductsService) {}
  ngOnInit(): void {

    this.idUser = localStorage.getItem('id');
    this.idUser = this.idUser ? parseInt(this.idUser) : 0;
    console.log(this.idUser)
    this.id =+ this.route.snapshot.params['id'];
    this.productsService.getProductsById(this.id).subscribe({
      next : (products) => {
        this.products = products;
      },
    error : (error) => {
        console.log(error);
    }})
  }
  deleteProduct(productId : number) {
    this.productsService.deleteProductById(productId).subscribe({
      next : (product) =>{
      this.router.navigate(['profil'])
    },
    error : (response) => {
        console.log(response);
    }
  });
  }
}
