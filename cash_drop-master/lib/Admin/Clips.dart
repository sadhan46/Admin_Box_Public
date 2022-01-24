import 'dart:async';
import 'dart:io';

import 'package:cash_drop/Admin/Clip.dart';
import 'package:cash_drop/Admin/SelectedClip.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Clips extends StatefulWidget {
  const Clips({Key? key}) : super(key: key);

  @override
  _ClipsState createState() => _ClipsState();
}

class _ClipsState extends State<Clips> {

  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  late Widget page;

  var clips;
  bool data =false;

  final ImagePicker _picker = ImagePicker();
  XFile? _videoFile;

  File? _video;
  final picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;

// This funcion will helps you to pick a Video File

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

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    page = _loading();
    getClipsData();
  }

  Future<void> getClipsData() async {
    // print("user id ${authController.userId}");
    try {
      var response = await db
          .collection('Clips')
          .where('businessName', isEqualTo: user!.displayName)
          .get();
      if (response.docs.length > 0) {
        clips=response.docs;
        page = _clips();
        setState(() {});
      }
      if(response.docs.length == 0) {
        page = _noClips();
        setState(() {        });
      }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  _dontPlay(){
    showMessage("Video can't be more than 60 seconds");
    _video =null;
  }

  _play(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectedClip(videoPlayerController: _videoPlayerController!,video: _video!,),
      ),
    );
  }

  Widget _loading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _noClips(){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library_rounded,color: Colors.blue,size: 100,),
            SizedBox(height: 10,),
            Text("No clips added yet",style: TextStyle(color: Colors.blue,fontSize: 30),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
        ),
        onPressed: ()async {
          _video=null;
          final pickedFile = await _picker.pickVideo(
              source: ImageSource.gallery, maxDuration: Duration(seconds: 60));
          _video = File(pickedFile!.path);
          _videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((_) {
            setState(() { });
            _videoPlayerController!.value.duration.inSeconds > 61? _dontPlay(): _play();

          });
        },
        label:Text("Upload Clip"),
        icon: Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _clips(){
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                color: primaryColor.withOpacity(0.30),
                child: Center(
                    child: Text('Long press on clip to Remove.', style: TextStyle(color: primaryColor, fontSize: 18,),)
                )
            ),
            GridView.builder(
              //physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width*0.333,
                  childAspectRatio: 9/16,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: backgroundColor,
                          image: DecorationImage(image: NetworkImage('${clips[index]['thumbnail']}'),
                            fit: BoxFit.cover,
                          )),
                      height: 270,
                    ),
                    onTap: ()  {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Clip(clip: '${clips[index]['clip']}'),
                        )

                    );
                    },
                    onLongPress: (){
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Center(child: Text("Are You Sure ?")),
                            content: Container(
                              height: 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: backgroundColor,
                                  image: DecorationImage(image: NetworkImage('${clips[index]['thumbnail']}'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            actions: [
                              TextButton(
                                child: Text("Cancel",style: TextStyle(color: Colors.blue),),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Remove",style: TextStyle(color: Colors.redAccent),),
                                onPressed: () {
                                  FirebaseFirestore.instance.collection("Clips").doc(clips[index].id).delete().then((value){
                                    getClipsData();
                                    print("Success!");
                                    Navigator.of(context).pop();
                                  });
                                },
                              )
                            ],
                          )
                      );
                },
                  );
              },
              itemCount: clips.length,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
        ),
        onPressed: ()async {
          _video=null;
          final pickedFile = await _picker.pickVideo(
              source: ImageSource.gallery, maxDuration: Duration(seconds: 60));
          _video = File(pickedFile!.path);
          _videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((_) {
            setState(() { });
            _videoPlayerController!.value.duration.inSeconds > 61? _dontPlay(): _play();

          });
        },
        label:Text("Upload Clip"),
        icon: Icon(Icons.add_rounded),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title:Text("Clips",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,fontSize: 29,
              textStyle: TextStyle(color: Colors.white)),),
      ),
      body: page,
    );
  }
}
