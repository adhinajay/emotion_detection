import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_detection/reusable_widgets/reusable_widgets.dart';
import 'package:emotion_detection/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:emotion_detection/utils/color_utils.dart';
import 'package:firebase_core/firebase_core.dart';

class ScreenSignup extends StatelessWidget {
   ScreenSignup({super.key});
  CollectionReference users=FirebaseFirestore.instance.collection('users');

  TextEditingController _userNameController=TextEditingController();
  TextEditingController _AgeController=TextEditingController();
  TextEditingController _GuadianNameController=TextEditingController();
  TextEditingController _mobileNumberController=TextEditingController();
  TextEditingController _alternateMobileNumberController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _genderController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4"),
          ],
          begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.13, 20, 0),
            child: Column(
              children: [
                const Text('Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 40,),
                  reusableTextField("Enter Username", Icons.person_outline, false, _userNameController),
                  const SizedBox(height: 20,),
                  reusableTextField("Enter Age", Icons.date_range, false, _AgeController),
                  const SizedBox(height: 20,),
                  reusableTextField("Enter Gender", Icons.person_outline, false, _genderController),
                  const SizedBox(height: 20,),
                  reusableTextField("Enter Email", Icons.mail_outline_outlined, false, _emailController),
                  const SizedBox(height: 20,),
                  reusableTextField("Enter Guardian Name", Icons.person_outline, false, _GuadianNameController),
                  const SizedBox(height: 20,),
                  reusableTextField("Enter Mobile Number", Icons.phone_android, false,_mobileNumberController ),
                  const SizedBox(height: 20,),
                  reusableTextField("Enter Alternate Mobile Number", Icons.phone_android, false, _alternateMobileNumberController),
                  const SizedBox(height: 20,),
                  reusableTextField("Enter Password", Icons.lock_outline, true, _passwordController),
                  const SizedBox(height: 10,),
                  signInsigUpButton(context, false, ()
                  {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).
                    then((value)async {
                    print("user added successfully");
                    if(value.user==null)return;
                    await users.doc(value.user!.uid).set({
                      'username':_userNameController.text,
                      'age':_AgeController.text,
                      'gender':_genderController.text,
                      'email':_emailController.text,
                      'guardianname':_GuadianNameController.text,
                      'mobileno':_mobileNumberController.text,
                      'mobileno1':_mobileNumberController.text,
                      'password':_passwordController.text,
                    }).then((value) {
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx)=>ScreenLogin())
                      );
                      });
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                      });
                    })
                    ],
            ),)
        ),
      )
    );
  }
}