import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sharedoc/core/services/konsultasi_services.dart';
import 'package:sharedoc/core/services/news_servicces.dart';
import 'package:sharedoc/core/services/users_services.dart';
import 'package:sharedoc/view/auth/authwrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<UserServices>(
        //     create: (_) => UserServices(FirebaseAuth.instance)),
        ChangeNotifierProvider(
            create: (_) => UserServices(FirebaseAuth.instance)),
        ChangeNotifierProvider(create: (_) => NewsServices()),
        ChangeNotifierProvider(create: (_) => PertanyaanProvider()),
        StreamProvider(
            create: (context) => context.read<UserServices>().authStreamChanges,
            initialData: null)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}
