import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Route, Router } from '@angular/router';
import { User } from 'src/app/models/user.model';
import { UsersService } from 'src/app/services/users.service';

@Component({
  selector: 'app-user-profil',
  templateUrl: './user-profil.component.html',
  styleUrls: ['./user-profil.component.scss']
})
export class UserProfilComponent implements OnInit {
  user : User = {
    id: 0,
    userName: '',
    email : '',
    imagePath : '',
    password : '',
    adresse : '',
    role : 1
  };
  token : any;
  id : number = 1;
  constructor(private usersService : UsersService, private router : Router, private route : ActivatedRoute) {}
  ngOnInit(): void {
    this.usersService.viewUser().subscribe({
      next : (foundUser) => {
        this.user = {
          id: foundUser.id,
          userName: foundUser.userName,
          email: foundUser.email,
          imagePath : '',
          password:'',
          adresse: foundUser.adresse,
          role: foundUser.role
        }
      },
      error : (response) => {
        console.log(response);
    }});
    
  }
  viewProduct(userId: number) {
    this.router.navigate(['/products', userId]);
    this.id =+ this.route.snapshot.params['id'];
  }
}
