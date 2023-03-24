import 'package:dogs_breeds/models/CustomProvider.dart';
import 'package:dogs_breeds/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/screens/breeds_list_view.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'view/screens/single_breed_view.dart';

void main(List<String> args) {
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return ChangeNotifierProvider(
        create: (context) => CustomProvider() ,
        child: CupertinoApp.router(title: "Breeds",
          routerConfig: _router,
        ),
      );
    } else {
      return ChangeNotifierProvider(create: (context) => CustomProvider(),
        child: MaterialApp.router(title: "Breeds",
          routerConfig: _router,
        ),
      );
    }
  }

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: AppRoutes.home,
        path: AppRoutes.home,
        builder: (context, state) => const BreedsListView(),
        routes: [
          GoRoute(
            name:AppRoutes.specifBreed,
            path: "${AppRoutes.specifBreed}/:name",
            builder: (context, state) => SingleBreedView(name: state.params["name"] ?? ""),
          )
        ],
      ),
    ],
  );
}