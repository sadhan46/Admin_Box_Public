
import 'package:cash_drop/Admin/ChatRoom.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessProfile extends StatefulWidget {
  final String businessName;
  const BusinessProfile({Key? key,required this.businessName}) : super(key: key);

  @override
  _BusinessProfileState createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {

  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  bool data =false;
  var business;

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
          .where('Business Name', isEqualTo: widget.businessName)
          .limit(1)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });
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
                decoration: BoxDecoration(
                    color: Colors.grey,
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
            SizedBox(
              height: 5,
            ),
            Flexible(
              child:GridView.builder(
                physics: NeverScrollableScrollPhysics(),
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        height: 270,
                      ),
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            child: AspectRatio(
                              aspectRatio: 9/16,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: primaryColor
                                ),
                              ),
                            ),
                          )

                      ),
                    );
                },
                itemCount: 20,
                shrinkWrap: true,
              ),
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
      backgroundColor: Colors.white,
      body: data ? _businessProfile() : loading(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () { },
        icon: Icon(Icons.message_outlined),
        label: Text("Start Chat"),
        backgroundColor: primaryColor,
      ),
    );
  }
}
