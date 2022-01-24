import 'package:cash_drop/Admin/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Styles.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {


  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  var business;
  bool data = false;

  void showMessage(IconData icon,String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(8),
            //title: Text("Error"),
            content: ListTile(
              leading: Icon(icon,size: 45,color: Colors.blue,),
                title: Text(message)
            ),
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

  Widget more(){
    return  ListTile(
      title: Text('More :',style: TextStyle(color: Colors.black54,letterSpacing: -0.5,)),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                showMessage(Icons.location_on_rounded,'addressed the address at Elphinstone');
              },
              child: Column(
                children: [
                  Icon(Icons.location_on_rounded,size: 45,color: Colors.blue,),
                  SizedBox(height: 8,),
                  Text('Address',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.blue),)
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                showMessage(Icons.info_rounded,'Medical locates at the position loscate djdksn bakshisha but it is not and that sjjs');
              },
              child: Column(
                children: [
                  Icon(Icons.info_rounded,size: 45,color: Colors.blue,),
                  SizedBox(height: 8,),
                  Text('About',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.blue),)
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                showMessage(Icons.call_rounded,'9987369901');
              },
              child: Column(
                children: [
                  Icon(Icons.call_rounded,size: 45,color: Colors.blue,),
                  SizedBox(height: 8,),
                  Text('Contact',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.blue),)
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    getUserProfileData();
  }

  Future<void> getUserProfileData() async {
    // print("user id ${authController.userId}");
    try {
      var response = await db
          .collection('Business Profile')
          .where('Business Name', isEqualTo: user!.displayName)
          .limit(1)
          .get();
      if (response.docs.length > 0) {
        business=response.docs[0];
        setState(() {
          data =true;
        });
      }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  Widget _businessProfile(){
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: MediaQuery.of(context).size.height*0.25,
                //color: Colors.grey,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('${business['Logo']}'),
                      fit: BoxFit.cover,
                    ))
            ),
            ListTile(
              title: Text('Business Name :',style: TextStyle(color: Colors.black54,letterSpacing: -0.5,)),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,),
                child: Text(
                  '${business['Business Name']}',
                  style:TextStyle(color: Colors.black,letterSpacing: -0.5,fontSize: 27),textAlign: TextAlign.left,maxLines: 6,
                ),
              ),
            ),
            Container(
              color: backgroundColor,
              height: 10,
            ),
            ListTile(
              title: Text('Category :',style: TextStyle(color: Colors.black54,letterSpacing: -0.5,)),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                child: Text(
                  '${business['Category']}',
                  style:
                  TextStyle(color: Colors.black,letterSpacing: -0.5,fontSize: 18),textAlign: TextAlign.left,maxLines: 6,
                ),
              ),
            ),
            Container(
              color: backgroundColor,
              height: 10,
            ),
            ListTile(
              title: Text('About :',style: TextStyle(color: Colors.black54,letterSpacing: -0.5,)),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                child: Text(
                  '${business['Business Description']}',
                  style:TextStyle(color: Colors.black,letterSpacing: -0.5,fontSize: 18),textAlign: TextAlign.left,maxLines: 6,
                ),
              ),
            ),
            Container(
              color: backgroundColor,
              height: 10,
            ),
            ListTile(
              title: Text('Email :',style: TextStyle(color: Colors.black54,letterSpacing: -0.5,)),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                child: Text(
                  '${business['Email']}',
                  style:TextStyle(color: Colors.black,letterSpacing: -0.5,fontSize: 18),textAlign: TextAlign.left,maxLines: 6,
                ),
              ),
            ),
            Container(
              color: backgroundColor,
              height: 10,
            ),
            ListTile(
              title: Text('Address :',style: TextStyle(color: Colors.black54,letterSpacing: -0.5,)),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                child: Text(
                  '${business['Address']}',
                  style:TextStyle(color: Colors.black,letterSpacing: -0.5,fontSize: 18),textAlign: TextAlign.left,maxLines: 6,
                ),
              ),
            ),
            Container(
              color: backgroundColor,
              height: 10,
            ),
            ListTile(
              title: Text('Pincode :',style: TextStyle(color: Colors.black54,letterSpacing: -0.5,)),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                child: Text(
                  '${business['Pincode']}',
                  style:TextStyle(color: Colors.black,letterSpacing: -0.5,fontSize: 18),textAlign: TextAlign.left,maxLines: 6,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        elevation: 0,
        title:Text("Profile",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,fontSize: 29,
              textStyle: TextStyle(color: Colors.white)),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.edit_rounded,size: 32,),
              onPressed: () {

              },
            ),
          )
        ],
      ),
      body: data ? _businessProfile() : loading(),
    );
  }
}
