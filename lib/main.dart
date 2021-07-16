import 'package:demo_project_1/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'diary_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    "My Personal Secure Diary",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                      backgroundColor: Color.fromRGBO(255, 253, 208, 1),
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
                      labelText: 'Email:',
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
                      labelText: 'Password:',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: ElevatedButton(
                    child: Text(
                        "Open Your Diary"
                    ),
                    onPressed: (){
                      // print(emailController.text);
                      // print(passwordController.text);
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text, password: passwordController.text)
                          .then((value){
                            print("Login Successfully!");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DiaryPage()),
                            );
                          }).catchError((error){
                            print("Failed to login!");
                            print(error.toString());
                          });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: ElevatedButton(
                    child: Text(
                        "Sign Up"
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
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
