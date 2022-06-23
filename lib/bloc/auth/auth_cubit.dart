import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant_store/models/auth/auth_token.dart';
import 'package:flutter_restaurant_store/models/auth/store_admin.dart';
import 'package:flutter_restaurant_store/repositories/auth_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(
    this._authRepository,
  ) : super(AuthState.initial());

  final AuthRepository _authRepository;

  FirebaseAuth get firebaseAuth => _authRepository.firebaseAuth;

  Future<void> loginStoreAdmin({
    required String token,
    required void Function(StoreAdmin storeAdmin) onCompleted,
    required void Function(String? message) onError,
  }) async {
    emit(state.copyWith(isLoading: true));
    _authRepository.loginStoreAdmin(
      token: token,
      onCompleted: onCompleted,
      onError: onError,
    );
  }

  Future<void> updateProfile({
    required String name,
    required String language,
  }) async {
    if (name != state.storeAdmin?.fullName) {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );

      await _authRepository.updateProfile(
        // token: state.authToken!.token,
        token: state.storeAdmin!.id,
        name: name,
        language: language,
        onCompleted: (storeAdmin) {
          emit(
            state.copyWith(
              storeAdmin: optionOf(storeAdmin),
              isLoading: false,
            ),
          );
        },
        onError: (message) {
          emit(
            state.copyWith(
              errorMessage: message,
              isLoading: false,
            ),
          );
        },
      );
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
    ));

    await _authRepository.signOut(
      onCompleted: () {
        emit(state.copyWith(
          storeAdmin: optionOf(null),
          authToken: optionOf(null),
          isLoading: false,
          authStatus: AuthStatus.unauthorised,
          isSkipped: false,
        ));
      },
      onError: (message) {
        emit(state.copyWith(
          errorMessage: message,
          isLoading: false,
        ));
      },
    );
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
