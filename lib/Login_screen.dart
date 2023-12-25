import 'package:gradutionprojec/Admin/admin_login.dart';
import 'package:gradutionprojec/screens/home/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/data.dart';
import 'Register_screen.dart';
import 'default_textformfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isEmailorPasswordWrong = false;

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController userName = TextEditingController();

  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/Home/Home.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          defaultTextFormField(
                            hintText: 'Email',
                            fieldonChange: (value) {
                              formKey.currentState!.validate();
                            },
                            icon: Icons.email_outlined,
                            color: Colors.orangeAccent,
                            Type: TextInputType.emailAddress,
                            controller: email,
                            fieldValidator: (Email) {
                              if (Email.isEmpty) {
                                return 'Enter a Email';
                              } else if (Email != null &&
                                  !EmailValidator.validate(Email)) {
                                return 'Enter a Valid Email';
                              } else {
                                isEmailorPasswordWrong = false;
                                setState(() {});
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          defaultTextFormField(
                            hintText: 'Password',
                            fieldonChange: (value) {
                              formKey.currentState!.validate();
                            },
                            icon: Icons.lock,
                            color: Colors.orangeAccent,
                            obscureText: true,
                            Type: TextInputType.visiblePassword,
                            controller: password,
                            fieldValidator: (Password) {
                              if (Password.isEmpty) {
                                return 'Enter a Password';
                              } else if (Password != null &&
                                  Password.length < 6) {
                                return 'Enter a Valid Password';
                              } else {
                                isEmailorPasswordWrong = false;
                                setState(() {});
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Visibility(
                              visible: isEmailorPasswordWrong,
                              child: const Text(
                                'Either Email or Password are wrong',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'forget');
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  colors: <Color>[
                                    Color(0xffff5983),
                                    Colors.orangeAccent,
                                  ],
                                )),
                            child: MaterialButton(
                              onPressed: () async {
                                try {
                                  final validForm =
                                      formKey.currentState!.validate();
                                  if (validForm) {
                                    final User =
                                        await auth.signInWithEmailAndPassword(
                                            email: email.text,
                                            password: password.text);
                                    //  print(email.text.toString());
                                    name = email.text.toString();
                                    // Reviewes(email.text.toString());
                                    isEmailorPasswordWrong = false;
                                    setState(() {});
                                    FirebaseAuth.instance
                                        .setPersistence(Persistence.LOCAL);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  }
                                } catch (e) {
                                  print(e);
                                  print("error in login");
                                  isEmailorPasswordWrong = true;
                                  setState(() {});
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an Account ? ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.orangeAccent,
                                    ),
                                  )),
                            ],
                          ),
                          // TextButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   const AdminSignIScreen()));
                          //     },
                          //     child: const Text(
                          //       'Login as an Admin ',
                          //       style: TextStyle(
                          //         fontSize: 20,
                          //         color: Colors.orangeAccent,
                          //       ),
                          //     )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
