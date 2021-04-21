import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ht/blocs/auth_bloc.dart';
import 'package:ht/blocs/auth_state.dart';
import 'package:ht/pages/login_page.dart';
import 'package:ht/repository/auth_repo.dart';
import 'package:ht/ui/get_contacts.dart';
import 'package:ht/ui/post_contacts.dart';

void main() {
  runApp(Auth());
}

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(LoginInitState(), AuthRepository()))
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => LoginPage(),
          'contacts': (context) => Contact(),
          'addContact': (context) => AddContacts()
        },
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordpress Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}
