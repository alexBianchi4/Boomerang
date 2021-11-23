import 'package:app/screens/dashboard/provider_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/authentication/home_page.dart';
import 'package:app/classes/globals.dart';
import 'package:app/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProviderHelper())],
      child: MyApp()));
  // const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
          primarySwatch: theme_colour,
        ),
        home: const HomePage(),
      ),
    );
  }
}
