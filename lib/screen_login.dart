import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:emotion_detection/utils/color_utils.dart';
import 'package:emotion_detection/reusable_widgets/reusable_widgets.dart';
import 'package:emotion_detection/screen_home.dart';
import 'package:emotion_detection/screen_signup.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color:Colors.blue[600],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.30, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Login',
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ) ,),
                const SizedBox(height: 20,),
                reusableTextField('Enter Email', Icons.email_outlined, false,_emailController ),
                const SizedBox(height: 20,),
                reusableTextField('Enter Password', Icons.lock_outline, true, _passwordController),
                signInsigUpButton(context, true, ()async{
                  await FirebaseAuth.instance.
                  signInWithEmailAndPassword(
                    email: _emailController.text.trim(), 
                    password: _passwordController.text.trim())
                    .then((value) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx)=>ScreenHome())
                    );
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account?",
                      style: TextStyle(
                        color: Colors.white70,
                      ),),
                      TextButton(onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx)=>ScreenSignup())
                        );
                      }, child:const Text('Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),),
                    ],
                  )
              ],
            ),),
        ),
      ),
    );
  }
}