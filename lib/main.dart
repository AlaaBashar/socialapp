import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/state_management/provider/home.dart';
import 'export_feature.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider<ChangeMode>(
      create: (_) => ChangeMode(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<RegisterProvider>(create: (_) => RegisterProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<EditUserDate>(create: (_) => EditUserDate()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: context.watch<ChangeMode>().isDark ? MyThemeApp.darkMode : MyThemeApp.lightMode,
        home: const SplashScreen(),
      ),
    );
  }
}
