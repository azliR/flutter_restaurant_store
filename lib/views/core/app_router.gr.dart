// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const SplashPage());
    },
    HomeRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: WrappedRoute(child: const HomePage()));
    },
    OrdersWrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    ManageWrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    ReportWrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    AccountWrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    OrdersRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: WrappedRoute(child: const OrdersPage()));
    },
    ManageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const ManagePage());
    },
    ReportRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: WrappedRoute(child: const ReportPage()));
    },
    AccountRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const AccountPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashRoute.name, path: '/'),
        RouteConfig(HomeRoute.name, path: '/home', children: [
          RouteConfig(OrdersWrapperRoute.name,
              path: 'orders',
              parent: HomeRoute.name,
              children: [
                RouteConfig(OrdersRoute.name,
                    path: '', parent: OrdersWrapperRoute.name),
                RouteConfig('*#redirect',
                    path: '*',
                    parent: OrdersWrapperRoute.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          RouteConfig(ManageWrapperRoute.name,
              path: 'manage',
              parent: HomeRoute.name,
              children: [
                RouteConfig(ManageRoute.name,
                    path: '', parent: ManageWrapperRoute.name),
                RouteConfig('*#redirect',
                    path: '*',
                    parent: ManageWrapperRoute.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          RouteConfig(ReportWrapperRoute.name,
              path: 'report',
              parent: HomeRoute.name,
              children: [
                RouteConfig(ReportRoute.name,
                    path: '', parent: ReportWrapperRoute.name),
                RouteConfig('*#redirect',
                    path: '*',
                    parent: ReportWrapperRoute.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          RouteConfig(AccountWrapperRoute.name,
              path: 'account',
              parent: HomeRoute.name,
              children: [
                RouteConfig(AccountRoute.name,
                    path: '', parent: AccountWrapperRoute.name),
                RouteConfig('*#redirect',
                    path: '*',
                    parent: AccountWrapperRoute.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          RouteConfig('*#redirect',
              path: '*',
              parent: HomeRoute.name,
              redirectTo: 'overview',
              fullMatch: true)
        ]),
        RouteConfig('*#redirect', path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [EmptyRouterPage]
class OrdersWrapperRoute extends PageRouteInfo<void> {
  const OrdersWrapperRoute({List<PageRouteInfo>? children})
      : super(OrdersWrapperRoute.name,
            path: 'orders', initialChildren: children);

  static const String name = 'OrdersWrapperRoute';
}

/// generated route for
/// [EmptyRouterPage]
class ManageWrapperRoute extends PageRouteInfo<void> {
  const ManageWrapperRoute({List<PageRouteInfo>? children})
      : super(ManageWrapperRoute.name,
            path: 'manage', initialChildren: children);

  static const String name = 'ManageWrapperRoute';
}

/// generated route for
/// [EmptyRouterPage]
class ReportWrapperRoute extends PageRouteInfo<void> {
  const ReportWrapperRoute({List<PageRouteInfo>? children})
      : super(ReportWrapperRoute.name,
            path: 'report', initialChildren: children);

  static const String name = 'ReportWrapperRoute';
}

/// generated route for
/// [EmptyRouterPage]
class AccountWrapperRoute extends PageRouteInfo<void> {
  const AccountWrapperRoute({List<PageRouteInfo>? children})
      : super(AccountWrapperRoute.name,
            path: 'account', initialChildren: children);

  static const String name = 'AccountWrapperRoute';
}

/// generated route for
/// [OrdersPage]
class OrdersRoute extends PageRouteInfo<void> {
  const OrdersRoute() : super(OrdersRoute.name, path: '');

  static const String name = 'OrdersRoute';
}

/// generated route for
/// [ManagePage]
class ManageRoute extends PageRouteInfo<void> {
  const ManageRoute() : super(ManageRoute.name, path: '');

  static const String name = 'ManageRoute';
}

/// generated route for
/// [ReportPage]
class ReportRoute extends PageRouteInfo<void> {
  const ReportRoute() : super(ReportRoute.name, path: '');

  static const String name = 'ReportRoute';
}

/// generated route for
/// [AccountPage]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute() : super(AccountRoute.name, path: '');

  static const String name = 'AccountRoute';
}
