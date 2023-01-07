import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:ecommerce_app/services/api_service.dart';
import 'package:ecommerce_app/presentation/screens/home_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  ApiService get service => GetIt.I<ApiService>();

 // ApiService service = ApiService();
  final TextEditingController usernameCtrl =
      TextEditingController(text: 'mor_2314');
  final TextEditingController passwordCtrl =
      TextEditingController(text: '83r5^_');

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
                  final getToken =
                      await service.login(usernameCtrl.text, passwordCtrl.text);

                  if (getToken != null && getToken['token'] != null) {
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
