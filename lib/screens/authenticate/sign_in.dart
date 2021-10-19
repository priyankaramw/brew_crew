import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  // sign in with email
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Brew Crew'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              // ****** Email address ******
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              const SizedBox(height: 20.0),
              // ********* Password *********
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) =>
                    val!.length < 6 ? 'Password needs 6 characters' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              const SizedBox(height: 20.0),
              // ********* Button *********
              ElevatedButton(
                child: const Text('Sign in'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Running the loading spin
                    setState(() {
                      error = '';
                      isLoading = true;
                    });
                    if (isLoading) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    }
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    // To discard the spin
                    isLoading = false;
                    Navigator.pop(context);
                    if (result == null) {
                      setState(() {
                        error = 'Login failed';
                      });
                    }
                  }
                  // print(email);
                  // print(password);
                },
              ),
              // ******* Error msg if any *****
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(error),
                ],
              ),
              const SizedBox(height: 20.0),
              // ********* link to register ****
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Dont have an account ? ',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 18.0,
                      ),
                    ),
                    splashColor: Colors.white,
                    onTap: () {
                      widget.toggleView();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
