import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:light_notes/bloc/bloc/auth_bloc.dart';
import 'package:light_notes/view/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: "HSI Notes",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "inter"),
        home: LoginPage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
