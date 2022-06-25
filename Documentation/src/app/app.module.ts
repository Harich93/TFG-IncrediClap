import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { DocumentacionFrontendComponent } from './pages/documentacion-frontend/documentacion-frontend.component';
import { ManualUsuarioComponent } from './pages/manual-usuario/manual-usuario.component';
import { NavBarComponent } from './shared/nav-bar/nav-bar.component';
import { FooterComponent } from './shared/footer/footer.component';
import { AccordionComponent } from './pages/manual-usuario/accordion/accordion.component';
import { ModalComponent } from './shared/modal/modal.component';
import { AccordionFrontComponent } from './pages/documentacion-frontend/accordion-front/accordion-front.component';
import { ChangePassComponent } from './pages/change-pass/change-pass.component';
import { ReactiveFormsModule } from '@angular/forms';
import { HashLocationStrategy, LocationStrategy } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { VerifyEmailComponent } from './pages/verify-email/verify-email.component';
import { PoliticaPrivacidadComponent } from './pages/politica-privacidad/politica-privacidad.component';

@NgModule({
  declarations: [
    AppComponent,
    ManualUsuarioComponent,
    DocumentacionFrontendComponent,
    NavBarComponent,
    FooterComponent,
    AccordionComponent,
    ModalComponent,
    AccordionFrontComponent,
    ChangePassComponent,
    VerifyEmailComponent,
    PoliticaPrivacidadComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule,
    RouterModule
  ],
  providers: [
    {provide: LocationStrategy, useClass: HashLocationStrategy},
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
