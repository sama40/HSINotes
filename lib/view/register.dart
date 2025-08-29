import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';
import 'package:light_notes/bloc/bloc/auth_bloc.dart';
import 'package:light_notes/components/regular_text.dart';
import 'package:light_notes/enum/status_enum.dart';
import 'package:light_notes/view/home.dart';
import 'package:light_notes/view/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          Navigator.pop(
            context,
            HomePage.routeName,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          shape: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          leadingWidth: 100,
          leading: TextButton.icon(
            label: Text("Back"),
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
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
                        text: "Register",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10),
                      RegularText(text: "And start taking notes", fontSize: 14),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RegularText(
                        text: "Full Name",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: nameController,
                        validator: ValidationBuilder().minLength(3).build(),
                        decoration: InputDecoration(
                          hintText: 'Example: John Doe',
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
                        text: "Email Address",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        validator: ValidationBuilder().email().build(),
                        decoration: InputDecoration(
                          hintText: 'example : johndoe@gmail.com',
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
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: ValidationBuilder().minLength(8).build(),
                        decoration: InputDecoration(
                          hintText: '*********',
                          labelStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<AuthBloc>().add(
                              RegisterAuthEvent(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          } else {
                            EasyLoading.showToast('Data belum lengkap!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 13, 2, 93),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "lready have an account? Login here",
                                style: TextStyle(color: Colors.indigo),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
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
