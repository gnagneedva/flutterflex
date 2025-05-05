import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflix/repositories/data_repository.dart';
import 'package:flutterflix/ui/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔒 Bloque la rotation en mode portrait uniquement
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // optionnel
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataRepository(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterFlix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoadingScreen(),
    );
  }
}
