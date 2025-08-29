import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';
import 'package:light_notes/bloc/bloc/auth_bloc.dart';
import 'package:light_notes/components/regular_text.dart';
import 'package:light_notes/enum/status_enum.dart';
import 'package:light_notes/view/home.dart';
import 'package:light_notes/view/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final notesBox = Hive.box<Note>('notes');
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == StatusEnum.loading) {
          EasyLoading.show(status: 'Loading...');
        }
        if (state.status == StatusEnum.failure) {
          EasyLoading.showToast(state.error.toString());
        }
        if (state.status == StatusEnum.success) {
          EasyLoading.dismiss();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          // }
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RegularText(
                        text: "Let's Login",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10),
                      RegularText(text: "And notes your idea", fontSize: 14),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RegularText(
                        text: "Email Address",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        validator: ValidationBuilder().email().build(),
                        decoration: InputDecoration(
                          hintText: 'example@gmail.com',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      RegularText(
                        text: "Password",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: passwordController,
                        validator: ValidationBuilder().minLength(8).build(),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '*********',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<AuthBloc>().add(
                              LoginAuthEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          } else {
                            EasyLoading.showToast('User atau password salah!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 13, 2, 93),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have any account? Register here",
                                style: TextStyle(color: Colors.indigo),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
