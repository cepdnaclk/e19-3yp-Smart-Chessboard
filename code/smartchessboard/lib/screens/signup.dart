import 'package:flutter/material.dart';
import 'package:smartchessboard/resources/socket_methods.dart';
import 'package:smartchessboard/screens/login.dart';

class SignupPage extends StatefulWidget {
  static String routeName = '/signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SocketMethods _socketMethods = SocketMethods();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void LogIn(BuildContext context) {
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _socketMethods.signupListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Container(
                width: 350.0,
                child: Column(
                  children: <Widget>[
                    inputFile(
                        label: "Username", controller: usernameController),
                    inputFile(label: "Email", controller: emailController),
                    inputFile(
                        label: "Password",
                        obscureText: true,
                        controller: passwordController),
                    inputFile(
                        label: "Confirm Password",
                        obscureText: true,
                        controller: confirmPasswordController),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                child: MaterialButton(
                  minWidth: 250,
                  height: 60,
                  onPressed: () {
                    _socketMethods.signup(
                        usernameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        confirmPasswordController.text.trim());
                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  MaterialButton(
                    minWidth: 10,
                    hoverColor: Colors.white,
                    highlightColor: Colors.white,
                    child: Text(
                      " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color(0xff0095FF),
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      LogIn(context);
                    },
                  )
                ],
              ),
              Container(
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile(
    {label, obscureText = false, required TextEditingController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 189, 189, 189),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 189, 189, 189),
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
