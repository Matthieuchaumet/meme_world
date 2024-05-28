import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment.development';
import { Product } from '../models/product.model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductsService {

  baseApiUrl : string = environment.baseApiUrl;

  constructor(private http: HttpClient) { }

  getAllProducts() : Observable<Product[]> {
    return this.http.get<Product[]>(this.baseApiUrl + 'api/Products')
  }

  getProductsById(id : number) : Observable<Product[]> {
    return this.http.get<Product[]>(`${this.baseApiUrl}api/products/${id}`)
  }

  createProduct(productRequest : Product) : Observable<Product> {
    return this.http.post<Product>(`${this.baseApiUrl}api/product/create`,productRequest)
  }

  getProductById(id:  number) : Observable<Product> {
    return this.http.get<Product>(`${this.baseApiUrl}api/product/${id}`)
  }
  deleteProductById(id: number) {
    return this.http.delete(this.baseApiUrl + 'api/user/'+ id)
  }
}
