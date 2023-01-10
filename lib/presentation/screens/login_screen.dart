import 'package:ecommerce_app/utils/user_simple_preference.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:ecommerce_app/services/api_service.dart';
import 'package:ecommerce_app/presentation/screens/home_screen.dart';

import 'cart_screen.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ApiService get service => GetIt.I<ApiService>();

  String username = '';

  String password = '';

 // ApiService service = ApiService();
  final TextEditingController usernameCtrl =
      TextEditingController(
       //   text: 'mor_2314'
      );

  final TextEditingController passwordCtrl =
      TextEditingController(
       //   text: '83r5^_'
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    username = UserSimplePreference.getUsername() ?? '';
    password = UserSimplePreference.getPassword() ?? '';
   print("username1: $username");
   print("password1: $password");
  }

  // void fetchLoginDetails() async{
  //   username = UserSimplePreference.getUsername() ?? '';
  //   password = UserSimplePreference.getPassword() ?? '';
  // }

  // void saveLoginDetails() async{
  //   await UserSimplePreference.setUsername(username);
  //   await UserSimplePreference.setPassword(password);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter FakeStore '),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(
                  labelText: 'Username', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  await UserSimplePreference.setUsername(username);
                  await UserSimplePreference.setPassword(password);
                  final getToken =
                      await service.login(usernameCtrl.text, passwordCtrl.text);
                  if (getToken != null && getToken['token'] != null) {
                    print("username2:$username");
                    print("password2:$password");
                   // saveLoginDetails();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Successfully logged in'),
                      backgroundColor: Colors.green,
                    ));
                    Future.delayed(
                        Duration(seconds: 2),
                        () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen())));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Incorrect Username or Password'),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
