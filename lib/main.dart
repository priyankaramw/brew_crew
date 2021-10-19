import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      catchError: (context, error) => null,
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
