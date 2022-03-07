import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/log_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_office/screens/verificare_cont_special.dart';
import 'screens/admin/user_search _screen.dart';
import 'screens/admin/building_search _screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The office',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        "/first": (context) => UserSearchScreen(),
        "/second": (context) => BuildingSearchScreen(),
      },
      //verific daca userul a fost logat deja
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return VerificareContSpecial();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return LogInScreen();
          }),
    );
  }
}
