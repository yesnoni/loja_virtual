import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:loja_virtual/screens/cart/cart_screen.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserManager(), lazy: false,),
        ChangeNotifierProvider(create: (_) => ProductManager(), lazy: false,),
        ChangeNotifierProvider(create: (_) => HomeManager(), lazy: false,),
        ChangeNotifierProxyProvider<UserManager, CartManager>(create: (_) => CartManager(), update: (_, userManager, cartManager) =>
        cartManager..updateUser(userManager),
          lazy: false,),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EcoShop',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 46, 167, 76),
            )
          ),
          primaryColor: const Color.fromARGB(255, 54, 156, 69),
          scaffoldBackgroundColor: const Color.fromARGB(89, 12, 139, 64),
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
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                    settings.arguments as Product
                  )
              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen()
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

