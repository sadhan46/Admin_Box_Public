import 'dart:io';

import 'package:cash_drop/Admin/UploadClip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class SelectedClip extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final File video;


  const SelectedClip({Key? key,required this.videoPlayerController,required this.video}) : super(key: key);

  @override
  _SelectedClipState createState() => _SelectedClipState();
}

class _SelectedClipState extends State<SelectedClip> {
  late VideoPlayerController _videoPlayerController;

  File? tryVideo;
  MediaInfo? _video;
  bool _play=true;

  compressVideo() async{

    await VideoCompress.setLogLevel(0);
    final MediaInfo? info = await VideoCompress.compressVideo(
      widget.video.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
      includeAudio: true,
    );

      setState(() {
        tryVideo=info!.file;
      });

    _videoPlayerController = VideoPlayerController.file(
        tryVideo!)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    compressVideo();
    //widget.videoPlayerController!.play();
    //widget.videoPlayerController!.setLooping(true);
  }

  Widget Compressing(){
    return Container(
      child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Compressing Video...",style: TextStyle(fontSize: 20 ),),
              SizedBox(height: 10),
              CircularProgressIndicator(),
            ],
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tryVideo==null?Compressing():InkWell(
        child: Container(
          child: VideoPlayer(_videoPlayerController),
        ),
        onTap: (){
          if(_play == true){
            _videoPlayerController.pause();
            _play = false;
            return;
          }
          if(_play == false){
            _videoPlayerController.play();
            _play = true;
            return;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done_rounded),
        onPressed: () {

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => UploadClip(video: tryVideo!),
            ),
          );
        },
      ),

    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
