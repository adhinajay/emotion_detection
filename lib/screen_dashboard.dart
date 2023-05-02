import 'package:emotion_detection/screen_contactus.dart';
import 'package:emotion_detection/screen_devices.dart';
import 'package:emotion_detection/screen_history.dart';
import 'package:emotion_detection/screnn_add_history.dart';
import 'package:emotion_detection/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenDashboard extends StatefulWidget {
   ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
   //final user=FirebaseAuth.instance.currentUser!;
  CollectionReference user=FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder(
        future: user.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              
              children: [
                Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4"),
          ],begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child:  Text(
                        snapshot.data['username'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                        ),
                      ), ),
                  ],
                )
              ],
            ),

            ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.file_upload_outlined),
                  label: Text('Upload photo'), 
                  style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                  ),
                  backgroundColor: Colors.blue, 
                  minimumSize: Size(MediaQuery.of(context).size.width *0.44, MediaQuery.of(context).size.height*0.20), // set minimum button size
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx)=>ScreenHistory())
                    );
                  },
                  icon: Icon(Icons.access_time_outlined),
                  label: Text('History'), 
                  style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                  ),
                  backgroundColor: Colors.blue, 
                  minimumSize: Size(MediaQuery.of(context).size.width *0.44,MediaQuery.of(context).size.height*0.20), // set minimum button size
                  ),
                ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx)=>Screen_addHistory())
                    );
                  },
                  icon: Icon(Icons.add_card_outlined), 
                  label: Text('Add History'), 
                  style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                  ),
                  backgroundColor: Colors.blue, 
                  minimumSize: Size(MediaQuery.of(context).size.width *0.44, MediaQuery.of(context).size.height*0.20), // set minimum button size
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx)=>ScreenContactUs())
                    );
                  },
                  icon: Icon(Icons.phone), 
                  label: Text('Contact Us'), 
                  style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                  ),
                  backgroundColor: Colors.blue, 
                  minimumSize: Size(MediaQuery.of(context).size.width *0.44, MediaQuery.of(context).size.height*0.20), // set minimum button size
                  ),
                ),
                  ],
                )
              ],
            ),
          ),
        );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
        
      ),
    );
  }
}