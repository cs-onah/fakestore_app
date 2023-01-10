import 'package:ecommerce_app/presentation/screens/login_screen.dart';
import 'package:ecommerce_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerce_app/utils/user_simple_preference.dart';


void setupLocator(){
  GetIt.I.registerLazySingleton(() => ApiService());
}
 Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await UserSimplePreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginScreen(),
    );
  }
}
