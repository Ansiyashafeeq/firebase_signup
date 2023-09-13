import 'package:firebase_signup/authentication.dart';
import 'package:firebase_signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_signup/home.dart';
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
      padding: EdgeInsets.all(10),
        children: [
          SizedBox(height: 80,),
          Column(
            children: [
              FlutterLogo(size: 55,),
              SizedBox(height: 50,),
              Text('Welcome back!',style: TextStyle(fontSize: 24),),
            ],
          ),
          SizedBox(height: 50,),
          Padding(padding: EdgeInsets.all(16),
          child: LoginForm(),),
          SizedBox(height: 20,),
           Row(
             children:<Widget> [
               SizedBox(width: 30,),
               Text('New here?',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
               GestureDetector(
                 onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>Signup()));
                 },
                 child: Text('Get Registered Now!',style: TextStyle(fontSize: 20,color: Colors.blue),),
               )
             ],
           )
        ],
      ),
    );
  }
}
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey,
        child: Column(
      mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100),
                )
              )
            ),
              validator: (value){
              if(value!.isEmpty){
                return 'please enter some text';
              }
              return null;
              },
              onSaved: (val){
              email= val;
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100),),

                ),
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                      _obsecureText=!_obsecureText;
                    });
                  },
                  child: Icon(_obsecureText?
                    Icons.visibility_off:Icons.visibility
                  ),
                )
              ),
              obscureText: _obsecureText,
              onSaved: (val){
                password=val;
              },
              validator: (Value){
                if(Value!.isEmpty){
                  return 'please enter  some text';
                }
                return null;
              },
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 56,
              width: 184,
              child: ElevatedButton(onPressed: (){
                if (_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  AuthenticationHelper()
                  .signIn(email: email!, password: password!)
                  .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) =>
                          Home()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar
                        (SnackBar(content: Text(
                        result, style: TextStyle(fontSize: 16),)
                      )
                      );
                    }
                  }
                    );
                }
              },
                 style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24)))),
                  child: Text('Login',style: TextStyle(fontSize: 24),)),
            )

          ],
    ));
  }
}
