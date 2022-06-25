import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ModalServiceService {
 
  private _urlImg!: string;
  private _urlImg$!: Subject<string>;

  constructor() {
    this._urlImg = '';
    this._urlImg$ = new Subject();
  }

  get urlImg$():Observable<string> { 
    return this._urlImg$.asObservable();
  }

  get urlImg() { return this._urlImg }

  set urlImg(val: string) {
    this._urlImg = val;
    this._urlImg$.next(this._urlImg);
  }
}
