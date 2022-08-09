import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'LoginPage.dart';
import '../Screens/HomePage.dart';
class SignUp extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUp({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  List<String> items = ['Student', 'Teacher' , 'Others'];
  String? selectedItem = 'Student';


//  final user1 = FirebaseAuth.instance.currentUser!;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController1 = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  String errorMessage = '';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80,left: 50.0,right: 50,bottom: 50),
          child: Column(
            children: [
              Text("SIGNUP",style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40
              ),),
              Image.asset("assets/images/10.png"),
              Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.blue,
                    onSaved: (email) {},
                    decoration: InputDecoration(
                      hintText: "Your name",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Form(
                      key: formKey1,
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
                            child: Icon(Icons.email),
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
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Form(
                      key: formKey2,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        controller: passwordController1,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        cursorColor: Colors.lightBlue,
                        decoration: InputDecoration(
                          hintText: "Create a password",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Form(
                      key: formKey3,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        cursorColor: Colors.lightBlue,
                        decoration: InputDecoration(
                          hintText: "Verify password",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.lock),
                          ),
                        ),
                        validator: (value){
                          if(value != null && value.length <6 && value== passwordController1.text.trim()){
                            return "Password dosn't not match";
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: SizedBox(
                      width: 340,
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.person),
                          ),
                        ),
                        value: selectedItem,
                        items: items
                            .map((item) =>DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: TextStyle(color: Colors.blueGrey,fontSize: 18),)))
                            .toList(),
                        onChanged: (item)=> setState(()=> selectedItem = item),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Hero(
                    tag: "login_btn",
                    child: ElevatedButton(
                      style: ButtonStyle(
                      ),
                      onPressed: signUp,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 38.0, right: 38,bottom: 18,top: 18),
                        child: Text(
                          "Create Account".toUpperCase(),
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
                      text: 'Have An Account  ',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                            text: 'Login',
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
  Future signUp() async{

    final docUser = FirebaseFirestore.instance.collection('studOrTech').doc(emailController.text.trim());
    final json = {
      'user' :  selectedItem,
    };
    await docUser.set(json);

    final isValidForm = formKey1.currentState!.validate();
    final isValidForm1 = formKey2.currentState!.validate();
    final isValidForm2 = formKey3.currentState!.validate();
    if(isValidForm && isValidForm1 && isValidForm2){
      showDialog(
          context: context,
          builder: (context)=>Center(child: CircularProgressIndicator(),));
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      navigatorKey.currentState?.popUntil((route)=> route.isFirst);
    }
  }
}
