import 'package:emotion_detection/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScreenContactUs extends StatelessWidget {
  const ScreenContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(60, MediaQuery.of(context).size.height*0.40, 60, 0),
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:const [
          Text('Contact Us',
          style:TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),),
          SizedBox(height: 5,),
          Divider(thickness: 2,color: Colors.blue,),
          SizedBox(height: 5,),
          Text('adhin_19b208cs@gecwyd.ac.in',
          style:TextStyle(
            fontSize: 15,
            color: Colors.blue,
          ),
          ),
          Text('nihal_19b071cs@gecwyd.ac.in',
          style:TextStyle(
            fontSize: 15,
            color: Colors.blue,
          ),
          ),
          Text('rahul_19b423cs@gecwyd.ac.in',
          style:TextStyle(
            fontSize: 15,
            color: Colors.blue,
          ),
          ),
          Text('neena_19b054cs@gecwyd.ac.in',
          style:TextStyle(
            fontSize: 15,
            color: Colors.blue,
          ),
          ),
        ],
      ),),
        ),
      ),
      
    );
  }
}