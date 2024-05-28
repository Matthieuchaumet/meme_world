import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment.development';
import { User } from '../models/user.model';
import { Observable, catchError, map, throwError } from 'rxjs';
import jwtDecode from 'jwt-decode';


@Injectable({
  providedIn: 'root'
})
export class AuthService {

  baseApiUrl : string = environment.baseApiUrl;

  constructor(private http: HttpClient) { }

  register(registerRequest : User) : Observable<User> {
    return this.http.post<User>(this.baseApiUrl + 'api/register', registerRequest)
  }

  login(username: string, password: string, role: number): Observable<any> {
    const headers = new HttpHeaders()
    .set('Content-Type', 'application/json')
    return this.http.post<any>(this.baseApiUrl + 'api/login', {username: username, password: password, role : role},{headers: headers})
  }
} 
