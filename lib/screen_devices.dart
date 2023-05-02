import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScreenDevice extends StatelessWidget {
  const ScreenDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:const [
                  Text('Devices',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  Text('Connection Status',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(thickness: 2,),
              const SizedBox(height: 10,),
              Container(
                  height: MediaQuery.of(context).size.height*0.80,
                  child: ListView.separated(
                    itemBuilder: (ctx,index)
                    {
                      return ListTile(
                        title: Text('Device$index'),
                        trailing: Text('Status'),
                      );
                    }, 
                    separatorBuilder: (ctx,index)
                    {
                      return Divider();
                    }, 
                    itemCount: 6),
                ),
            ],
          ),
        ),
      ),
    );
  }
}