import { Component, OnInit } from '@angular/core';
import { User } from '../models/user.model';
import { UsersService } from '../services/users.service';
import { ActivatedRoute,Router} from '@angular/router';

@Component({
  selector: 'app-admin-page',
  templateUrl: './admin-page.component.html',
  styleUrls: ['./admin-page.component.scss']
})
export class AdminPageComponent implements OnInit {
  
  id? : number;
  users : User[] = [];

  constructor(private userService : UsersService, private router: Router, private route : ActivatedRoute) {}
  viewProduct(userId: number) {
    this.router.navigate(['/products', userId]);
    this.id =+ this.route.snapshot.params['id'];
  }
  deleteUser(userId : number) {
    console.log(userId);
    this.userService.deleteUserByID(userId).subscribe({
      next : (users) =>{
      this.router.navigate(['products'])
    },
    error : (response) => {
        console.log(response);
    }
  });
}

  ngOnInit(): void {
    this.userService.getAllUsers().subscribe({
      next : (users) => {
        this.users = users;
      },
      error: (response) => {
        console.log(response)
      }
    });
  }
  
}
