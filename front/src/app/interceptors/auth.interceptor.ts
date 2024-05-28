import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  constructor() { }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // Récupère le token dans le local storage
    const token = localStorage.getItem('token');
    if (token) {
      // Ajoute le token au header de la requête
      request = request.clone({
        setHeaders: {
          Authorization: `Bearer ${token}`,
          'Content-Type' : `application/json`
        }
      });
    }
    return next.handle(request);
  }
}
