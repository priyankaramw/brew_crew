import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign up to Brew Crew'),
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
                child: const Text('Register'),
                onPressed: () async {
                  // if validation success
                  if (_formKey.currentState!.validate()) {
                    error = '';
                    setState(() {
                      error = '';
                      isLoading = true;
                    });
                    // Show loading spin
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
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    isLoading = false;
                    Navigator.pop(context);
                    if (result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                  }
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
              // ********* link to Sign in ******
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Already have an account ? ',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Sign in',
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
