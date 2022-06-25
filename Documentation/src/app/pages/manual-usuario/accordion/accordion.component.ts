import { Component } from '@angular/core';
import { ModalServiceService } from '../../../services/modal-service.service';

@Component({
  selector: 'app-accordion',
  templateUrl: './accordion.component.html',
  styleUrls: ['./accordion.component.scss']
})
export class AccordionComponent {

  constructor(private modalS: ModalServiceService) { }

  setImgModal(event: any) {
    this.modalS.urlImg = event.target.src     
  }

}
