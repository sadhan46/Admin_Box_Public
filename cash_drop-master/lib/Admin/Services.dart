
import 'package:cash_drop/Custom/Currency.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {


  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final _globalkey = GlobalKey<FormState>();
  TextEditingController serviceName = TextEditingController();
  TextEditingController serviceCost = TextEditingController();
  TextEditingController hr = TextEditingController();
  TextEditingController min = TextEditingController();

  bool services = true;
  bool data = false;
  bool addingService = false;

  var service;

  Widget page = CircularProgressIndicator();

  Future<void> addServiceDialog(BuildContext context) async {
    return await showDialog(context: context,
        builder: (context){
          final TextEditingController _textEditingController = TextEditingController();
          return StatefulBuilder(builder: (context,setState){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              titlePadding: EdgeInsets.all(0),
              title: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xff1C396D),
                  borderRadius:
                  new BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                ),
                height: 50,
                child: Center(
                  child: Text("Add Service",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none)),
                ),
              ),
              content: Form(
                key: _globalkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    serviceNameTextField(),
                    Flexible(child: serviceCostTextField()),
                    Row(
                      children: [
                        Flexible(child: hrTextField()),
                        Flexible(child: minTextField())
                      ],
                    )

                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: addingService?CircularProgressIndicator():Text('Add',style: TextStyle(fontSize: 20),),
                  onPressed: () async{

                    if (_globalkey.currentState!.validate() && addingService == false)
                    {
                      setState(() {
                        addingService = true;
                      });
                      db.collection('Services').add({
                        'uid': user!.uid,
                        'businessName': user!.displayName,
                        'name': serviceName.text,
                        'cost': serviceCost.text,
                        'hr': hr.text ==""?"0":hr.text,
                        'min': min.text,
                        'counter': int.parse('1'),
                        'addService': false
                      }).whenComplete(() => addService());

                    }
                  },
                ),
              ],
            );
          });
        });
  }

  addService(){
    fetchServicesData();
    Navigator.of(context).pop();
    setState(() {
      addingService = false;
    });
  }

  void deleteService(var id,String itemName,_hr,_min,cost) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Center(child: Text("Are You Sure ?")),
            content: Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5)
                ),
                //padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: ListTile(
                  //leading: Icon(Icons.radio_button_off_rounded,color: primaryColor,),
                  title: Text(itemName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,),),
                  subtitle: Row(
                    children: [
                      _hr != "0"
                          ?
                      Text(
                        "${_hr}Hr ${_min}min",
                        style: TextStyle(fontSize: 17,fontWeight:FontWeight.w300,color: Colors.grey),
                      )
                          :
                      Text(
                        "${_min}min",
                        style: TextStyle(fontSize: 17,fontWeight:FontWeight.w300,color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: "₹",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                        TextSpan(text: " ",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                        TextSpan(text: "$cost",
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ],
                    ),
                  ),
                ),
              ),
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
                  FirebaseFirestore.instance.collection("Services").doc(id).delete().then((value){
                    fetchServicesData();
                    print("Success!");
                    Navigator.of(context).pop();
                  });
                  },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    fetchServicesData();    // _addproduct();
  }

  Future<void> fetchServicesData() async {
    // print("user id ${authController.userId}");
    try {
      var response = await db
          .collection('Services')
          .where('businessName', isEqualTo: user!.displayName)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });
      if (response.docs.length > 0) {
        setState(() {
          service = response;
          data = true;
        });
      }
      else{
        setState(() {
          services = false;
          data = false;
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Services",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,fontSize: 29,
              textStyle: TextStyle(color: Colors.white)),),
        backgroundColor: primaryColor,
      ),

      body:
        ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: primaryColor.withOpacity(0.30),
              child: Center(
                  child: Text('Long press on item to Remove.', style: TextStyle(color: primaryColor, fontSize: 18,),)
              )
            ),
          data
              ?
          ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: ListTile(
                              onLongPress: () {
                                deleteService(
                                    service.docs[index].id,
                                    service.docs[index]['name'],
                                    service.docs[index]['hr'],
                                    service.docs[index]['min'],
                                    service.docs[index]['cost']);
                              },
                              leading: Icon(
                                Icons.brightness_1_outlined,
                                color: primaryColor,
                                size: 32,
                              ),
                              title: Text(
                                service.docs[index]['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  service.docs[index]['hr'] != "0"
                                      ? Text(
                                          "${service.docs[index]['hr']}Hr ${service.docs[index]['min']}min",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        )
                                      : Text(
                                          "${service.docs[index]['min']}min",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                  /*Row(
                              children: [

                                Container(
                                  padding: EdgeInsets.only(top: 3.0),
                                  child: Text("₹",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ),
                                Text(" ${service.docs[index]['cost']}",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none)),
                              ],
                            ),*/
                                ],
                              ),
                              trailing: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "₹",
                                        style: TextStyle(
                                            fontSize: 23.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none)),
                                    TextSpan(
                                        text: " ",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none)),
                                    TextSpan(
                                        text: "${service.docs[index]['cost']}",
                                        style: TextStyle(
                                            fontSize: 32.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey.shade300,
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: service.docs.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
                )
              :
          Center(
                  child: services ? page : Text("No services added yet"),
                ),
            Container(
              height: 70,
            )
        ],
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        onPressed: () async{
          await addServiceDialog(context);
        },
        label:Text("Add Service"),
      ),
    );
  }

  Widget serviceNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(

        controller: serviceName,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter service name";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Service name",
          //labelText: "Service name",
        ),
        maxLines: null,


      ),
    );
  }

  Widget serviceCostTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          CurrencyFormat()
        ],
        controller: serviceCost,
        validator: (value) {
          if (value==null || value.isEmpty) {
            return "Enter service cost";
          }else if (value.length > 7) {
            return "Enter less than 1000000";
          }
          return null;
        },
        decoration: InputDecoration(
          //labelText: "Service Cost",
            hintText: "Service Cost"
        ),
        maxLines: null,
      ),
    );
  }

  Widget hrTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,

        validator: (value){
          if(value!.contains('.')){
            return "Enter whole number";
          }
          if(value.contains('-')){
            return "Enter whole number";
          }
          if(value.contains(',')){
            return "Enter whole number";
          }
          if(value.contains(' ')){
            return "Enter whole number";
          }
          return null;
        },
        controller: hr,
        decoration: InputDecoration(
          //suffixText: "hr",
            hintText: "hr",
            hintTextDirection: TextDirection.rtl
        ),
        maxLines: null,
      ),
    );
  }

  Widget minTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: min,
        validator: (value){
          if(value==null || value.isEmpty){
            return "Enter minutes";
          }
          if(value.contains('.')){
            return "Enter whole number";
          }
          if(value.contains('-')){
            return "Enter whole number";
          }
          if(value.contains(',')){
            return "Enter whole number";
          }
          if(value.contains(' ')){
            return "Enter whole number";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "min",
          hintTextDirection: TextDirection.rtl,
          //suffixText: "min"
        ),
        maxLines: null,
      ),
    );
  }

  _errorMessageDialog(BuildContext context, String label) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        titlePadding: EdgeInsets.all(0),
        title: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color(0xff1C396D),
            borderRadius:
            new BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
          ),
          height: 50,
          child: Center(
            child: Text("Note",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none)),
          ),
        ),
        content: Text('$label '),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ));

}