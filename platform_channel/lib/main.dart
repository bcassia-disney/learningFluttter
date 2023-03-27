import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/utils/routes.dart';
import 'views/screens/breeds_screen.dart';
import 'views/screens/single_breed_view.dart';


void main(List<String> args) {
  usePathUrlStrategy();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(title: "Breeds",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)),
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: AppRoutes.home,
        path: AppRoutes.home,
        builder: (context, state) => BreedsScreen(),
        routes: [
          GoRoute(
            name:AppRoutes.specificBreed,
            path: "${AppRoutes.specificBreed}/:name",
            builder: (context, state) => SingleBreedView(name: state.params["name"] ?? ""),
          )
        ],
      ),
    ],
  );
}