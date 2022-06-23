part of 'auth_cubit.dart';

enum AuthStatus { authorised, needCompletion, unauthorised }

@immutable
class AuthState extends Equatable {
  const AuthState({
    this.authToken,
    this.storeAdmin,
    required this.isLoading,
    this.errorMessage,
    this.infoMessage,
    required this.authStatus,
    required this.isSkipped,
  });

  final AuthToken? authToken;
  final StoreAdmin? storeAdmin;
  final bool isLoading;
  final String? errorMessage;
  final String? infoMessage;
  final AuthStatus authStatus;
  final bool isSkipped;

  static const _defaultInfoMessage = '';
  static const _defaultErrorMessage = '';

  factory AuthState.initial() => const AuthState(
        isLoading: false,
        isSkipped: false,
        authStatus: AuthStatus.unauthorised,
      );

  Map<String, dynamic> toJson() {
    return {
      'authToken': authToken?.toJson(),
      'storeAdmin': storeAdmin?.toJson(),
      'isSkipped': isSkipped,
    };
  }

  factory AuthState.fromJson(Map<String, dynamic> map) {
    final authTokenMap = map['authToken'] as Map?;
    final storeAdminMap = map['storeAdmin'] as Map?;

    return AuthState.initial().copyWith(
      authToken: optionOf(
        authTokenMap != null ? AuthToken.fromJson(authTokenMap.cast()) : null,
      ),
      storeAdmin: optionOf(
        storeAdminMap != null
            ? StoreAdmin.fromJson(storeAdminMap.cast())
            : null,
      ),
      isSkipped: map['isSkipped'] as bool? ?? false,
    );
  }

  AuthState copyWith({
    Option<AuthToken?>? authToken,
    Option<StoreAdmin?>? storeAdmin,
    bool? isLoading,
    String? errorMessage = _defaultErrorMessage,
    String? infoMessage = _defaultInfoMessage,
    AuthStatus? authStatus,
    bool? isSkipped,
  }) {
    return AuthState(
      authToken:
          authToken != null ? authToken.getOrElse(() => null) : this.authToken,
      storeAdmin: storeAdmin != null
          ? storeAdmin.getOrElse(() => null)
          : this.storeAdmin,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage == _defaultErrorMessage
          ? this.errorMessage
          : errorMessage,
      infoMessage:
          infoMessage == _defaultInfoMessage ? this.infoMessage : infoMessage,
      authStatus: authStatus ?? this.authStatus,
      isSkipped: isSkipped ?? this.isSkipped,
    );
  }

  @override
  List<Object?> get props {
    return [
      authToken,
      storeAdmin,
      isLoading,
      errorMessage,
      infoMessage,
      authStatus,
      isSkipped,
    ];
  }
}
