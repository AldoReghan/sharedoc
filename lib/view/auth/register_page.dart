import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:sharedoc/core/entity/Users.dart';
import 'package:sharedoc/core/services/users_services.dart';
import 'package:sharedoc/view/auth/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Register Page',
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _value = 0;

  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  TextEditingController namadepanController = TextEditingController();
  TextEditingController namabelakangController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypepasswordController = TextEditingController();

  final snackBar = const SnackBar(
    content: Text('Registrasi Berhasil'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 210,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 25.0, right: 16),
                      child: TextField(
                        controller: namadepanController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person), hintText: "Nama Depan"),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 25.0, right: 16),
                      child: TextField(
                        controller: namabelakangController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: "Nama Belakang"),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 25.0, right: 16),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            focusColor: Color.fromARGB(255, 10, 56, 11),
                            icon: Icon(Icons.email),
                            hintText: "Email"),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 25.0, right: 16),
                      child: TextField(
                        controller: notelpController,
                        decoration: const InputDecoration(
                            focusColor: Color.fromARGB(255, 10, 56, 11),
                            icon: Icon(Icons.phone),
                            hintText: "Nomor Telepon"),
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
                      child: TextField(
                        controller: retypepasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            focusColor: Colors.blue,
                            icon: Icon(Icons.lock),
                            hintText: "Konfirmasi Password"),
                      )),
                  const Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, top: 25.0, right: 16),
                      child: Text(
                        "Daftar Sebagai : ",
                        style: TextStyle(fontSize: 16),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as int;
                                    });
                                  }),
                              const Text("Pasien"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as int;
                                    });
                                  }),
                              const Text("Dokter"),
                            ],
                          ),
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 25.0, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        context.read<UserServices>().signUp(Users(
                            namadepanController.text,
                            namabelakangController.text,
                            emailController.text,
                            notelpController.text,
                            passwordController.text,
                            _value));

                        namadepanController.text = "";
                        namabelakangController.text = "";
                        emailController.text = "";
                        notelpController.text = "";
                        passwordController.text = "";
                        retypepasswordController.text = "";
                        _value = 0;

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                          const Text("Sudah punya akun? ",
                              style: TextStyle(fontSize: 16)),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage())),
                            child: const Text("Login",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
