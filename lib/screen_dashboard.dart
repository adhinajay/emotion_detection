import 'dart:io';

import 'package:emotion_detection/screen_contactus.dart';
import 'package:emotion_detection/screen_devices.dart';
import 'package:emotion_detection/screen_history.dart';
import 'package:emotion_detection/screnn_add_history.dart';
import 'package:emotion_detection/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ScreenDashboard extends StatefulWidget {
  ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {

  final ImagePicker _picker = ImagePicker();

  String? imageUrl;

  CollectionReference user = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: user.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      color:Colors.blue[600],
                      child: Column(
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
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  snapshot.data['username'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 37,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _selectphoto();
                          },
                          icon: Icon(Icons.file_upload_outlined),
                          label: Text('Upload photo'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.44,
                                MediaQuery.of(context).size.height *
                                    0.20),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ScreenHistory()));
                          },
                          icon: Icon(Icons.access_time_outlined),
                          label: Text('History'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.44,
                                MediaQuery.of(context).size.height *
                                    0.20), 
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => Screen_addHistory()));
                          },
                          icon: Icon(Icons.add_card_outlined),
                          label: Text('Add History'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.44,
                                MediaQuery.of(context).size.height *
                                    0.20), 
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ScreenContactUs()));
                          },
                          icon: Icon(Icons.phone),
                          label: Text('Contact Us'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.44,
                                MediaQuery.of(context).size.height *
                                    0.20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future _selectphoto() async {
    await showBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.filter),
                    title: Text("Pick a file"),
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }

    // file = await compressImage(file.path, 35);
    // await _uploadFile(file.path);
    file = (await compressImage(file.path, 35)) as CroppedFile?;
    await _uploadFile(file!.path);
  }

  Future<File?> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );
    return result;
  }

  Future _uploadFile(String path) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();
  }
}
