import 'dart:io';

import 'package:cash_drop/Admin/BottomNavigation.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class UploadClip extends StatefulWidget {
  final File video;

  const UploadClip({Key? key,required this.video}) : super(key: key);

  @override
  _UploadClipState createState() => _UploadClipState();
}

class _UploadClipState extends State<UploadClip> {


  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  TextEditingController tag = TextEditingController();

  List<String> tags = [];

  Widget buildTagTF(
      TextEditingController controller, String label) {
    return TextFormField(

      controller: controller,
      validator: (value) {
        if (value ==null || value.isEmpty) {
          return "Enter $label";
        }
        return null;
      },
      decoration: InputDecoration(

          hintText: "E.g Event Organizer, Caterers, Whole seller's",
          hintStyle: TextStyle(
              color: Colors.grey
          )
      ),
      maxLines: 1,
    );
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Note"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

   void uploading() {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Uploading...'),
                SizedBox(height: 10,),
                CircularProgressIndicator()
              ],
            ),
          );
        });
  }


  void uploadingDone() async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }


   storeImage() async{
    int time = DateTime.now().millisecondsSinceEpoch;
    final storeImage = FirebaseStorage.instance
        .ref()
        .child('Thumbnail')
        .child(
        '${user!.displayName}_$time');
    final result = await storeImage.putFile(File(_imageFile!.path));
    final imageURL = await result.ref.getDownloadURL();
    return imageURL;
  }

  storeClip() async{

    int time = DateTime.now().millisecondsSinceEpoch;
    final storeImage = FirebaseStorage.instance
        .ref()
        .child('Clips')
        .child(
        '${user!.displayName}_$time');
    final result = await storeImage.putFile(File(widget.video.path));
    final videoURL = await result.ref.getDownloadURL();
    return videoURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Thumbnail',style: TextStyle(color: primaryColor,letterSpacing: -0.5,fontSize: 25,fontWeight: FontWeight.w500)),
            SizedBox(height: 8,),
            Center(
              child: InkWell(
                child: Container(
                  height: 250,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: _imageFile==null?Center(
                    child: Icon(Icons.image_rounded,color: Colors.grey,size: 45,),
                  ):Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(_imageFile!.path)),
                            fit: BoxFit.cover,
                          ))),
                ),
                onTap: () async {
                  final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 10);
                  setState(() {
                    _imageFile = pickedFile;
                  });
                },
              ),
            ),
            SizedBox(height: 8,),
            Container(height: 10,color: backgroundColor,),
            Text('Tags',style: TextStyle(color: primaryColor,letterSpacing: -0.5,fontSize: 25,fontWeight: FontWeight.w500)),
            SizedBox(height: 10,),
            tags.length != 0
                ? Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              child: Row(
                                children: [
                                  Text(
                                    tags[index],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        );
                      },
                      itemCount: tags.length,
                      shrinkWrap: true,
                    ),
                  )
                : SizedBox(),
            Container(
              child: Row(
                children: [
                  Flexible(child: buildTagTF(tag, 'Tag')),
                  //Flexible(child: TextField()),
                  MaterialButton(
                      elevation: 4.0,
                      color: primaryColor,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      onPressed: () {
                            if(tags.length<5){
                          tags.add(tag.text);
                          setState(() {
                            tag.text = "";
                          });
                        }
                            else showMessage("Can't add More than 5 tags");
                      },
                      child: Text('ADD', style: TextStyle(color: Colors.white),))
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
        ),
        onPressed: () async{
          if(tags.length==0){
            showMessage("Add at least one tag ");
            return;
          }
          if(_imageFile == null){
            showMessage("Add thumbnail for the Clip");
            return;
          }
          if(tags.length!=0 && _imageFile != null ){
            uploading();

            db.collection('Clips').add({
              'businessName': user!.displayName,
              'thumbnail':await storeImage(),
              'clip': await storeClip(),
              'tags': tags,
            }).then((value) => uploadingDone());
          }

        },
        label:Text("Upload"),
        icon: Icon(Icons.upload_rounded),
      ),

    );
  }
}
