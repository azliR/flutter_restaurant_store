part of 'auth_cubit.dart';

enum AuthStatus { authorised, needCompletion, unauthorised }

@immutable
class AuthState extends Equatable {
  const AuthState({
    this.storeAdmin,
    required this.isLoading,
    this.errorMessage,
    this.infoMessage,
    required this.authStatus,
    required this.isSkipped,
  });

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
      'storeAdmin': storeAdmin?.toJson(),
      'isSkipped': isSkipped,
    };
  }

  factory AuthState.fromJson(Map<String, dynamic> map) {
    final storeAdminMap = map['storeAdmin'] as Map?;

    return AuthState.initial().copyWith(
      storeAdmin: optionOf(
        storeAdminMap != null
            ? StoreAdmin.fromJson(storeAdminMap.cast())
            : null,
      ),
      isSkipped: map['isSkipped'] as bool? ?? false,
    );
  }

  AuthState copyWith({
    Option<StoreAdmin?>? storeAdmin,
    bool? isLoading,
    String? errorMessage = _defaultErrorMessage,
    String? infoMessage = _defaultInfoMessage,
    AuthStatus? authStatus,
    bool? isSkipped,
  }) {
    return AuthState(
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
      storeAdmin,
      isLoading,
      errorMessage,
      infoMessage,
      authStatus,
      isSkipped,
    ];
  }
}
