import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/services/services.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'incredibclap-backend-ts.herokuapp.com';
  late User connectedUser;

  // <-- Autenticación de usuarios -->
  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> body = {'email': email, 'password': password};

    final url = Uri.http(_baseUrl, '/auth/login');

    final resp = await http.post(url,
        body: json.encode(body), headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> resDecode = json.decode(resp.body);

    return resDecode;
  }

  // <-- CRUD Usuarios -->
  Future<Map<String, dynamic>> createUser(
      String name, String email, String password) async {
    final Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'password': password
    };

    final url = Uri.http(_baseUrl, '/users');

    final resp = await http.post(url,
        body: json.encode(body), headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> resDecode = json.decode(resp.body);

    return resDecode;
  }

  Future<Map<String, dynamic>> updateUser(String name, String password) async {
    final Map<String, dynamic> body = {'name': name, 'password': password};

    final url = Uri.http(_baseUrl, '/users');

    final resp = await http.put(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'x-token': Preferences.token
    });

    final Map<String, dynamic> resDecode = json.decode(resp.body);

    return resDecode;
  }

  Future<Map<String, dynamic>> resetPass(String email) async {
    final url = Uri.http(_baseUrl, '/users/pass/$email');

    final resp = await http.put(url, headers: {
      'Content-Type': 'application/json',
    });

    final Map<String, dynamic> resDecode = json.decode(resp.body);

    return resDecode;
  }
}
