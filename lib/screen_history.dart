import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_detection/screnn_add_history.dart';
import 'package:emotion_detection/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScreenHistory extends StatelessWidget {
  ScreenHistory({super.key});
  User? user=FirebaseAuth.instance.currentUser;
  CollectionReference history=FirebaseFirestore.instance.collection('history');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('History'),
        flexibleSpace: Container(
          color:Colors.blue[600],
        ),
      ),
      body: StreamBuilder(
        stream: history.doc(user!.uid).collection('userHistory').snapshots(),
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(onPressed: ()
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx)=>Screen_addHistory())
                      );
                    }, 
                    icon: Icon(Icons.add_outlined), 
                    label: Text('Add History'),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.80,
                  child: ListView.separated(
                    itemBuilder: (ctx,index)
                    {
                      final DocumentSnapshot historySnap=snapshot.data.docs[index];
                      return ListTile(
                        title: Text(historySnap['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20),),
                        subtitle: Text(historySnap['description']),
                        trailing: Text(historySnap['date']),
                      );
                    }, 
                    separatorBuilder: (ctx,index)
                    {
                      return Divider();
                    }, 
                    itemCount: snapshot.data!.docs.length),
                ),
                  
              ],
            ),
          ),
        );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }, 
      )
    );
  }
}