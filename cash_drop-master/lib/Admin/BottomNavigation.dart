import 'package:cash_drop/Admin/Appointment.dart';
import 'package:cash_drop/Admin/AdminProfile.dart';
import 'package:cash_drop/Admin/Catalog.dart';
import 'package:cash_drop/Admin/ChatScreen.dart';
import 'package:cash_drop/Admin/Clips.dart';
import 'package:cash_drop/Admin/Services.dart';
import 'package:cash_drop/Admin/SetAppointment.dart';
import 'package:cash_drop/Admin/AddWorkingHours.dart';
import 'package:cash_drop/FIrebase/FirebaseService.dart';
import 'package:cash_drop/Screens/Login.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {


  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  bool data = false;
  bool chats = false;

  int _chatSelectedIndex = 0;
  int _appoinmentSelectedIndex = 0;

  List<Widget> _chatWidgetOptions = <Widget>[
    ChatScreen(),
    Clips(),
    AdminProfile(),
  ];

  List<Widget> _appoinmentWidgetOptions = <Widget>[
    Appointments(),
    ServiceScreen(),
    Clips(),
    AdminProfile(),
  ];


  void _onItemTap(int index) {
    setState(() {
      _chatSelectedIndex = index;
    });
  }

  Widget navBar(){
    User? user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Hello,Admin',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,fontSize: 22,
                textStyle: TextStyle(color: Colors.white))),
            accountEmail: Text(user!.email!,style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,fontSize: 18,
                textStyle: TextStyle(color: Colors.white))),
            currentAccountPicture: CircleAvatar(
              foregroundColor: primaryColor,
              child: Image.asset(
                'assets/person.png',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
                color: primaryColor,
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor),
          ),
          ListTile(
            leading: Icon(Icons.person,color: primaryColor,size: 33,),
            title: Text('Profile',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    textStyle: TextStyle(color: primaryColor))),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AdminProfile(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.menu,color: primaryColor,size: 33,),
            title: Text('Catalog',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    textStyle: TextStyle(color: primaryColor))),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Catalog(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.timer_outlined,color: primaryColor,size: 33,),
            title: Text('Appointments',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    textStyle: TextStyle(color: primaryColor))),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Appointments(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.menu,color: primaryColor,size: 33,),
            title: Text('Working Hours',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    textStyle: TextStyle(color: primaryColor))),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddWorkingHours(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.menu,color: primaryColor,size: 33,),
            title: Text('Services',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    textStyle: TextStyle(color: primaryColor))),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ServiceMenu(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.menu,color: primaryColor,size: 33,),
            title: Text('Add Services',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    textStyle: TextStyle(color: primaryColor))),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ServiceScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,color: primaryColor,size: 33,
            ),
            title: Text('Logout',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,fontSize: 22,
                textStyle: TextStyle(color: primaryColor))),
            onTap: () async {
              FirebaseService service = new FirebaseService();
              try {
                await service.signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              } catch(e){
                if(e is FirebaseAuthException){
                  //showMessage(e.message!);
                }
              }
            },
          ),
        ],
      ),
    );
  }

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
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });

      if(response.docs[0]['Category']=='saloon' || response.docs[0]['Category']=='Beauty Parlour'){
        setState(() {
          chats = false;
          data = true;
        });
      }

      else{
        setState(() {
          chats = true;
          data = true;
        });
      }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: navBar(),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const ImageIcon(AssetImage('assets/Settings_icon.png'),size: 27,),
              onPressed: () {
                print('press');
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        elevation: 0,
        title:Text("Cash Drop",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,fontSize: 29,
              textStyle: TextStyle(color: Colors.white)),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const ImageIcon(AssetImage('assets/QR_icon.png'),size: 32,),
              onPressed: () {
                // do something
              },
            ),
          )
        ],
      ),
      body: Center(
        child: _chatWidgetOptions.elementAt(_chatSelectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store,
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _chatSelectedIndex,
        onTap: _onItemTap,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
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

  Widget homeScreen() {
    return Container(
      child: chats ? ChatScreen() : Appointments(),
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
