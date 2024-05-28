import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { map } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';
import { User } from 'src/app/models/user.model';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  constructor(private loginService : AuthService, private router : Router) {}
  loginRequest = {
    username: '',
    password: '',
    role: 0
  };
  login() {
    this.loginService.login(this.loginRequest.username, this.loginRequest.password,this.loginRequest.role).subscribe({
    next : (response) => {
      console.log(response);
      this.router.navigate(['products']);
// Stocker le token JWT dans le local storage
localStorage.setItem('token', response.token);
// Stocker l'id dans le local storage
localStorage.setItem('id', response.id + 1); 
// Stocker la durée d'expiration en minutes
localStorage.setItem('expiresIn', '30');

// Récupérer la durée d'expiration en minutes
const expiresInStr = localStorage.getItem('expiresIn');
const expiresIn = expiresInStr ? parseInt(expiresInStr) : 0;

// Vérifier si le token est expiré
const expirationDate = new Date(Date.now() + expiresIn * 60 * 1000);
if (expirationDate <= new Date()) {
  // Le token est expiré, supprimer le token et déconnecter l'utilisateur
  localStorage.removeItem('token');
}   
  } ,
  error: (bonjour) => {
    console.log('la connexion ne fonctionne pas', bonjour)  }
  })}
}
    
