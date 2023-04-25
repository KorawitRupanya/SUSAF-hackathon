import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:susaf_app/page/about_page.dart';
import 'package:susaf_app/page/project_page.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ProjectPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'about',
          builder: (BuildContext context, GoRouterState state) {
            return const AboutPage();
          },
        ),
        GoRoute(
          path: 'projects',
          builder: (BuildContext context, GoRouterState state) {
            return const ProjectPage();
          },
        ),
      ],
    ),
  ],
);
