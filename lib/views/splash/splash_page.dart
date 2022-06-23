import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_store/bloc/auth/auth_cubit.dart';
import 'package:flutter_restaurant_store/views/core/app_router.dart';
import 'package:flutterfire_ui/auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<AuthCubit>();
      switch (cubit.state.authStatus) {
        case AuthStatus.authorised:
          context.router
              .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
          break;
        case AuthStatus.needCompletion:
          // TODO: Handle this case.
          break;
        case AuthStatus.unauthorised:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(
                providerConfigs: [
                  EmailProviderConfiguration(),
                ],
              ),
            ),
          );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
