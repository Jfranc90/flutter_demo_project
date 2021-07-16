import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_img.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 35.0),
                  child: Text(
                    "Creating a New Account",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                        backgroundColor: Color.fromRGBO(255, 253, 208, 1)
                    ),
                  ),
                ),
                Container(
                  width: 300.0,
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child:
                  TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(255, 253, 208, 1),
                      border: OutlineInputBorder(),
                      labelText: 'Enter an email:',
                    ),
                  ),
                ),
                Container(
                  width: 300.0,
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                  child:
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(255, 253, 208, 1),
                      border: OutlineInputBorder(),
                      labelText: 'Create a password (6 characters or more):',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: ElevatedButton(
                    child: Text(
                        "Sign Up"
                    ),
                    onPressed: (){
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text, password: passwordController.text)
                          .then((value) {
                            print("Successfully Signed Up!");
                            Navigator.pop(context);
                          }).catchError((error){
                            print("Failed to sign up!");
                            print(error.toString());
                          });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
