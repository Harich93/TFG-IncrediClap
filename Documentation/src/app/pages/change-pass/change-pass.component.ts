import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthService } from 'src/app/services/auth.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-change-pass',
  templateUrl: './change-pass.component.html',
  styleUrls: ['./change-pass.component.scss']
})
export class ChangePassComponent implements OnInit {
  public form: FormGroup;
  public pass1!: AbstractControl;
  public pass2!: AbstractControl;
  public isError1: boolean = true;
  public isError2: boolean = true;
  public isErrorAPI: boolean | undefined = undefined;
  public isDisabled = true;
  public isLoading = false;
  public msg: string = '';

  constructor( private fb: FormBuilder, private authS: AuthService, private route: ActivatedRoute) { 
    this.form = this.fb.group({
      pass1: ['',[Validators.min(6), Validators.required]],
      pass2: ['',[Validators.min(6), Validators.required]]
    });
  }
  
  ngOnInit(): void {
    const { pass1, pass2 } = this.form.controls; 
    this.pass1 = pass1;
    this.pass2 = pass2;

    this.pass1.valueChanges.subscribe(x => this.isValidPass())
    this.pass2.valueChanges.subscribe(x => this.isValidPass())

    this.authS.token = this.route.snapshot.queryParams['token'] || '';    
  }
  

  isValidPass() {

    if(this.pass1.dirty){
      
      if( this.pass1.value.length < 6 ) {
        this.msg = "Debe tener 6 caracteres minimo";
        this.isError1 = true;
      }

      else { this.isError1 = false; }
      
    }

    if(this.pass2.dirty){
        
      if( this.pass2.value != this.pass1.value && this.pass1.value.length > 0) {
        this.msg = "Las contraseñas no coinciden"
        this.isError2 = true;
      }

      else { this.isError2 = false; }
    }

    
  }


  changePass() {
    this.isLoading = true;
    this.authS.changePass(this.pass2.value)
      .subscribe( resp => {
        resp.uid ? (this.isErrorAPI = false) : (this.isErrorAPI = true )
        console.log(resp);
        
        this.isLoading = false;
      }); 
  }

}
