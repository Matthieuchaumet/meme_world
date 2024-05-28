import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment.development';
import jwtDecode from 'jwt-decode';
import { User } from '../models/user.model';
import { Observable } from 'rxjs';
;
@Injectable({
  providedIn: 'root'
})
export class UsersService {
  baseApiUrl : string = environment.baseApiUrl;
  constructor(private http: HttpClient ) { }
  user: User[] = [];
  id = 1;
  getAllUsers() : Observable<User[]>  {
    return this.http.get<User[]>(this.baseApiUrl + 'api/Users');
  }
  getUserById(userid : number) : Observable<User> {
    return this.http.get<User>(this.baseApiUrl + 'api/user/' +userid);
  }
  getCurrentUser() {
    return this.http.get<User>(this.baseApiUrl + 'api/me');
  }
  deleteUserByID(userid : number) {
    return this.http.delete(this.baseApiUrl + 'api/user/'+ userid)
  }
  userEdit(userid:number, editRequest : User) : Observable <User>{
    return this.http.put<User>(this.baseApiUrl + 'api/user/'+ userid, editRequest)
  }
  viewUser() {
     return this.getCurrentUser();
  }
  decodeToken() {
    const token = localStorage.getItem('token');
    if(token){
      const decoded :  any  = jwtDecode(token);
      const decodedJson = JSON.stringify(decoded);
      const decTo =  JSON.parse(decodedJson);
  }
  }
}
