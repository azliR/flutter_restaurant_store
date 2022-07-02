// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_restaurant_store/bloc/auth/auth_cubit.dart';
import 'package:flutter_restaurant_store/bloc/preferences/preferences_cubit.dart';
import 'package:flutter_restaurant_store/injection.dart';
import 'package:flutter_restaurant_store/l10n/l10n.dart';
import 'package:flutter_restaurant_store/views/core/app_router.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  final authCubit = getIt<AuthCubit>();
  StreamSubscription<User?>? authSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authSubscription ??=
          authCubit.firebaseAuth.authStateChanges().listen((event) async {
        if (event == null) {
          print('object');
          _appRouter.popUntilRoot();
          _appRouter.pushWidget(
            SignInScreen(
              providerConfigs: const [EmailProviderConfiguration()],
              auth: authCubit.firebaseAuth,
            ),
          );
        } else {
          final token = await event.getIdToken(true);
          print(token);
          authCubit.loginStoreAdmin(
            token: token,
            onCompleted: (storeAdmin) {
              print(storeAdmin);
              _appRouter.pushAndPopUntil(
                const HomeRoute(),
                predicate: (_) => false,
              );
            },
            onError: (message) {
              print(message);
              authCubit.signOut();
            },
          );
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<PreferencesCubit>(),
        ),
        BlocProvider(
          create: (_) => authCubit,
        ),
      ],
      child: BlocBuilder<PreferencesCubit, PreferencesState>(
        buildWhen: (previous, current) =>
            previous.locale != current.locale ||
            previous.themeMode != current.themeMode,
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant',
            // themeMode: state.themeMode,
            themeMode: ThemeMode.dark,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.deepOrange,
              cardTheme: const CardTheme(
                shadowColor: Colors.transparent,
                margin: EdgeInsets.zero,
              ),
              textTheme: GoogleFonts.plusJakartaSansTextTheme(),
              inputDecorationTheme: const InputDecorationTheme(filled: true),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorSchemeSeed: Colors.deepOrange,
              cardTheme: const CardTheme(
                shadowColor: Colors.transparent,
                margin: EdgeInsets.zero,
              ),
              textTheme: GoogleFonts.plusJakartaSansTextTheme(),
              inputDecorationTheme: const InputDecorationTheme(filled: true),
            ),
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              // FlutterFireUILocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate(),
          );
        },
      ),
    );
  }
}
