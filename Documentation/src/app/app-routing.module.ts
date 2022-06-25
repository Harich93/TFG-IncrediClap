import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ManualUsuarioComponent } from './pages/manual-usuario/manual-usuario.component';
import { DocumentacionFrontendComponent } from './pages/documentacion-frontend/documentacion-frontend.component';
import { ChangePassComponent } from './pages/change-pass/change-pass.component';
import { VerifyEmailComponent } from './pages/verify-email/verify-email.component';
import { PoliticaPrivacidadComponent } from './pages/politica-privacidad/politica-privacidad.component';

const routes: Routes = [
  { path: '', component: ManualUsuarioComponent }, 
  { path: 'manual-usuario', component: ManualUsuarioComponent },
  { path: 'doc-front', component: DocumentacionFrontendComponent },
  { path: 'change-pass', component: ChangePassComponent },
  { path: 'verify-email', component: VerifyEmailComponent},
  { path: 'politica-privacidad', component: PoliticaPrivacidadComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
