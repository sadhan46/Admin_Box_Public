import 'dart:async';
import 'dart:io';
import 'package:cash_drop/Admin/SendImage.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

User? user = FirebaseAuth.instance.currentUser;


class ChatRoom extends StatefulWidget {

  final String customerName;
  final String customerId;

  const ChatRoom({Key? key,required this.customerName,required this.customerId}) : super(key: key);
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  User? user = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase.instance.reference();

  TextEditingController messageEditingController = new TextEditingController();

  bool firstMessage = false;
  late StreamSubscription activity;

  final ImagePicker _picker = ImagePicker();
  ScrollController listScrollController = ScrollController();

/*
  Widget chatMessages(){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.documents[index].data["message"],
                sendByMe: Constants.myName == snapshot.data.documents[index].data["sendBy"],
              );
            }) : Container();
      },
    );
  }*/

  addMessage() async{

    if (messageEditingController.text.isNotEmpty) {
      String time = DateTime.now().toString();
      String _minusTime = DateTime.now().subtract(Duration(days: 1)).toString();
      Map<String, dynamic> chatMessageMap = {
        "sendBy": user!.uid,
        "message": messageEditingController.text,
        "image": '',
        'time': time,
      };

        await database.child('Chats').update(
            {
              'Customers/${widget.customerId}/${user!.displayName}_${widget.customerId}/last_Activity': time,

              'Businesses/${user!.displayName}/${user!.displayName}_${widget.customerId}/last_Activity': time,
            });

      await database.child('Chatrooms/${user!.displayName}_${widget.customerId}').push().set(chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  Widget chatMessages(){
    return StreamBuilder(
      stream: database.child('Chatrooms/${user!.displayName}_${widget.customerId}')
          .orderByChild('time')
          .onValue,
      builder: (context, snapshot){
        List<MessageTile> tilesList = <MessageTile>[];

        if(snapshot.hasData && (snapshot.data as Event).snapshot.value != null) {

          final myOrders = Map<String, dynamic>.from((snapshot.data! as Event).snapshot.value);

          myOrders.forEach((key, value) {

            final nextOrder = Map<String, dynamic>.from(value);

            final orderTile = MessageTile(
              sendByMe: nextOrder['sendBy'] == user!.uid,
              image: nextOrder['image'],
              message: nextOrder['message'],
              time: nextOrder['message'],
            );

            tilesList.add(orderTile);
          });
        }

        return ListView(
          shrinkWrap: true,
          reverse: true,
          children: tilesList.reversed.toList(),
            );
        /*
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data!..length,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.documents[index].data["message"],
                sendByMe: Constants.myName == snapshot.data.documents[index].data["sendBy"],
              );
            }) : Container();*/
      },
    );
  }

/*
  Widget chatMessages1(){
    return StreamBuilder(
      stream: database.child('Chatrooms/${widget.businessName}_${user!.uid}')
          .orderByChild('time')
          .limitToLast(10).onValue,
      builder: (context, snap){
        if (snap.hasData &&
            !snap.hasError &&
            (snap.data! as Event).snapshot.value != null) {
//taking the data snapshot.
          DataSnapshot snapshot = (snap.data! as Event).snapshot;
          List item = [];
          List _list = [];
//it gives all the documents in this list.
          _list = snapshot.value;
//Now we're just checking if document is not null then add it to another list called "item".
//I faced this problem it works fine without null check until you remove a document and then your stream reads data including the removed one with a null value(if you have some better approach let me know).
          _list.forEach((f) {
            if (f != null) {
              item.add(f);
            }
          });
          return (snap.data! as Event).snapshot.value == null
//return sizedbox if there's nothing in database.
              ? SizedBox()
//otherwise return a list of widgets.
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      message: item[index]['message'],
                      image: item[index]['image'],
                      sendByMe: item[index]['sentBy']==user!.uid,
                      time: item[index]['time'],
                    );
                  },
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
        /*
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data!..length,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.documents[index].data["message"],
                sendByMe: Constants.myName == snapshot.data.documents[index].data["sendBy"],
              );
            }) : Container();*/
      },
    );
  }
*/

  void _activity(){

    activity=database.child('Chats/Businesses/${user!.displayName}/${user!.displayName}_${widget.customerId}').onValue.listen((event) async {

      String _businessActivity=  (event.snapshot.value['business_Activity']);
      String _lastActivity=  (event.snapshot.value['last_Activity']);

      if(_businessActivity !=_lastActivity){
        await database.child('Chats/Businesses/${user!.displayName}/${user!.displayName}_${widget.customerId}').update(
            {
              'business_Activity':_lastActivity,
            });
      }
    });

  }


  @override
  void initState() {

    super.initState();
    _activity();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('${widget.customerName}',style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,fontSize: 25,
            textStyle: TextStyle(color: Colors.white))),
        //centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.1),
                  child: chatMessages()
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height*0.1,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                color: Colors.grey,
                child: Row(
                  children: [
                    SizedBox(width: 16,),
                    Expanded(
                        child: TextField(
                          controller: messageEditingController,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                              hintText: "Message ...",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              border: InputBorder.none
                          ),
                        )),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset("assets/send.png",
                            height: 25, width: 25,)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    activity.cancel();
    super.dispose();
  }

}

class MessageTile extends StatelessWidget {
  final String message;
  final String image;
  final bool sendByMe;
  final String time;

  MessageTile({required this.message,required this.image, required this.sendByMe,required this.time});

  @override

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          margin: sendByMe
              ? EdgeInsets.only(left: 30)
              : EdgeInsets.only(right: 30),
          padding: image == '' ? _messagePadding : _imagePadding,
          decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
                colors: sendByMe ?[
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
                ]
                : [
                const Color(0xFF9E9E9E),
            const Color(0xFF9E9E9E)
            ],
          )
      ),
      child: image == '' ? _message() : _image() ,
    ),
    );
  }

  EdgeInsetsGeometry _messagePadding= EdgeInsets.only(
      top: 17,bottom: 17, left: 20, right: 20
  );

  EdgeInsetsGeometry _imagePadding= EdgeInsets.only(
      top: 4,bottom: 4, left: 5, right: 5
  );

  Widget _image(){
    return Column(
      children: [
        Container(
          height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                color: Colors.black87,
                image: DecorationImage(image: NetworkImage(image),
                  fit: BoxFit.contain,
                ))
        ),
        Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ],
    );
  }

  Widget _message(){
    return Text(message,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'OverpassRegular',
            fontWeight: FontWeight.w300));
  }
}

