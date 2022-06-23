import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_store/bloc/auth/auth_cubit.dart';
import 'package:flutter_restaurant_store/views/core/misc/dialogs.dart';
import 'package:flutter_restaurant_store/views/core/widgets/progress_overlay.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return ProgressOverlay(
          visible: state.isLoading,
          child: child,
        );
      },
    );
  }
}

class AuthListener extends StatelessWidget {
  const AuthListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              current.errorMessage != null &&
              previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            showErrorSnackbar(context, state.errorMessage!);
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              current.infoMessage != null &&
              previous.infoMessage != current.infoMessage,
          listener: (context, state) {
            showSnackbar(context, state.infoMessage!);
          },
        ),
      ],
      child: child,
    );
  }
}
