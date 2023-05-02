import 'package:emotion_detection/screen_history.dart';
import 'package:emotion_detection/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Screen_addHistory extends StatefulWidget {
  const Screen_addHistory({super.key});

  @override
  State<Screen_addHistory> createState() => _Screen_addHistoryState();
}

class _Screen_addHistoryState extends State<Screen_addHistory> {
  TextEditingController _dateinputTextController= TextEditingController();
  TextEditingController _titleTextController=TextEditingController();
  TextEditingController _descriptionTextController=TextEditingController();
  CollectionReference users=FirebaseFirestore.instance.collection('users');
  User? user=FirebaseAuth.instance.currentUser;
  CollectionReference history=FirebaseFirestore.instance.collection('history');
  
  @override
  void initState() {
    _dateinputTextController.text = ""; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add History'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4"),
          ],begin: Alignment.topCenter,
          end: Alignment.bottomCenter)
          ),
        ),
      ),
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Title '
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _descriptionTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Description '
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _dateinputTextController,
              decoration: InputDecoration( 
                  border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.calendar_today), 
                   hintText: "Enter Date",
                ),
                readOnly: true,  
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), 
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); 
                      print(formattedDate); 
                        

                      setState(() {
                         _dateinputTextController.text = formattedDate; 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async
            {
              await history.doc(user!.uid).collection('userHistory').add({
                'title':_titleTextController.text,
                'description':_descriptionTextController.text,
                'date':_dateinputTextController.text,
              }).then((value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx)=>ScreenHistory())
                );
              });
            }, 
            child: Text('SUBMIT'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 48),
              ),
            )
          ],
        ),
      )),
    );
  }
}