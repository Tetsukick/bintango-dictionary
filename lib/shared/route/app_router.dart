// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter

import 'dart:developer';

import 'package:bintango_indonesian_dictionary/app/widget/app_start_page.dart';
import 'package:bintango_indonesian_dictionary/feature/auth/widget/sign_in_page.dart';
import 'package:bintango_indonesian_dictionary/feature/auth/widget/sign_up_page.dart';
import 'package:bintango_indonesian_dictionary/feature/dictionary_detail/widget/dictionary_detail_page.dart';
import 'package:bintango_indonesian_dictionary/feature/error/widget/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(RouterRef ref) {
  //final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}

@TypedGoRoute<AppRoute>(path: AppRoute.path)
class AppRoute extends GoRouteData {
  const AppRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppStartPage();
  }
}

@TypedGoRoute<DictionaryDetailRoute>(path: DictionaryDetailRoute.path)
class DictionaryDetailRoute extends GoRouteData {
  const DictionaryDetailRoute(this.searchWord);

  static const path = '/dictionary/detail/:searchWord';

  final String searchWord;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // final searchWordInPath = state.pathParameters['searchWord'];
    log('searchWord from path: $searchWord');
    return DictionaryDetailPage(searchWord: searchWord);
  }
}

@TypedGoRoute<SignInRoute>(path: SignInRoute.path)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  static const path = '/signIn';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignInPage();
  }
}

@TypedGoRoute<SignUpRoute>(path: SignUpRoute.path)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  static const path = '/signUp';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignUpPage();
  }
}

class GoNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did push route $route : $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did pop route $route : $previousRoute');
  }
}
