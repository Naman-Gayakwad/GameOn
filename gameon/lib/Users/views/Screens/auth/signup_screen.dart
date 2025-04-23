import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Users/provider/user_provider.dart';
import 'package:gameon/Users/views/Screens/auth/signin_screen.dart';
import 'package:gameon/Users/views/Screens/auth/widget/custom_textformfield.dart';
import 'package:gameon/Users/views/ui_components/bottom%20navigation/nav_appbar_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with WidgetsBindingObserver {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
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
                          height: MediaQuery.of(context).size.height * 0.15),
                      Text(
                        'Create accounts!',
                        style: GoogleFonts.jockeyOne(
                          fontSize: 36,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      CustomTextFormField(
                        hintText: 'Name',
                        controller: _nameTextController,
                        icon: const Icon(Icons.account_circle_outlined),
                        showPasswordIcon: false,
                        maxlength: 100,
                        isSpecialCharacter: false,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      CustomTextFormField(
                        hintText: 'Email',
                        controller: _emailTextController,
                        icon: const Icon(Icons.email_outlined),
                        showPasswordIcon: false,
                        maxlength: 100,
                        isSpecialCharacter: false,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      CustomTextFormField(
                        hintText: 'Password',
                        controller: _passwordTextController,
                        icon: const Icon(Icons.lock_outline),
                        showPasswordIcon: true,
                        isObscured: true,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      CustomTextFormField(
                        hintText: 'Phone Number',
                        controller: _phoneTextController,
                        icon: const Icon(Icons.call),
                        showPasswordIcon: false,
                        maxlength: 10,
                        isSpecialCharacter: true,
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
                              'Create',
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
                                    String name =
                                        _nameTextController.text.trim();
                                    String email =
                                        _emailTextController.text.trim();
                                    String phone =
                                        _phoneTextController.text.trim();
                                    String password =
                                        _passwordTextController.text.trim();

                                    if (name.isEmpty ||
                                        email.isEmpty ||
                                        phone.isEmpty ||
                                        password.isEmpty) {
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
                                      // Step 1: Create account with Firebase Auth
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      );

                                      String uid = userCredential.user!.uid;

                                      // Step 2: Store user data in Firestore
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(uid)
                                          .set({
                                        'name': name,
                                        'email': email,
                                        'phone': phone,
                                        'mentor': false,
                                        'userimage': null,
                                        'userId': uid,
                                        'createdAt':
                                            FieldValue.serverTimestamp(),
                                      });
                                      await Provider.of<UserProvider>(context,
                                              listen: false)
                                          .fetchUserData();

                                      Navigator.of(context)
                                          .pop(); // Close loading
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Account created successfully")),
                                      );

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainPage()),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      Navigator.of(context).pop();
                                      String message = "Error occurred";

                                      if (e.code == 'email-already-in-use') {
                                        message =
                                            "This email is already in use";
                                      } else if (e.code == 'weak-password') {
                                        message =
                                            "Password should be at least 6 characters";
                                      }

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(message)));
                                    } catch (e) {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Something went wrong: $e")),
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
                              'Already have an account?',
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
                                        builder: (context) => SignInScreen()));
                              },
                              child: Text(
                                'Sign In',
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
