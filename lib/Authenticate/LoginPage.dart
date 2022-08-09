import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginPage({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage ='';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  final navigatorKey = GlobalKey<NavigatorState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            children: [
              Text("LOGIN", style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40
              ),),
              Image.asset("assets/images/4.png"),
              Column(
                children: [
                  Form(
                    key: formKey2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      cursorColor: Colors.blue,
                      onSaved: (email) {},
                      decoration: InputDecoration(
                        hintText: "Your email",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(Icons.person),
                        ),
                      ),
                      validator: (email){
                        if(email != null && !EmailValidator.validate(email)){
                          return 'Enter a valid email';
                        }else{
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Form(
                      key: formKey1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        cursorColor: Colors.lightBlue,
                        decoration: InputDecoration(
                          hintText: "Your password",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.lock),
                          ),
                        ),
                        validator: (value){
                          if(value != null && value.length <6){
                            return 'Enter minimum 6 characters';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Text(errorMessage),
                  ),
                  const SizedBox(height: 10),
                  Hero(
                    tag: "login_btn",
                    child: ElevatedButton(
                      style: ButtonStyle(
                      ),
                      onPressed: signIn,

                      //  {
                      //  // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      // },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 38.0, right: 38, bottom: 18, top: 18),
                        child: Text(
                          "Login".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
             SizedBox(height: 30,),
             RichText(
                 text: TextSpan(
                   style: TextStyle(
                     color: Colors.black54,
                   ),
                   text: 'Do Not Have An Account  ',
                   children: [
                     TextSpan(
                       recognizer: TapGestureRecognizer()
                         ..onTap = widget.onClickedSignUp,
                       text: 'Sign Up',
                       style: TextStyle(
                         decoration: TextDecoration.underline,
                         color: Colors.blue
                       )
                     )
                   ]
                 )
             )
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final isValidForm = formKey1.currentState!.validate();
    final isValidForm1 = formKey2.currentState!.validate();
    if(isValidForm && isValidForm1){
      // showDialog(
      //     context: context,
      //     builder: (context)=>Center(child: CircularProgressIndicator(),));
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        final snackBar = SnackBar(content: Text('Login Success' , style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }on FirebaseAuthException catch (e){
        print(e);
        errorMessage = e.code;
        print(errorMessage);
        final snackBar = SnackBar(content: Text(errorMessage.toString(),style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

    }
  }
}

Widget _buildAboutDialog(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser!;
  return new AlertDialog(
    title: Center(child: const Text('File successfully uploaded')),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    actions: <Widget>[
      Center(child: Text("Password")),
      SizedBox(height: 30,),
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('OK'),
      ),
    ],
  );
}