import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ProductsListComponent } from './products/products-list/products-list.component';
import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { FormsModule } from '@angular/forms';
import { AuthInterceptor } from './interceptors/auth.interceptor';
import { UserEditComponent } from './user/user-edit/user-edit.component';
import { UserProfilComponent } from './user/user-profil/user-profil.component';
import { AdminPageComponent } from './admin-page/admin-page.component';
import { ProductIdListComponent } from './products/product-id-list/product-id-list.component';

@NgModule({
  declarations: [
    AppComponent,
    ProductsListComponent,
    LoginComponent,
    RegisterComponent,
    UserEditComponent,
    UserProfilComponent,
    AdminPageComponent,
    ProductIdListComponent
  ],
  imports: [
    FormsModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule 
  ],
  providers: [
    { provide: HTTP_INTERCEPTORS, useClass: AuthInterceptor, multi: true }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
