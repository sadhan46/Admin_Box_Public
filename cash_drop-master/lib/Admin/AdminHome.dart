import 'package:cash_drop/Admin/AddAdminProfile.dart';
import 'package:cash_drop/Admin/AppointmentScreen.dart';
import 'package:cash_drop/Admin/ChatScreen.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {


  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  bool data = false;
  bool chats = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfileData();
  }

  Future<void> getUserProfileData() async {
    setState(() {
      data = false;
    });
    // print("user id ${authController.userId}");
    try {
      var response = await db
          .collection('Business Profile')
          .where('Business Name', isEqualTo: user!.displayName)
          .limit(1)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });
      print(response.docs[0]['Category']);
        if(response.docs.length == 1 )  {
        if (response.docs[0]['Category'] == 'Saloon' ||
            response.docs[0]['Category'] == 'Beauty Parlour') {
          setState(() {
            chats = false;
            data = true;
          });
        } else {
          setState(() {
            chats = true;
            data = true;
          });
        }
      }
        if(response.docs.length == 0) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AddAdminProfile(),
            ),
          );
        }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }


  appointments() {
    return Container();
  }

  Widget listOfBusiness(){
    return ListView(
      children: [
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: data ? homeScreen() : Center(child: CircularProgressIndicator()));
  }

  Widget homeScreen() {
    return Container(
      child: chats ? ChatScreen() : AppointmentScreen(),
    );
  }

  Widget chatScreen(){
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,4,16,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, Admin!",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,fontSize: 29.5,
                    textStyle: TextStyle(color: primaryColor))),
            Text("Welcome to Cash Drop.",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,fontSize: 23.5,
                    textStyle: TextStyle(color: Color(0xb36077a9),))),
/*
            SizedBox(height: 8,),
            Text("Customers",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,fontSize: 29.5,
                    textStyle: TextStyle(color: primaryColor))),
            SizedBox(height: 2,),*/
            Expanded(
              child:Container(
                  color: Colors.transparent,
                  height: 325,
                  child: listOfBusiness()),
            )
          ],
        ),
      ),
    );
  }
}
