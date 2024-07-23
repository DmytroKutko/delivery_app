import 'package:delivery_app/feature/auth/presentation/pages/login_page.dart';
import 'package:delivery_app/feature/auth/presentation/pages/register_page.dart';
import 'package:delivery_app/feature/cart/presentation/pages/cart_page.dart';
import 'package:delivery_app/feature/home/presentation/pages/edit_profile_page.dart';
import 'package:delivery_app/feature/home/presentation/pages/home_page.dart';
import 'package:delivery_app/feature/product/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  static final router = GoRouter(
    initialLocation: "/login",
    errorPageBuilder: (context, state) =>
        MaterialPage(child: Text('Error: ${state.error}')),
    routes: <RouteBase>[
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomePage(index: 0);
        },
      ),
      GoRoute(
        path: "/home/:index",
        builder: (context, state) {
          final String? indexStr = state.pathParameters['index'];
          final int index = int.tryParse(indexStr ?? '') ?? 0;
          return HomePage(index: index);
        },
      ),
      GoRoute(
        path: "/cart",
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: "/edit_profile",
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
          path: "/product/:type/:title",
          builder: (context, state) {
            final type = state.pathParameters['type']!;
            final title = state.pathParameters['title']!;
            return ProductPage(type: type, title: title);
          }),
    ],
  );
}
