import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:email_validator/email_validator.dart';
import 'package:gradutionprojec/noti_service.dart';
import 'package:gradutionprojec/user_model.dart';

import 'Login_screen.dart';
import 'data/data.dart';
import 'default_textformfield.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class RegisterScreen extends StatefulWidget {
  static String verificationID = "";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ignore: non_constant_identifier_names
  bool ValidatePassword(String pass) {
    String password = pass.trim();
    Future.delayed(Duration.zero, () {
      if (password.isEmpty) {
        setState(() {
          password_strength = 0;
        });
      } else if (password.length < 6) {
        setState(() {
          password_strength = 1 / 4;
        });
      } else if (password.length < 8) {
        setState(() {
          password_strength = 2 / 4;
        });
      } else {
        if (passwordValid.hasMatch(password)) {
          setState(() {
            password_strength = 4 / 4;
          });
          return true;
        } else {
          setState(() {
            password_strength = 3 / 4;
          });
          return false;
        }
      }
    });
    if (password_strength == 1) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formKey,
                        child: Column(
                          children: [
                            defaultTextFormField(
                                hintText: 'User Name ',
                                icon: Icons.person,
                                color: Colors.orangeAccent,
                                Type: TextInputType.emailAddress,
                                controller: userName,
                                fieldonChange: (value) {
                                  formKey.currentState!.validate();
                                },
                                fieldValidator: (username) {
                                  if (username.isEmpty) {
                                    return 'Enter a username';
                                  } else if (username.length != null &&
                                      username.length < 7) {
                                    return 'User name is too short';
                                  }
                                }),
                            const SizedBox(
                              height: 35,
                            ),
                            defaultTextFormField(
                                hintText: 'Email',
                                icon: Icons.email_outlined,
                                color: Colors.orangeAccent,
                                Type: TextInputType.emailAddress,
                                controller: email,
                                fieldonChange: (value) {
                                  formKey.currentState!.validate();
                                },
                                // ignore: non_constant_identifier_names
                                fieldValidator: (Email) {
                                  if (Email.isEmpty) {
                                    return 'Enter a Email';
                                  } else if (Email != null &&
                                      !EmailValidator.validate(Email)) {
                                    return 'Enter a Valid Email';
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(
                              height: 35,
                            ),
                            defaultTextFormField(
                                hintText: 'Password',
                                icon: Icons.lock,
                                color: Colors.orangeAccent,
                                obscureText: true,
                                controller: password,
                                fieldonChange: (value) {
                                  formKey.currentState!.validate();
                                },
                                fieldValidator: (value) {
                                  if (value!.isEmpty) {
                                    return ' please enter a password ';
                                  } else {
                                    //call function to check password
                                    bool result = ValidatePassword(value);
                                    print(result);
                                    if (result == true) {
                                      return null;
                                    } else {
                                      return 'password should contain capital , small letter & number and special character ';
                                    }
                                  }
                                }),
                            const SizedBox(
                              height: 35,
                            ),
                            defaultTextFormField(
                                hintText: 'Phone Number',
                                icon: Icons.phone,
                                color: Colors.orangeAccent,
                                obscureText: false,
                                controller: PhoneNumber,
                                fieldonChange: (value) {
                                  formKey.currentState!.validate();
                                },
                                fieldValidator: (value) {
                                  if (value!.isEmpty) {
                                    return ' please enter a phone number ';
                                  } else {
                                    if (value.toString().length == 11) {
                                      return null;
                                    } else {
                                      return 'phone number is not valid';
                                    }
                                  }
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            password.text.isEmpty
                                ? const SizedBox()
                                : const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Password Strength',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )),
                            const SizedBox(
                              height: 15,
                            ),
                            password.text.isEmpty
                                ? const SizedBox()
                                : LinearProgressIndicator(
                                    value: password_strength,
                                    minHeight: 5,
                                    backgroundColor: Colors.white,
                                    color: password_strength <= 1 / 4
                                        ? Colors.red
                                        : password_strength == 2 / 4
                                            ? Colors.yellow
                                            : password_strength == 3 / 4
                                                ? Colors.orange
                                                : Colors.green,
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
                                      // final NewUser = await auth
                                      //     .createUserWithEmailAndPassword(
                                      //     email: email.text,
                                      //     password: password.text);

                                      // print("created new user");
                                      final user = UserModel(
                                        Name: userName.text.trim(),
                                        Email: email.text.trim(),
                                        Password: password.text.trim(),
                                        Phone: PhoneNumber.text.trim(),
                                      );

                                      createUser(user);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                      // phoneAuthentication(user.Phone.trim());
                                    }
                                  } catch (e) {
                                    if (e.toString() ==
                                        "[firebase_auth/unknown] Given String is empty or null") {
                                      print("*$e");
                                    }
                                    print(e);
                                  }
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
                                  'Already have an Account ? ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orangeAccent,
                                      ),
                                    )),
                              ],
                            ),
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
      ),
    );
  }

  final db = FirebaseFirestore.instance;
  createUser(UserModel user) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.Email,
      password: user.Password,
    );
    await sendWelcomeEmail(user.Email);
  }

  Future<void> sendWelcomeEmail(String recipient) async {
    String username =
        'muhammadshafiq457@gmail.com'; // Use environment variables or a config file
    String password =
        'elonhuoirgvdeedc'; // Use environment variables or a config file

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Smart Furniture')
      ..recipients.add(recipient)
      ..subject = 'Welcome to Our App! ${DateTime.now()}'
      ..text = 'Hello! Thank you for registering.'
      ..html = "<h1>Welcome</h1><p>Thanks for registering to our app!</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Email Sent'),
            content: Text('A welcome email has been sent to $recipient.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  void phoneAuthentication(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: PhoneNumber.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // Get.snackbar('Error', 'the provided phone number is not valid');
          print("the provided phone number is not valid");
        }
        // else{
        //   Get.snackbar('Error', 'something went wrong try again ');
        //
        // }
      },
      codeSent: (String verificationId, int? resendToken) {
        RegisterScreen.verificationID = verificationId;
        Navigator.pushNamed(context, "otp");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
