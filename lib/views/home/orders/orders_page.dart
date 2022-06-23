import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_store/bloc/auth/auth_cubit.dart';
import 'package:flutter_restaurant_store/bloc/order/orders/orders_cubit.dart';
import 'package:flutter_restaurant_store/injection.dart';
import 'package:flutter_restaurant_store/views/core/widgets/need_completion_widget.dart';
import 'package:flutter_restaurant_store/views/core/widgets/unauthorised_widget.dart';
import 'package:flutter_restaurant_store/views/home/orders/orders_body.dart';

class OrdersPage extends StatelessWidget implements AutoRouteWrapper {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrdersCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: BlocSelector<AuthCubit, AuthState, AuthStatus>(
        selector: (state) => state.authStatus,
        builder: (context, authStatus) {
          switch (authStatus) {
            case AuthStatus.authorised:
              return const OrdersBody();
            case AuthStatus.unauthorised:
              return const UnauthorisedWidget();
            case AuthStatus.needCompletion:
              return const NeedCompletionWidget();
          }
        },
      ),
    );
  }
}
