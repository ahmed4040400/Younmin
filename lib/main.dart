import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/button_styles.dart';
import 'package:younmin/globals/styles/text_styles.dart';

import 'router/router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = YounminRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1800,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: YounminColors.backGroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          primaryColor: YounminColors.primaryColor,
          textTheme: TextTheme(
            headline1: headline1Style,
            headline2: headline2Style,
            headline3: headline3Style,
            headline4: headline4Style,
            bodyText1: body1,
            bodyText2: body2,
          ),
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: elevatedButtonStyle),
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: YounminColors.textFieldColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff666666), width: 1.5),
            ),
          ),
        ),
        routerDelegate: _router.delegate(),
        routeInformationParser: _router.defaultRouteParser(),
      );
    });
  }
}
