import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


import 'models/user_manager.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> UserManager(),
      lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EcoShop',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 227, 102, 15),
            )
          ),
          primaryColor: const Color.fromARGB(255, 227, 102, 15),
          scaffoldBackgroundColor: const Color.fromARGB(255, 246, 131, 55),
          appBarTheme: const AppBarTheme(
              elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen()
              );
            case '/base':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen()
              );
          }
        },
        home: BaseScreen(),

      ),
    );
  }
}

