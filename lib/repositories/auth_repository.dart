import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_store/injection.dart';
import 'package:flutter_restaurant_store/models/auth/store_admin.dart';
import 'package:flutter_restaurant_store/repositories/core/local_injectable_module.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future<void> loginStoreAdmin({
    required void Function(StoreAdmin storeAdmin) onCompleted,
    required void Function(String? message) onError,
  }) async {
    try {
      final url = Uri(
        scheme: getIt<LocalInjectableModule>().schemeApi,
        host: getIt<LocalInjectableModule>().hostApi,
        port: getIt<LocalInjectableModule>().portApi,
        path: '/api/v1/store/auth',
      );
      final token = await _firebaseAuth.currentUser!.getIdToken();
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      final body = (jsonDecode(response.body) as Map).cast<String, dynamic>();
      if (response.statusCode == 200) {
        final storeAdmin =
            StoreAdmin.fromJson(body['data'] as Map<String, dynamic>);
        onCompleted(storeAdmin);
      } else {
        final e = body['message'] as String?;
        log(e.toString());
        onError(e);
      }
    } catch (e, stackTrace) {
      log(e.toString(), error: e, stackTrace: stackTrace);
      onError(e.toString());
    }
  }

  Future<void> getProfile({
    required String token,
    required void Function(StoreAdmin storeAdmin) onCompleted,
    required void Function(String? message) onError,
  }) async {
    try {
      final url = Uri(
        scheme: getIt<LocalInjectableModule>().schemeApi,
        host: getIt<LocalInjectableModule>().hostApi,
        port: getIt<LocalInjectableModule>().portApi,
        path: '/api/v1/user/profile',
      );
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final body = jsonDecode(response.body) as Map;
      if (response.statusCode == 200) {
        onCompleted(StoreAdmin.fromJson((body['data'] as Map).cast()));
      } else {
        onError(body['message'] as String?);
      }
    } catch (e, stackTrace) {
      log(e.toString(), error: e, stackTrace: stackTrace);
      onError(e.toString());
    }
  }

  Future<void> updateProfile({
    required String token,
    required String name,
    required String language,
    required void Function(StoreAdmin storeAdmin) onCompleted,
    required void Function(String? message) onError,
  }) async {
    try {
      final url = Uri(
        scheme: getIt<LocalInjectableModule>().schemeApi,
        host: getIt<LocalInjectableModule>().hostApi,
        port: getIt<LocalInjectableModule>().portApi,
        path: '/api/v1/user/profile',
      );
      final response = await http.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'language': language,
        }),
      );
      final body = jsonDecode(response.body) as Map;
      if (response.statusCode == 200) {
        onCompleted(StoreAdmin.fromJson((body['data'] as Map).cast()));
      } else {
        onError(body['message'].toString());
      }
    } catch (e, stackTrace) {
      log(e.toString(), error: e, stackTrace: stackTrace);
      onError(e.toString());
    }
  }

  Future<void> signOut({
    required void Function() onCompleted,
    required void Function(String? message) onError,
  }) async {
    try {
      await _firebaseAuth.signOut();
      await HydratedBlocOverrides.current?.storage.clear();
      onCompleted();
    } catch (e, stackTrace) {
      log(e.toString(), error: e, stackTrace: stackTrace);
      onError(e.toString());
    }
  }
}
