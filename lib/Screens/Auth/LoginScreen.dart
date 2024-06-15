import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Screens/HomeScreen.dart';
import 'package:tavanaiadminregistration/Widget/ElevatedButtonModel.dart';
import 'package:tavanaiadminregistration/Widget/TextFieldModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String? errorMessage;
  bool loginSuccess = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 96, 93, 93),
            Color.fromARGB(255, 232, 241, 250),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 45),
                  MyTextFormField(
                    myController: emailController,
                    fieldName: "Email",
                    myIcon: Icons.email_rounded,
                    iconColor: Colors.black,
                    keyboard: TextInputType.emailAddress,
                    errorMessage: "Please enter a correct Email",
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return (errorMessage);
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                  ),
                  const SizedBox(height: 25),
                  MyTextFormField(
                    obscureText: true,
                    myController: passwordController,
                    fieldName: "Password",
                    myIcon: Icons.password_rounded,
                    iconColor: Colors.black,
                    keyboard: TextInputType.visiblePassword,
                    errorMessage: "Please enter a Password",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return (errorMessage);
                      }
                    },
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                  ),
                  const SizedBox(height: 35),
                  MyButton(
                      col3: Colors.grey,
                      col4: Colors.grey,
                      family: 'Roboto',
                      size: 20.0,
                      message: "Login",
                      col1: Colors.black,
                      col2: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // login(emailController.text, passwordController.text);
                          if (emailController.text == 'abbas121@gmail.com' &&
                              passwordController.text == 'abbas121abbas') {
                            Get.to(HomeScreen());
                          }
                        } else {
                          Get.snackbar(
                            "Login Error",
                            "Invalid email or password",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
