import 'package:ecom_user_app/auth/firebase_auth_service.dart';
import 'package:ecom_user_app/pages/product_list_page.dart';
import 'package:ecom_user_app/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isPassVisible = true;
  String errMsg = '';
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome User',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email), labelText: 'Email Adress'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyTextFieldMsg;
                  }
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isPassVisible,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(isPassVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isPassVisible = !isPassVisible;
                        });
                      },
                    ),
                    labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyTextFieldMsg;
                  }
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  isLogin = true;
                  _authenticate();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New User?',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    child: Text('Register'),
                    onPressed: () {
                      isLogin = false;
                      _authenticate();
                    },
                  ),
                ],
              ),
              Text(
                errMsg,
                style: TextStyle(fontSize: 18, color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _authenticate() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    try {
      User? user;
      if (isLogin) {
        user = await FirebaseAuthService.loginUser(email!, password!);
      } else {
        user = await FirebaseAuthService.registerUser(email!, password!);
      }
      if (user != null) {
        Navigator.pushReplacementNamed(context, ProductListPage.routeName);
      }
    } catch (error) {
      setState(() {
        errMsg = error.toString();
      });
    }
  }
}
