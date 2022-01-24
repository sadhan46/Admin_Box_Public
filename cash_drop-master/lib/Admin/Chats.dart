import 'package:cash_drop/Admin/AdminProfile.dart';
import 'package:cash_drop/Screens/Appointments.dart';
import 'package:cash_drop/Admin/Catalog.dart';
import 'package:cash_drop/Admin/ChatRoom.dart';
import 'package:cash_drop/Admin/Services.dart';
import 'package:cash_drop/Admin/SetAppointment.dart';
import 'package:cash_drop/Admin/AddWorkingHours.dart';
import 'package:cash_drop/FIrebase/FirebaseService.dart';
import 'package:cash_drop/Screens/Login.dart';
import 'package:cash_drop/Styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {


  User? user = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase.instance.reference();

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
                await GoogleSignIn().disconnect();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              } catch(e){
                if(e is FirebaseAuthException){
                  showMessage(e.message!);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
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

  Widget listOfBusiness(){
    return ListView(
      children: [
        Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/people.png'),radius: 28.0,
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
              backgroundColor: Colors.blue[700],
              backgroundImage: AssetImage('assets/send.png'),radius: 28.0,
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Container(width: 100,height:12 ,decoration:BoxDecoration(color: Colors.black54.withOpacity(0.1),borderRadius: BorderRadius.circular(4)),),
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
                      backgroundImage: AssetImage('assets/blueCard.png'),radius: 28.0,
                      child: Icon(Icons.people_rounded,size: 35,),
                    ),
                    title: Text('Google',style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 21,
                        textStyle: TextStyle(color: Colors.black87))),
                    subtitle: Container(padding:EdgeInsets.fromLTRB(0, 10, 0, 0),width: 100,height:12 ,decoration:BoxDecoration(color: Colors.black54.withOpacity(0.1),borderRadius: BorderRadius.circular(4)),),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('06:40 am',style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            textStyle: TextStyle(color: Colors.black54))),
                        Icon(Icons.brightness_1_rounded,color: Colors.blue[500],)
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/blueCard.png'),radius: 28.0,
                      child: Icon(Icons.people_rounded,size: 35,),
                    ),
                    title: Text('Google',style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 21,
                        textStyle: TextStyle(color: Colors.black87))),
                    subtitle: SizedBox(),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('06:40 am',style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            textStyle: TextStyle(color: Colors.black54))),
                        Icon(Icons.brightness_1_rounded,color: Colors.blue[500],)
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/blueCard.png'),radius: 28.0,
                      child: Icon(Icons.people_rounded,size: 35,),
                    ),
                    title: Text('Google',style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 21,
                        textStyle: TextStyle(color: Colors.black87))),
                    subtitle: Text('zxOBK4JxdwPd0Y45ZPyA3MuHAMo1 ',overflow: TextOverflow.ellipsis),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('06:40 am',style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            textStyle: TextStyle(color: Colors.black54))),
                        Icon(Icons.brightness_1_rounded,color: Colors.blue[500],)
                      ],
                    ),
                  ),
                ),
                Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/blueCard.png'),radius: 28.0,
              child: Icon(Icons.people_rounded,size: 35,),
            ),
            title: Text('Google',style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 21,
                textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text('what is the price what is the price what is the price what is the price ',overflow: TextOverflow.ellipsis),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('06:40 am',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textStyle: TextStyle(color: Colors.black54))),
                Icon(Icons.brightness_1_rounded,color: Colors.blue[500],)
              ],
            ),
          ),
        ),
                Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/blueCard.png'),radius: 28.0,
                      child: Icon(Icons.people_rounded,size: 35,),
                    ),
                    title: Text('Google',style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 21,
                        textStyle: TextStyle(color: Colors.black87))),
                    subtitle: Text(' yesterday',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.blue[500]),),
                    trailing: Icon(Icons.brightness_1_rounded,color: Colors.blue[500],),
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


  Widget _chats(){
    print('AAAAAAAAAAAAAAAAAAAAAA       -----------0');
    return StreamBuilder(
      stream: database.child('Chats/Businesses/${user!.displayName}')
          .orderByChild('last_Activity')
          .onValue,
      builder: (context, snapshot){
        List<CustomerTile> tilesList = <CustomerTile>[];

        if(snapshot.hasData && (snapshot.data as Event).snapshot.value != null) {

          final myOrders = Map<String, dynamic>.from((snapshot.data! as Event).snapshot.value);

          myOrders.forEach((key, value) {

            final nextOrder = Map<String, dynamic>.from(value);
            final orderTile = CustomerTile(
              customerName: nextOrder['customer_Name'],
              customerId: nextOrder['customer_Id'],
              businessActivity: nextOrder['business_Activity'],
              lastActivity: nextOrder['last_Activity'],
            );

            tilesList.add(orderTile);
            //tilesList.length != 0 ? firstMessage=true : firstMessage=false;
            //print(firstMessage);
          });
        }

        return ListView(
          shrinkWrap: true,
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
        title:Text("Dadar Box",
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,4,16,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, Admin!",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,fontSize: 29.5,
                    textStyle: TextStyle(color: primaryColor))),
            Text("Welcome to Dadar Box.",
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
                  child: _chats()),
            )
          ],
        ),
      ),
    );
  }
}

class CustomerTile extends StatelessWidget {
  final String customerName;
  final String customerId;
  final String businessActivity;
  final String lastActivity;

  CustomerTile({required this.customerName,required this.customerId, required this.businessActivity,required this.lastActivity});

  @override

  Widget build(BuildContext context) {

    print(businessActivity);
    print(lastActivity);
    print(customerName);

    Widget customerTileTrailingFormat(String time,bool messageSeen){
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('$time',style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              textStyle: TextStyle(color: messageSeen ? Colors.black54 : Colors.blue[500]))),

          messageSeen ? Icon(Icons.brightness_1_rounded,color: Colors.white,) : Icon(Icons.brightness_1_rounded,color: Colors.blue[500],)
        ],
      );
    }

    Widget customerTileTrailing(String businessActivity,lastActivity){

      DateFormat dateFormat = DateFormat("dd/MM/yy");
      DateFormat timeFormat = DateFormat("h:mm a");

      DateTime businessTime=DateTime.parse(businessActivity);
      DateTime lastTime=DateTime.parse(lastActivity);
      DateTime time = DateTime.now();

      String messageTime = timeFormat.format(lastTime);
      String date = dateFormat.format(lastTime);

      DateTime compareLastDateActivity = DateTime(lastTime.year,lastTime.month,lastTime.day);
      DateTime todayDate = DateTime(time.year,time.month,time.day);
      DateTime yesterdayDate = DateTime(time.year,time.month,time.day-1);

      bool isYesterday = compareLastDateActivity.compareTo(yesterdayDate) == 0;
      bool isToday = compareLastDateActivity.compareTo(todayDate) == 0;
      bool messageSeen = businessTime.compareTo(lastTime) == 0;

      print(messageTime);

      if(isToday){
        return customerTileTrailingFormat('$messageTime',messageSeen);
      }
      else if (isYesterday) {
        return customerTileTrailingFormat('yesterday',messageSeen);
      }
      else
        return customerTileTrailingFormat('$date',messageSeen);
    }

    return Card(
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/blueCard.png'),radius: 28.0,
          child: Icon(Icons.people_rounded,size: 35,),
        ),
        title: Text('$customerName',
          overflow: TextOverflow.ellipsis ,
            style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 21,
            textStyle: TextStyle(color: Colors.black87)),
        ),
        subtitle: Text('$customerId',overflow: TextOverflow.ellipsis),
        trailing: customerTileTrailing(businessActivity, lastActivity),
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatRoom(customerName: customerName, customerId: customerId),
            ),
          );
        },
      ),
    );
  }
}

