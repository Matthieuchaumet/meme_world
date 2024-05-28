import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ProductsListComponent } from './products/products-list/products-list.component';
import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { UserProfilComponent } from './user/user-profil/user-profil.component';
import { UserEditComponent } from './user/user-edit/user-edit.component';
import { AdminPageComponent } from './admin-page/admin-page.component';
import { ProductIdListComponent } from './products/product-id-list/product-id-list.component';

const routes: Routes = [
  {
    path:'products',
    component: ProductsListComponent
  },
  {
    path:'login',
    component: LoginComponent
  },
  {
    path:'register',
    component: RegisterComponent
  },
  {
    path:'edit',
    component: UserEditComponent
  },
  {
    path:'profil',
    component: UserProfilComponent
  },
  {
    path:'admin',
    component: AdminPageComponent
  },
  { 
    path: 'products/:id', 
    component: ProductIdListComponent 
  },
  {
    path:'admin/:id',
    component: AdminPageComponent
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
