import 'package:firebase_signup/authentication.dart';
import 'package:firebase_signup/home.dart';
import 'package:flutter/material.dart';
class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          SizedBox(height: 80,),
          Column(
            children: [
              FlutterLogo(size: 55,),

            ],
          ),
          SizedBox(height: 50,),
          Text('Welcome', style: TextStyle(fontSize: 24),),
          Padding(padding: EdgeInsets.all(8),  child: Signupform()),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Already here ?', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('Get logged in now!',
                      style: TextStyle(fontSize: 26, color: Colors.blue),),
                  ),
                ],
              )

            ],

          )

        ],
      ),
    );
  }
  Container buildLogo(){
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),
      ),color: Colors.blue
      ),
      child: Center(
        child: Text('T',style: TextStyle(color: Colors.white,fontSize: 60),),
      ),
    );

  }
}
class Signupform extends StatefulWidget {
  const Signupform({Key? key}) : super(key: key);

  @override
  State<Signupform> createState() => _SignupformState();
}

class _SignupformState extends State<Signupform> {
  final _formkey = GlobalKey<FormState>();
  String?email;
  String?password;
  String?name;
  bool _obsecureText= false;
  bool agree =false;
  final pass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100))
    );
    var space =SizedBox(height: 10,);
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: border),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          space,

          // password
          TextFormField(
            controller: pass,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obsecureText = !_obsecureText;
                  });
                },
                child: Icon(
                  _obsecureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            onSaved: (val) {
              password = val;
            },
            obscureText: !_obsecureText,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          space,
          // confirm passwords
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
            ),
            obscureText: true,
            validator: (value) {
              if (value != pass.text) {
                return 'password not match';
              }
              return null;
            },
          ),
          space,
          // name
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(Icons.account_circle),
              border: border,
            ),
            onSaved: (val) {
              name = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some name';
              }
              return null;
            },
          ),

          Row(
            children: <Widget>[
              Checkbox(
                onChanged: (_) {
                  setState(() {
                    agree = !agree;
                  });
                },
                value: agree,
              ),
              Flexible(
                child: Text(
                    'By creating account, I agree to Terms & Conditions and Privacy Policy.'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          // signUP button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();

                  AuthenticationHelper()
                      .signUp(email: email!, password: password!)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
