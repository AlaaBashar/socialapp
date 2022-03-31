import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'export_feature.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    ChangeNotifierProvider<Counter>(
      create: (_) => Counter(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<Counter>().isDark ? ThemeData.dark() : ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}
