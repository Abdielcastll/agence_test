import 'package:flutter/material.dart';
import 'package:test_app/app/domain/model/products.dart';
import 'package:test_app/app/view/home/home_page.dart';
import 'package:test_app/app/view/login/login_page.dart';
import 'package:test_app/app/view/product/product_page.dart';
import 'package:test_app/app/view/splash/splash_page.dart';

abstract class AppRouter {
  static String get initialPage => SplashPage.route;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.route:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => SplashPage.create(),
        );
      case LoginPage.route:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => LoginPage.create(),
        );

      case HomePage.route:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => HomePage.create(),
        );
      case ProductPage.route:
        Products? product = settings.arguments as Products?;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => ProductPage.create(product!),
        );

      default:
        throw Exception('Page ${settings.name} does not exists');
    }
  }
}
