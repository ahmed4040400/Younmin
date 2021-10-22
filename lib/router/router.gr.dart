// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:cloud_firestore/cloud_firestore.dart' as _i9;
import 'package:flutter/material.dart' as _i8;
import 'package:younmin/presentation/home/home.dart' as _i1;
import 'package:younmin/presentation/login/login.dart' as _i2;
import 'package:younmin/presentation/main/main_page.dart' as _i6;
import 'package:younmin/presentation/questions/questions.dart' as _i5;
import 'package:younmin/presentation/sign_up/sign_up.dart' as _i3;
import 'package:younmin/presentation/yearlyTodo/yearly_todo.dart' as _i4;

class YounminRouter extends _i7.RootStackRouter {
  YounminRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.Home());
    },
    LoginRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.Login());
    },
    SignUpRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SignUp());
    },
    YearlyTodoRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.YearlyTodo());
    },
    QuestionsRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.Questions());
    },
    MainPageRoute.name: (routeData) {
      final args = routeData.argsAs<MainPageRouteArgs>();
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.MainPage(
              key: args.key,
              taskDoc: args.taskDoc,
              taskOrderNum: args.taskOrderNum));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(HomeRoute.name, path: '/'),
        _i7.RouteConfig(LoginRoute.name, path: '/login'),
        _i7.RouteConfig(SignUpRoute.name, path: '/signUp'),
        _i7.RouteConfig(YearlyTodoRoute.name, path: '/yearlyTodo'),
        _i7.RouteConfig(QuestionsRoute.name, path: '/questions'),
        _i7.RouteConfig(MainPageRoute.name, path: '/main')
      ];
}

/// generated route for [_i1.Home]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.Login]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for [_i3.SignUp]
class SignUpRoute extends _i7.PageRouteInfo<void> {
  const SignUpRoute() : super(name, path: '/signUp');

  static const String name = 'SignUpRoute';
}

/// generated route for [_i4.YearlyTodo]
class YearlyTodoRoute extends _i7.PageRouteInfo<void> {
  const YearlyTodoRoute() : super(name, path: '/yearlyTodo');

  static const String name = 'YearlyTodoRoute';
}

/// generated route for [_i5.Questions]
class QuestionsRoute extends _i7.PageRouteInfo<void> {
  const QuestionsRoute() : super(name, path: '/questions');

  static const String name = 'QuestionsRoute';
}

/// generated route for [_i6.MainPage]
class MainPageRoute extends _i7.PageRouteInfo<MainPageRouteArgs> {
  MainPageRoute(
      {_i8.Key? key,
      required _i9.QueryDocumentSnapshot<Map<String, dynamic>> taskDoc,
      required int taskOrderNum})
      : super(name,
            path: '/main',
            args: MainPageRouteArgs(
                key: key, taskDoc: taskDoc, taskOrderNum: taskOrderNum));

  static const String name = 'MainPageRoute';
}

class MainPageRouteArgs {
  const MainPageRouteArgs(
      {this.key, required this.taskDoc, required this.taskOrderNum});

  final _i8.Key? key;

  final _i9.QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  final int taskOrderNum;
}
