import 'package:flutter/material.dart';
import 'package:note_app_clone/di/di_setup.dart';
import 'package:note_app_clone/routes.dart';
import 'package:note_app_clone/ui/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
        primaryColor: Colors.white,
        canvasColor: darkGray,
        floatingActionButtonTheme:
            Theme.of(context).floatingActionButtonTheme.copyWith(
                  backgroundColor: Colors.white,
                  foregroundColor: darkGray,
                ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: darkGray,
            ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white
        ),
      ),
    );
  }
}