import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Users/provider/user_provider.dart';
import 'package:gameon/Users/views/Screens/auth/signup_screen.dart';
import 'package:gameon/Users/views/Screens/auth/widget/custom_textformfield.dart';
import 'package:gameon/Users/views/ui_components/bottom%20navigation/nav_appbar_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              fit: StackFit.loose,
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.13,
                  left: 0,
                  child: LayoutBuilder(
                    builder: (context, constraints) => ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight,
                        maxWidth: constraints.maxWidth,
                      ),
                      child: Image.asset(
                        'assets/images/auth/bdagola.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/auth/chotagola.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 42,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          color: Color(0xff3C3535),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      CustomTextFormField(
                        hintText: 'Email or Phone Number',
                        controller: _emailTextController,
                        icon: const Icon(Icons.account_circle_outlined),
                        showPasswordIcon: false,
                        maxlength: 100,
                        isSpecialCharacter: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.022,
                      ),
                      CustomTextFormField(
                        hintText: 'Password',
                        controller: _passwordTextController,
                        icon: const Icon(Icons.lock_outline),
                        showPasswordIcon: true,
                        isObscured: true,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Text(
                            'Forgot Your Password?',
                            style: TextStyle(
                              shadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.28),
                                  offset: const Offset(
                                    5.0,
                                    5.0,
                                  ),
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                              fontFamily: 'Inter',
                              fontSize: 18,
                              color: const Color(0xffBCBCBC),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.05,
                          right: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Color(0xff3C3535),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.22,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: const <Color>[
                                    Color.fromARGB(255, 218, 34, 255),
                                    Color.fromARGB(255, 151, 51, 238),
                                  ],
                                  stops: const <double>[0, 1],
                                  begin: Alignment(0, -1),
                                  end: Alignment(0, 1),
                                ),
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    size: MediaQuery.of(context).size.width *
                                        0.09,
                                    Icons.trending_flat,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    String input =
                                        _emailTextController.text.trim();
                                    String password =
                                        _passwordTextController.text.trim();

                                    if (input.isEmpty || password.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please fill in all fields")),
                                      );
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => Center(
                                          child: CircularProgressIndicator()),
                                    );

                                    try {
                                      String email = input;

                                      // If input is a phone number, look up the associated email
                                      if (!input.contains('@')) {
                                        QuerySnapshot phoneSnapshot =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .where('phone',
                                                    isEqualTo: input)
                                                .get();

                                        if (phoneSnapshot.docs.isEmpty) {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Phone number not registered")),
                                          );
                                          return;
                                        }

                                        email =
                                            phoneSnapshot.docs.first['email'];
                                      }

                                      // Sign in with Firebase Auth
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email,
                                                  password: password);

                                      // Optional: Fetch user data
                                      DocumentSnapshot userDoc =
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userCredential.user!.uid)
                                              .get();

                                      String name = userDoc['name'];

                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Welcome back, $name!")),
                                      );
                                      await Provider.of<UserProvider>(context,
                                              listen: false)
                                          .fetchUserData();
                                      // Navigate to Main Page
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MainPage()),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      Navigator.of(context).pop();
                                      String message = "Login failed";
                                      if (e.code == 'user-not-found') {
                                        message =
                                            "No user found with this email";
                                      } else if (e.code == 'wrong-password') {
                                        message = "Incorrect password";
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(message)));
                                    } catch (e) {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text("Error: $e")),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Color(0xff3C3535),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()));
                              },
                              child: Text(
                                'Create',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  color: Color(0xffA32EEB),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
