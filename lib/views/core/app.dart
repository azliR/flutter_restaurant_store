// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

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

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final authCubit = getIt<AuthCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<PreferencesCubit>(),
        ),
        BlocProvider(
          create: (_) => authCubit
            ..firebaseAuth.authStateChanges().listen((event) async {
              if (event == null) {
                _appRouter.pushWidget(
                  const SignInScreen(
                    providerConfigs: [EmailProviderConfiguration()],
                  ),
                );
              } else {
                authCubit.loginStoreAdmin(
                  token: await event.getIdToken(),
                  onCompleted: (storeAdmin) {
                    print(storeAdmin);
                    _appRouter.pushAndPopUntil(
                      const HomeRoute(),
                      predicate: (_) => false,
                    );
                  },
                  onError: (message) {
                    authCubit.signOut();
                  },
                );
              }
            }),
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
            themeMode: state.themeMode,
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
