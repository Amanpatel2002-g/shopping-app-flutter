// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../services/auth_service.dart';
import '../../../widgets/auth_widgets/custom_button.dart';
import '../../../widgets/auth_widgets/text_input_filed.dart';

enum Auth {
  signin,
  signup,
}

// ignore: must_be_immutable
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String routeName = '/auth-screen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // ignore: unused_field
  final AuthServices authServices = AuthServices();
  Auth _auth = Auth.signup;

  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();

  void signUp(BuildContext context) {
    authServices.signUp(
        context: context,
        name: _nameEditingController.text,
        email: _emailEditingController.text,
        password: _passwordEditingController.text);
  }

  void signIn(BuildContext context) {
    authServices.signIn(
        context: context,
        email: _emailEditingController.text,
        password: _passwordEditingController.text);
  }

  TextEditingController _nameEditingController = TextEditingController();

  TextEditingController _emailEditingController = TextEditingController();

  TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String welcomeString = "Welcome";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                welcomeString,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? value) {
                    _auth = value!;
                    setState(() {});
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                      key: _signupFormKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          TextInputField(
                              textEditingController: _nameEditingController,
                              hinttext: "name"),
                          const SizedBox(height: 10),
                          TextInputField(
                              textEditingController: _emailEditingController,
                              hinttext: "Email"),
                          const SizedBox(height: 10),
                          TextInputField(
                              textEditingController: _passwordEditingController,
                              hinttext: "password"),
                          const SizedBox(height: 10),
                          CustomButton(
                              text: "Create Account",
                              ontap: () {
                                if (_signupFormKey.currentState!.validate()) {
                                  signUp(context);
                                }
                              }),
                          const SizedBox(height: 10),
                        ],
                      )),
                ),

              /// --------------------------------------------signin page----------------------------------------------
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Signin',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? value) {
                    _auth = value!;
                    setState(() {});
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                      key: _signinFormKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          TextInputField(
                              textEditingController: _emailEditingController,
                              hinttext: "Email"),
                          const SizedBox(height: 10),
                          TextInputField(
                              textEditingController: _passwordEditingController,
                              hinttext: "password"),
                          const SizedBox(height: 10),
                          CustomButton(
                              text: "SignIn",
                              ontap: () {
                                if (_signinFormKey.currentState!.validate()) {
                                  signIn(context);
                                }
                              }),
                          const SizedBox(height: 10),
                        ],
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
