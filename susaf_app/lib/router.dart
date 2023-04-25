import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:susaf_app/navbar.dart';
import 'package:susaf_app/page/about_page.dart';
import 'package:susaf_app/page/pentagon_page.dart';
import 'package:susaf_app/page/project_detail_page.dart';
import 'package:susaf_app/page/project_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

/// The route configuration.
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ResponsiveNavBarPage(child: child);
      },
      routes: [
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
              routes: [
                GoRoute(
                  path: ':projectId',
                  builder: (context, state) => ProjectDetailPage(
                    projectId: int.parse(state.params['projectId'] ?? '1'),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'pentagon',
              builder: (BuildContext context, GoRouterState state) {
                return const PentagonPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
