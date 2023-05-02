import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField reusableTextField(String text,IconData icon,bool isPassWord,TextEditingController controller)
{
  return TextField(
    controller: controller,
    obscureText: isPassWord,
    enableSuggestions: !isPassWord,
    autocorrect: !isPassWord,
    cursorColor: Colors.white,
    decoration: InputDecoration(
      prefixIcon: Icon(icon,
      color: Colors.white.withOpacity(0.9),),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(width: 0,style: BorderStyle.none)
      ),
    ),
    keyboardType: isPassWord
    ?TextInputType.visiblePassword
    :TextInputType.emailAddress
  );
}

Container signInsigUpButton(BuildContext context,bool isLogin,Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: ElevatedButton(
      onPressed:()
      {onTap();} , 
      child: Text(isLogin?'LOG IN':'SIGN UP',
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      )
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.pressed)){
            return Colors.black26; 
          }
          else
          return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
      ),
      ),
      
  );
}