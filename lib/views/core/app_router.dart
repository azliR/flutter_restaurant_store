import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_restaurant_store/views/home/account/account_page.dart';
import 'package:flutter_restaurant_store/views/home/home_page.dart';
import 'package:flutter_restaurant_store/views/home/manage/manage_page.dart';
import 'package:flutter_restaurant_store/views/home/orders/orders_page.dart';
import 'package:flutter_restaurant_store/views/home/report/report_page.dart';
import 'package:flutter_restaurant_store/views/splash/splash_page.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: SplashPage,
    ),
    AutoRoute(
      path: '/home',
      page: HomePage,
      children: [
        AutoRoute(
          path: 'orders',
          page: EmptyRouterPage,
          name: 'OrdersWrapperRoute',
          children: [
            AutoRoute(path: '', page: OrdersPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'manage',
          page: EmptyRouterPage,
          name: 'ManageWrapperRoute',
          children: [
            AutoRoute(path: '', page: ManagePage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'report',
          page: EmptyRouterPage,
          name: 'ReportWrapperRoute',
          children: [
            AutoRoute(path: '', page: ReportPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'account',
          page: EmptyRouterPage,
          name: 'AccountWrapperRoute',
          children: [
            AutoRoute(path: '', page: AccountPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: 'overview'),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class AppRouter extends _$AppRouter {}
