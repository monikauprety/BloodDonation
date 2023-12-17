//  Dart 3.1
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Authentication/LoginUser.dart';
import 'firebase_options.dart';
import 'provider/themeChangerPRovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => themeChangerProvider())
        ],
        child: Builder(
          builder: (BuildContext context) {
            final themeChanger = Provider.of<themeChangerProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: themeChanger.thememode,
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.red,
              ),
              darkTheme: ThemeData(
                  iconTheme: IconThemeData(color: Colors.red),
                  brightness: Brightness.dark,
                  primarySwatch: Colors.yellow,
                  appBarTheme: AppBarTheme(color: Colors.blue)),
              home: LoginPage(),
            );
          },
        ));
  }
}
