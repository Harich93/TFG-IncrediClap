import { Injectable } from '@angular/core';
import { iWidget } from '../interfaces/iWidget';

@Injectable({
  providedIn: 'root'
})
export class DataService {

  private _lstAuthWidgets: iWidget[] = [
    {
      name: 'auth_background',
      desc: 'Background pantalla login y registro.'
    },
    {
      name: 'auth_button',
      desc: 'Botton Login / registro.'
    },
    {
      name: 'auth_card',
      desc: 'Contenedor formulario.'
    },
    {
      name: 'auth_inputs_form',
      desc: 'Inputs personalizados.'
    },
    {
      name: 'auth_text_button',
      desc: 'Botón redireccionamiento.'
    },
  ];

  private _lstSharedWidgets: iWidget[] = [
    {
      name: 'background',
      desc: 'Background app.'
    },
    {
      name: 'card_swiper',
      desc: 'Carrousel imagenes.'
    },
    {
      name: 'floating_record_button',
      desc: 'Boton grabación.'
    },
    {
      name: 'app_bar_custom',
      desc: 'Appbar global.'
    },
    {
      name: 'custom_navigation_bar',
      desc: 'Barra de navegación inferior.'
    },
    {
      name: 'pop_menu',
      desc: 'Menú desplegable.'
    },
    {
      name: 'title_page',
      desc: 'Título pantallas.'
    },
  ];

  private _lstMusicWidgets: iWidget[] = [
    {
      name: 'custom_button',
      desc: 'Botón para los audios.'
    },
    {
      name: 'music_radial_duration',
      desc: 'Progreso duración de la grabación.'
    },
    {
      name: 'music_sheets',
      desc: 'Modal partituras.'
    },
  ];

  private _lstServices: iWidget[] = [
    {
      name: 'auth_service',
      desc: 'Autenticación, creación y modificación de usuarios .'
    },
    {
      name: 'player_audio_service',
      desc: 'Control de reproducción de los audios guardados.'
    },
    {
      name: 'record_service',
      desc: 'Control de grabación, guardado y eliminación de audios.'
    },
    {
      name: 'user_preferences_service',
      desc: 'Preferencias de usuario.'
    }
  ];

  private _lstProviders: iWidget[] = [
    {
      name: 'audio_provider',
      desc: 'Gestión de audios.'
    },
    {
      name: 'login_provider',
      desc: 'Gestión datos Login / registro.'
    },
    {
      name: 'menu_hidden',
      desc: 'Gestión scroll.'
    },
    {
      name: 'ui_provider',
      desc: 'Gestión navegación tabs.'
    }
  ];

  private _lstScreens: iWidget[] = [
    {
      name: 'home_screen',
      desc: 'Principal.'
    },
    {
      name: 'login_screen',
      desc: 'Login.'
    },
    {
      name: 'register_screen',
      desc: 'Registro.'
    },
    {
      name: 'music_screen',
      desc: 'Creación de audios.'
    },
    {
      name: 'player_screen',
      desc: 'Reproducción de audios.'
    },
    {
      name: 'settigns_screen',
      desc: 'Reproducción de audios.'
    },
    {
      name: 'list_audios_screen',
      desc: 'Listado de audios all/user.'
    },
  ];
  
  private _lstFlutterPackages: string[] = [
    'provider',
    'http',
    'shared_preferences',
    'just_audio',
    'just_audio_libwinmedia',
    'modal_bottom_sheet',
    'animate_do',
    'card_swiper',
    'google_fonts',
    'flutter_native_splash',
  ];

  private _lstNodePackages: string[] = [
    'bcrypt',
    'cors',
    'dotenv',
    'express',
    'express-validator',
    'jsonwebtoken',
    'mongoose',
    'nodemailer',
  ];

  get lstAuthWidgets() {return this._lstAuthWidgets}
  get lstSharedWidgets() {return this._lstSharedWidgets}
  get lstMusicWidgets() {return this._lstMusicWidgets}
  get lstNodePackages() {return this._lstNodePackages}
  get lstFlutterPackages() {return this._lstFlutterPackages}
  get lstProviders() {return this._lstProviders}
  get lstServices() {return this._lstServices}
  get lstScreens() {return this._lstScreens}
}
