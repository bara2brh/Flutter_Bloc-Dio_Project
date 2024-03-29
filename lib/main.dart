import 'package:bloc_pattern_api_practice/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( RickAndMortyApp(appRouter: AppRoutes(),));
}

class RickAndMortyApp extends StatelessWidget {
  final AppRoutes appRouter;
  const RickAndMortyApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
