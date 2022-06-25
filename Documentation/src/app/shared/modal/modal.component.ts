import { Component, ViewChild, ElementRef } from '@angular/core';
import { Subscription } from 'rxjs';
import { ModalServiceService } from 'src/app/services/modal-service.service';

@Component({
  selector: 'app-modal',
  templateUrl: './modal.component.html',
  styleUrls: ['./modal.component.scss']
})
export class ModalComponent {

  @ViewChild("btnModal") btnModal!: ElementRef;
  private _urlImg: string = '';
  private _urlImg$!: Subscription;

  constructor(private modalS: ModalServiceService) { 
    this._urlImg$ = modalS.urlImg$.subscribe(val => this.urlImg = val);
  }

  get urlImg() { return this._urlImg }

  set urlImg(val: string) {
    this._urlImg = val;
    this.btnModal.nativeElement.click();
  }

  


}
