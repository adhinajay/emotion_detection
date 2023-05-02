import 'package:emotion_detection/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenAccount extends StatelessWidget {
  ScreenAccount({super.key});
  final CollectionReference user =
      FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: user.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (context, AsyncSnapshot snapshot) {
              
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: SafeArea(
                      child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Text(
                                snapshot.data['username'],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children:  [
                              Text(
                                'Age : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                snapshot.data['age'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children:  [
                              Text(
                                'Gender : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                snapshot.data['gender'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children:  [
                              Text(
                                'Email : ' ,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                snapshot.data['email'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Guardian Details',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Guardian Name : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                snapshot.data['guardianname'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          
                          Row(
                            children:  [
                              Text(
                                'Mobile No1 : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                snapshot.data['mobileno'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children:  [
                              Text(
                                'Mobile No2 : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                snapshot.data['mobileno1'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          TextButton(
                              onPressed: () {
                                signout(context);
                              },
                              child: Text('Signout'))
                        ],
                      ),
                    ),
                  )),
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            }));
  }

  void signout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      FirebaseAuth.instance.signOut().then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => ScreenLogin()));
      });
    });
  }
}
