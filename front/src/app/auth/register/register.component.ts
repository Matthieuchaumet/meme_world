import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user.model';
import { AuthService } from 'src/app/services/auth.service';


@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
 registerRequest : User = {
  id :0,
  userName : '',
  email: '',
  adresse: '',
  imagePath : '',
  password : '',
  role: 0
};

constructor(private registerServicec : AuthService, private router : Router) {}

ngOnInit(): void {

}
register() {
  this.registerServicec.register(this.registerRequest)
  .subscribe({
    next : (user) => {
      this.router.navigate(['login']);
    },
    error: (response) => {
      console.log(response)
    }
  });
}
}
