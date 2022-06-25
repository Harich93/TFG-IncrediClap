import { Component } from '@angular/core';
import { DataService } from 'src/app/services/data.service'

@Component({
  selector: 'app-accordion-front',
  templateUrl: './accordion-front.component.html',
  styleUrls: ['./accordion-front.component.scss']
})
export class AccordionFrontComponent {

  baseUrlApp: string = 'https://github.com/Harich93/TFG-IncrediClap/tree/main/App/lib'; 

  constructor(public dataS: DataService){}


}
