import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user.model';
import { UsersService } from 'src/app/services/users.service';

@Component({
  selector: 'app-user-edit',
  templateUrl: './user-edit.component.html',
  styleUrls: ['./user-edit.component.scss']
})
export class UserEditComponent implements OnInit {
 
  user : User = {
    id: 0,
    userName: '',
    email : '',
    password : '',
    adresse : '',
    imagePath : '',
    role : 1
  };
  editRequest : User = {
    userName: '',
    email: '',
    adresse: '',
    imagePath : '',
    id: 0,
    password: '',
    role: 0
  }

  
  constructor(private usersService : UsersService) {}
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
        this.editRequest.id = foundUser.id;
      },
      error : (response) => {
        console.log(response);
    }});
  }

  edituser() {
    this.usersService.userEdit(this.editRequest.id,this.editRequest).subscribe({
      next : (user) => {
        this.editRequest = user;
      },
      error : (response) => {
        console .log(response)
      }})
  }
  

}
