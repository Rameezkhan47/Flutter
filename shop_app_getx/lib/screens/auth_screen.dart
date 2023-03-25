// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../models/http_exception.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../constants.dart';
import '../controllers/auth_controller.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    final deviceSize = Get.size;
    // final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(children: [
          KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return !isKeyboardVisible
                  ? Lottie.asset(
                      'assets/shop.json',
                      height: deviceSize.height * 0.3,
                      width: deviceSize.width,
                      fit: BoxFit.fill,
                    )
                  : SizedBox(height: deviceSize.height * 0.05);
            },
          ),
          SizedBox(
            height: deviceSize.height * 0.02,
          ),
          const AuthCard(),
        ]),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _errorSnackBar(String message) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      backgroundColor: const Color.fromARGB(255, 66, 66, 66),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      duration: const Duration(seconds: 2),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Get.find<AuthController>().login(
          _authData['email']!,
          _authData['password']!,
        );
        // await Provider.of<Auth>(context, listen: false).login(
        //   _authData['email']!,
        //   _authData['password']!,
        // );
      } else {
        // Sign user up
        await Get.find<AuthController>().signup(
          _authData['email']!,
          _authData['password']!,
        );
        // await Provider.of<Auth>(context, listen: false).signup(
        //   _authData['email']!,
        //   _authData['password']!,
        // );
      }
    } on HttpException catch (e) {
      var errorMessage = 'Authentication failed';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Email already exists, please choose a different email';
      } else if (e.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email address';
      } else if (e.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      } else if (e.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Email does not exist';
      } else if (e.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      }
      _errorSnackBar(errorMessage);
    } catch (e) {
      const errorMessage = 'Could not authenticate you, Please try again later';
      _errorSnackBar(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = Get.size;

    // final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              _authMode == AuthMode.Signup ? 'Sign Up' : 'Login',
              style: kLoginTitleStyle(deviceSize),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              _authMode == AuthMode.Signup ? 'Create Account' : 'Welcome Back',
              style: kLoginSubtitleStyle(deviceSize),
            ),
          ),
          SizedBox(
            height: deviceSize.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.02,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_rounded),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.02,
                  ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_rounded),
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                              return null;
                            }
                          : null,
                    ),
                  SizedBox(
                    height: deviceSize.height * 0.05,
                  ),
                  if (_isLoading)
                    // const CircularProgressIndicator()
                    Lottie.asset(
                      'assets/cart.json',
                      height: deviceSize.height * 0.12,
                      width: double.infinity,
                    )
                  else
                    signUpButton(),
                  SizedBox(
                    height: deviceSize.height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => _switchAuthMode(),
                    child: RichText(
                      text: TextSpan(
                        text: _authMode == AuthMode.Login
                            ? 'Not a user? '
                            : 'Already a user? ',
                        style: kHaveAnAccountStyle(deviceSize),
                        children: [
                          TextSpan(
                              text: _authMode == AuthMode.Login
                                  ? 'Signup'
                                  : 'Login',
                              style: kLoginOrSignUpTextStyle(deviceSize)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color.fromARGB(235, 255, 194, 0),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () => _submit(),
        child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
            style: kLoginAndSignUpText()),
      ),
    );
  }
}
