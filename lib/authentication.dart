import 'package:flutter/material.dart';
import 'Authenticate//LoginPage.dart';
import 'package:flutter/gestures.dart';
import 'Authenticate/signup.dart';
import '';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin ? LoginPage(onClickedSignUp : toggle) : SignUp(onClickedSignIn : toggle);
  void toggle() => setState(()=>isLogin = !isLogin);
}
