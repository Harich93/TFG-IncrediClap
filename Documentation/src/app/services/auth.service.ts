import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  public token!: string 

  constructor( private http: HttpClient) {}

  changePass(password: string): Observable<any> {
    console.log(this.token);
    
    const url = `https://incredibclap-backend-ts.herokuapp.com/users`;
    const headers = {'Content-Type': 'application/json', 'x-token': this.token};
    
    return this.http.put<any>(url, {password}, {headers});
  }

}
