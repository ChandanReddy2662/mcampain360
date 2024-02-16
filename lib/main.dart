import 'package:flutter/material.dart';
import 'package:myapp/screens/login.dart';

// import 'asserts';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aridnik Share',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(173, 216, 230, 1),
        ),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}