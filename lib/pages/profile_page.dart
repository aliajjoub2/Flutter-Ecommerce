import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/data_from_firestore.dart';
import 'package:path/path.dart' show basename;

import '../shared/user_img_from_firestore.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // veriable get data of user from FirebaseAuth
  final credential = FirebaseAuth.instance.currentUser;

// variables image picker
   File? imgPath;
  String? imgName;
  // get user data from firestore
  CollectionReference users = FirebaseFirestore.instance.collection('userSSS');
  
  // function upload image to fire storage
    uploadImage2Screen() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          // to make the name unique or unrepeated
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbarGreen,
        title: Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: Stack(
                      children: [
                        imgPath == null
                            ? ImgUser()
                            : ClipOval(
                                child: Image.file(
                                  imgPath!,
                                  width: 145,
                                  height: 145,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned(
                          left: 103,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () async {
                              await uploadImage2Screen();
        
                              if (imgPath != null) {
                                // Upload image to firebase storage
                                final storageRef = FirebaseStorage.instance
                                    .ref("users-imgs/$imgName");
                                await storageRef.putFile(imgPath!);
                                // Get img url
                                String urlll = await storageRef.getDownloadURL();
        
                                users.doc(credential!.uid).update({
                                  "imgLink": urlll,
                                });
                              }
                            },
                            icon: const Icon(Icons.add_a_photo),
                            color: Color.fromARGB(255, 94, 115, 128),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 33,
                ),
              Center(
                  child: Container(
                padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 131, 177, 255),
                    borderRadius: BorderRadius.circular(11)),
                child: Text(
                  "Info from firebase Auth",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Email: ${credential!.email}      ",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
        //
        
                    "Created date:   ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}   ",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    //
                    "Last Signed In: ${DateFormat("MMMM d, y").format(credential!.metadata.lastSignInTime!)}  ",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 55,
              ),
                  SizedBox(
                  height: 22,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        credential!.delete();
        
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Delete User",
                        style: TextStyle(fontSize: 18),
                      )),
                ),
                SizedBox(
                  height: 22,
                ),
              Center(
                  child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 131, 177, 255),
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        "Info from firebase firestore",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))),
            
            
            GetDataFromFirestore(documentId: credential!.uid,),
            
            ],
          ),
        ),
      ),
    );
  }
}
