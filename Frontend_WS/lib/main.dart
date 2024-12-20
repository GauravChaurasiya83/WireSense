import 'package:flutter/material.dart';

import 'common/AppRoutes/app_routes_handling.dart';
import 'common/services/global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WireSense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => appPages.generateRouteSettings(settings),
      navigatorKey: navKey,
    );
  }
}
