import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sharedoc/core/services/users_services.dart';
import 'package:sharedoc/view/auth/register_page.dart';
import 'package:sharedoc/view/home_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _key,
        child: Container(
          color: Colors.blue,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              const Positioned(
                top: 90,
                left: 20,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Positioned(
                top: 170,
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 25.0, right: 16),
                            child: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.email), hintText: "Email"),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 25.0, right: 16),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  focusColor: Colors.blue,
                                  icon: Icon(Icons.lock),
                                  hintText: "Password"),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 25.0, right: 16),
                          child: GestureDetector(
                            onTap: () {
                              context.read<UserServices>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 25.0, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Belum punya akun? ",
                                    style: TextStyle(fontSize: 16)),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage())),
                                  child: const Text("Register",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            )),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
