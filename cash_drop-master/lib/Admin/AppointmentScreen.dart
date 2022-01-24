import 'package:cash_drop/Admin/Appointment.dart';
import 'package:cash_drop/Admin/AdminProfile.dart';
import 'package:cash_drop/Admin/Chats.dart';
import 'package:cash_drop/Admin/Clips.dart';
import 'package:cash_drop/Admin/EditWorkingHours.dart';
import 'package:cash_drop/Admin/Services.dart';
import 'package:cash_drop/Styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {



  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Appointments(),
    ServiceScreen(),
    Clips(),
    EditWorkingHours(),
    AdminProfile(),
  ];


  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      backgroundColor: backgroundColor,
      body: _widgetOptions.elementAt(_selectedIndex),
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
              Icons.video_library_rounded,
            ),
            label: 'Clips',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time_filled_rounded,
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),

    );
  }
}
