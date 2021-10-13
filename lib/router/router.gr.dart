// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:younmin/presentation/home/home.dart' as _i1;
import 'package:younmin/presentation/login/login.dart' as _i2;
import 'package:younmin/presentation/main/main_page.dart' as _i5;
import 'package:younmin/presentation/sign_up/sign_up.dart' as _i3;
import 'package:younmin/presentation/yearlyTodo/yearly_todo.dart' as _i4;

class YounminRouter extends _i6.RootStackRouter {
  YounminRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.Home());
    },
    LoginRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.Login());
    },
    SignUpRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SignUp());
    },
    YearlyTodoRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.YearlyTodo());
    },
    MainPageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.MainPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(HomeRoute.name, path: '/'),
        _i6.RouteConfig(LoginRoute.name, path: '/login'),
        _i6.RouteConfig(SignUpRoute.name, path: '/signUp'),
        _i6.RouteConfig(YearlyTodoRoute.name, path: '/yearlyTodo'),
        _i6.RouteConfig(MainPageRoute.name, path: '/main')
      ];
}

/// generated route for [_i1.Home]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.Login]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for [_i3.SignUp]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute() : super(name, path: '/signUp');

  static const String name = 'SignUpRoute';
}

/// generated route for [_i4.YearlyTodo]
class YearlyTodoRoute extends _i6.PageRouteInfo<void> {
  const YearlyTodoRoute() : super(name, path: '/yearlyTodo');

  static const String name = 'YearlyTodoRoute';
}

/// generated route for [_i5.MainPage]
class MainPageRoute extends _i6.PageRouteInfo<void> {
  const MainPageRoute() : super(name, path: '/main');

  static const String name = 'MainPageRoute';
}
