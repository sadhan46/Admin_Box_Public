import 'package:cash_drop/Styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Trying extends StatefulWidget {
  const Trying({Key? key}) : super(key: key);

  @override
  _TryingState createState() => _TryingState();
}

class _TryingState extends State<Trying> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatScreen(),
    );
  }

  Widget chatScreen() {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const ImageIcon(
                AssetImage('assets/Settings_icon.png'),
                size: 27,
              ),
              onPressed: () {
                print('press');
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        elevation: 0,
        title: Text(
          "Cash Drop",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 29,
              textStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage('assets/QR_icon.png'),
                size: 32,
              ),
              onPressed: () {
                // do something
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, Admin!",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 29.5,
                    textStyle: TextStyle(color: primaryColor))),
            Text("Welcome to Cash Drop.",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 23.5,
                    textStyle: TextStyle(
                      color: Color(0xb36077a9),
                    ))),
/*
            SizedBox(height: 8,),
            Text("Customers",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,fontSize: 29.5,
                    textStyle: TextStyle(color: primaryColor))),
            SizedBox(height: 2,),*/
            Expanded(
                child: Container(
              padding: EdgeInsets.all(0.0),
              color: Colors.transparent,
              height: 325,
              child: blue(),
            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        //selectedItemColor: primaryColor,
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_rounded),
            label: 'Uploads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget blue(){
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Creditcard.png'),
              radius: 28.0,
              child: Icon(
                Icons.people_rounded,
                size: 35,
              ),
            ),
            title: Text('Google',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                    textStyle: TextStyle(color: Colors.black87))),
            subtitle: Text(
                'what is the price what is the price what is the price what is the price ',
                overflow: TextOverflow.ellipsis),
            trailing: Column(
              children: [
                Text('06:40 am',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        textStyle: TextStyle(color: Colors.black54))),
                Text('')
              ],
            ),
          ),
        );
      },
      itemCount: 20,
      shrinkWrap: true,
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

}
