import 'package:cash_drop/Admin/AdminProfile.dart';
import 'package:cash_drop/Admin/EditWorkingHours.dart';
import 'package:cash_drop/Screens/Appointments.dart';
import 'package:cash_drop/Admin/Services.dart';
import 'package:cash_drop/Admin/SetAppointment.dart';
import 'package:cash_drop/Admin/AddWorkingHours.dart';
import 'package:cash_drop/FIrebase/FirebaseService.dart';
import 'package:cash_drop/Admin/Catalog.dart';
import 'package:cash_drop/Screens/Home.dart';
import 'package:cash_drop/Screens/Login.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {

  List<String> payNames =['Kachra Seth','Mangu','Changu','Mangu','Vasooli Bhai','Mangu','Changu','Mangu','Vasooli Bhai',
    'Jack Sparrow','Munna Bhai'];
  List<String> payCost =['15000','500','400','200','15000','500','400','200','15000','500','400'];
  String cardIds = "hxi3rWiNfxCviSaBsY0";


  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;


  bool loading=true;
  bool data = false;
  bool noPayments = false;
  var payment;
  var appointments;

  String? message ;




  int _date = 0;
  DateTime date = DateTime.now();

  TextStyle contentStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500,);

  Widget paymentInfo(String firstName,String lastName,String time,String cost){
    return Container(
      padding: EdgeInsets.only(left: 15,top: 8,bottom: 0,right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$firstName $lastName",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,fontSize: 25.5,
                      textStyle: TextStyle(color: primaryColor)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("$time",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,fontSize: 17,
                      textStyle: TextStyle(color: primaryColor)))
                ],
              ),
              Row(
                children: [
                  Text("₹",
                      style: TextStyle(color: primaryColor,fontSize: 28.5)),
                  Text("$cost",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,fontSize: 25.5,
                      textStyle: TextStyle(color: primaryColor)))
                ],
              )

            ],
          ),
          Container(
            height: 2,
            width: 300,
            color: backgroundColor,

          )
        ],
      ),
    );
  }

  Widget cardId(String id){

    id = id.replaceRange(5, 8, "*" * 4);
    id = id.replaceRange(11, 14, "*" * 4);

    return Text("$id",style: GoogleFonts.poppins(
        textStyle: TextStyle(color: Colors.white,fontSize: 22,letterSpacing: 2.0)));
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
            leading: Icon(Icons.timer_rounded,color: primaryColor,size: 33,),
            title: Text('Working Hours',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    textStyle: TextStyle(color: primaryColor))),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditWorkingHours(),
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

  dateWidget(String day, String date, int d) {
    return InkWell(
      onTap: () {
        setState(() {
          _date = d;
          fetchTimings(d);
        });
      },
      child: Container(
        height: 60,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color:
            _date == d ? primaryColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day,
                style: TextStyle(
                  color: _date == d ? Colors.white : primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                )),
            Text(date,
                  style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: _date == d ? Colors.white : primaryColor,
                ))
          ],
        ),
      ),
    );
  }

  Future<void> getPaymentsData() async {
    // print("user id ${authController.userId}");
    try {
      var response = await db
          .collection('Payments')
          .where('Business Name', isEqualTo: user!.displayName)
          .get();
      if (response.docs.length > 0) {
        setState(() {
          payment = response;
          data = true;
        });
      }
      else{
        setState(() {
          noPayments=true;
        });
      }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  customerInfoDialog(BuildContext context,final String customerName,
      final String customerContactNumber,
      final String startTime,
      final String endTime,
      final String total,
      List<dynamic> cartProduct ) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        title: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Color(0xff1C396D),
              blurRadius: 5.0,
            ),],
            shape: BoxShape.rectangle,
            color: Color(0xff1C396D),
            borderRadius:
            new BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
          ),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*Text("$customerName",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none)),*/
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Divider(height: 14,),
                    Text(' $customerName',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none)),
                    SelectableText(" $customerContactNumber • $startTime",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none)),
                  ],
                ),
                /* Text("$total",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none)),*/
                RichText(text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text:"₹",
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none)),
                      TextSpan(text: total,
                          style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none)),
                    ]
                ),)
              ],
            ),
          ),
        ),

        content: Container(
          //height: 400,
          width: 200,
          child: ListView.builder(
            itemBuilder: (context, index) {
              //int price = int.parse(cartProduct[index].serviceCost);
              //int counter = cartProduct[index].counter;
              //int tileCost = price*counter;
              return Column(
                children: [
                  /*              Container(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: ListTile(
                      title: Text(
                        "${cartProduct[index].serviceName}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${cartProduct[index].hr}Hr ${cartProduct[index].min}min",
                            style: TextStyle(fontSize: 16,color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 3.0),
                                    child: Text("₹ ",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none)),
                                  ),
                                  Text("${cartProduct[index].serviceCost} x ${cartProduct[index].counter}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none)),
                                ],
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 3.0),
                                      child: Text("${cartProduct[index].currency} ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.none)),
                                    ),
                                    Text("$tileCost",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none))
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${cartProduct[index]['name']}",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,),
                          ),
                          /*
                          cartProduct[index].hr=="0"
                              ?
                          Text(
                            "${cartProduct[index].hr}Hr ${cartProduct[index].min}min",
                            style: TextStyle(fontSize: 16,color: Colors.black),
                          )
                              :
                          Text(
                            "${cartProduct[index].min}min",
                            style: TextStyle(fontSize: 16,color: Colors.black),
                          )*/
                        ],
                      ),
                      RichText(text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text:"₹",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none)),
                            TextSpan(text:cartProduct[index]['cost'],
                                style: TextStyle(
                                    fontSize: 26.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none)),
                          ]
                      ))
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Color(0xff1C396D).withOpacity(0.05),
                  ),
                ],
              );
            },
            itemCount: cartProduct.length,
            shrinkWrap: true,
          ),
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ));

  void fetchTimings(d) async {
    setState(() {
      loading=true;
    });
    //var response1 = await networkHandler.get(
    //  "/appointment/try1/getappointments/${DateFormat('y-M-d').format(date.add(Duration(days: d))).toString()}");

    var response = await db
        .collection('Appointments')
        .where('businessName', isEqualTo: user!.displayName)
        .where('date', isEqualTo: DateFormat('y-M-d')
        .format(date.add(Duration(days: d)))
        .toString() )
        .get();
    print('appointmentssssssssss');
    setState(() {
      if(response.docs.length==0){
        data = false ;
        message ="No Appointments";
      }
      else {
        appointments = response;
        data=true;
      }
    });
    /*
    var profile = await networkHandler.get("/profile/getData");
    profileModel = ProfileModel.fromJson(profile["data"]);
    if(profileModel.date != DateFormat('y-M-d').format(DateTime.now()).toString() && data == true) {
      //for number of services
      services= int.parse(profileModel.services);
      //add.hour == int.parse(profileModel.service_time.split(":")[0]);
      //add.minute == int.parse(profileModel.service_time.split(":")[1]);
      add = add.add(Duration(hours: int.parse(profileModel.service_time.split(":")[0]),minutes: int.parse(profileModel.service_time.split(":")[1])));
      total=total+double.parse(profileModel.total);
      for(int i = 0;i < customer.data.length ;i++){
        services=services+customer.data[i].cart.length;
        print(services);
      }
      //for total service hours
      print("hour2");
      for(int i = 0;i < customer.data.length ;i++){
        String total_time = customer.data[i].total_time;
        add = add.add(Duration(hours: int.parse(total_time.split(":")[0]),minutes: int.parse(total_time.split(":")[1])));
        print(add);
      }
      //for total earnings
      print("hour3");
      for(int i = 0;i < customer.data.length ;i++){
        total=total+double.parse(customer.data[i].Total);
        print(total);
      }
      print("hour3.5");
      Map<String, String> data = {
        "services": services.toString(),
        "service_time": "${add.hour}:${add.minute}",
        "total": total.toString(),
        "address":profileModel.address,
        "date": DateFormat('y-M-d').format(date).toString(),
      };
      print("hour4");
      await networkHandler.patch("/profile/update", data);
    }*/
    setState(() {
      loading=false;
    });
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    fetchTimings(0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navBar(),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        //toolbarHeight: 85,
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
        padding: const EdgeInsets.fromLTRB(16,4,16,2),
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

            SizedBox(height: 8,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:
              Row(
                children: [
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 0))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 0))).toString(), 0),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 1))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 1))).toString(), 1),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 2))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 2))).toString(), 2),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 3))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 3))).toString(), 3),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 4))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 4))).toString(), 4),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 5))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 5))).toString(), 5),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 6))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 6))).toString(), 6),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 7))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 7))).toString(), 7),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 8))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 8))).toString(), 8),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 9))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 9))).toString(), 9),
                  dateWidget(DateFormat('EEE').format(date.add(Duration(days: 10))).toString(), DateFormat('MMM d').format(date.add(Duration(days: 10))).toString(), 10),
                ],
              ),
            ),
            SizedBox(height: 8,),
            Text("Appointments",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,fontSize: 29.5,
                    textStyle: TextStyle(color: primaryColor))),
            SizedBox(height: 2,),
            Expanded(
              child: Container(
                //height: 583.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                /*
                child: /*data?ListView.builder(
                  itemBuilder: (context, index) {
                    return paymentInfo(
                        payment.docs[index]['First Name'],
                        payment.docs[index]['Last Name'],
                        payment.docs[index]['Time'],
                        payment.docs[index]['Pay']);
                  },
                  itemCount: payment.docs.length,
                  shrinkWrap: true,
                ):Center(child: noPayments ? Text('No Payments Available',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        textStyle:
                        TextStyle(color: primaryColor))) : CircularProgressIndicator(),)*/ appointmentTile(),*/
                child:
                loading
                    ?
                Center(child: CircularProgressIndicator())
                    :
                data
                    ?
                ListView.builder(itemBuilder: (context,index){

                  return
                    Column(
                      children: [
                        /*ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal:
                            16.0),
                        visualDensity: VisualDensity(vertical: -4),
                        dense: true,
                        tileColor: Colors.white,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(" ${customer.data[index].start_time}" ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,),)),
                              Expanded(
                                child: Text(" ${customer.data[index].customer_name}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,),),
                              )
                            ],
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text("${customer.data[index].Total}",style: TextStyle(fontSize: 15),),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    //Icon(CupertinoIcons.phone,size: 16,),
                                    Text(" ${customer.data[index].customer_contact_number}",style: TextStyle(fontSize: 15),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        onTap: (){
                          customerInfoDialog(context, "${customer.data[index].customer_name}",
                              "${customer.data[index].customer_contact_number}",
                              "${customer.data[index].start_time}",
                              "${customer.data[index].end_time}",
                              "${customer.data[index].Total}",
                              customer.data[index].cart);
                        },
                      ),*/
                        /*
                        InkWell(
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(12,8,12,8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(appointments.docs[index]['startTime'],style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,)),
                                        Divider(height: 3.0,),
                                        RichText(text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(text:"₹",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      decoration: TextDecoration.none)),
                                              TextSpan(text:appointments.docs[index]['total'],
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      decoration: TextDecoration.none)),
                                            ]
                                        ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(appointments.docs[index]['customerName'],style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,)),
                                        Divider(height: 3.0,),
                                        SelectableText(appointments.docs[index]['customerContact'],style: TextStyle(fontSize: 16,)),
                                      ],
                                    ),
                                    /*
                    RichText(text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text:"₹",
                                style: TextStyle(
                                    fontSize: 26.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none)),
                            TextSpan(text:total[index],
                                style: TextStyle(
                                    fontSize: 23.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none)),
                          ]
                    ),
                    )*/
                                    Container(
                                      width: 50,
                                      child: Center(
                                        child: Text(appointments.docs[index]['totalMin'].length.toString(),style: TextStyle(
                                            fontSize: 23.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: (){
                              customerInfoDialog(context,appointments.docs[index]['customerName'],
                                  appointments.docs[index]['customerContact'],
                                  appointments.docs[index]['startTime'],
                                  'endtime',
                                  appointments.docs[index]['total'],
                                  appointments.docs[index]['totalMin']
                              );
                            }
                        ),*/
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${appointments.docs[index]['startTime'].toString().split(' ').first}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 27,
                                          color: Colors.white)),
                                  TextSpan(
                                      text: '${appointments.docs[index]['startTime'].toString().split(' ').last}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                          ),
                          title: Text(appointments.docs[index]['customerName'],style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                          subtitle: Text(appointments.docs[index]['customerContact'],style: TextStyle(color: primaryColor,fontSize: 15)),
                          trailing: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: primaryColor)),
                                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                                TextSpan(text: appointments.docs[index]['total'],style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28,color: primaryColor)),
                              ],
                            ),
                          ),
                          onTap:  (){
                            customerInfoDialog(context,appointments.docs[index]['customerName'],
                                appointments.docs[index]['customerContact'],
                                appointments.docs[index]['startTime'],
                                'endtime',
                                appointments.docs[index]['total'],
                                appointments.docs[index]['cart']
                            );
                          },
                        ),
                        Container(height: 4,color: backgroundColor,),

                      ],
                    );
                },
                  itemCount: appointments.docs.length,
                  shrinkWrap: true,
                )
                    :
                Center(
                  child: Text(message!),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add,),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ServiceMenu(),
            ),
          );
        },
      ),

      /*
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),*/
    );
  }

  Widget appointmentTile(){
    return ListView(
      children: [
        /*Card(
          child: ListTile(
            leading: Text('8:10 pm',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,)),
            title: Text('Sadhan',style: TextStyle(fontWeight: FontWeight.w700,color: primaryColor)),
            subtitle: Text('9987369901',style: TextStyle(color: primaryColor)),
            trailing: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                  TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                  TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                ],
              ),
            ),
          ),
        ),*/
//        Container(height: 5,color: backgroundColor,),
/*
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Column(
                    children: [
                      Text('10',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25,color: Colors.white)),
                      Text('25',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25,color: Colors.white)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mahesh',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor.withOpacity(0.6),fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('12:25',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: primaryColor)),
                    Text('pm',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: primaryColor)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Raj',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('10:25',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: primaryColor)),
                    Text('pm',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: primaryColor)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mahesh',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor.withOpacity(0.6),fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('12:25',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: primaryColor)),
                    Text('pm',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: primaryColor)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Raj',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('10:25',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: primaryColor)),
                    Text('pm',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: primaryColor)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mahesh',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor.withOpacity(0.6),fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('12:25',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: primaryColor)),
                    Text('pm',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: primaryColor)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Raj',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('3:25 am',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23,color: primaryColor)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mahesh',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor.withOpacity(0.6),fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text('3:25 am',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23,color: primaryColor)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person,color: primaryColor,),
                        Text(' Bunty',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                      ],
                    ),
                    Container(height: 4,),
                    Row(
                      children: [
                        Icon(Icons.phone_android_outlined,color: primaryColor,),
                        Text('  9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,color: primaryColor),
                        Text('  4:20 pm',style: TextStyle(color: primaryColor,fontSize: 15)),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                          TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                          TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                        ],
                      ),
                    ),
                    Text('Details',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: primaryColor),)
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('3:25 am',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23,color: primaryColor)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mahesh',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor.withOpacity(0.6),fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('3:25 am',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23,color: primaryColor)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jainish',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('3:25 am',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23,color: primaryColor)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mahesh',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor.withOpacity(0.6),fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '11:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '7:10',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' pm',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '11:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '7:10',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' pm',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),*/
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '12:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' AM',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '11:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' PM',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),

        //Customer Icon
/*
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/Creditcard.png'),
            radius: 28.0,
            child: Icon(
              Icons.people_rounded,
              size: 35,
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('7:20 am',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/Creditcard.png'),
            radius: 28.0,
            child: Icon(
              Icons.people_rounded,
              size: 35,
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('7:20 am',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/Creditcard.png'),
            radius: 28.0,
            child: Icon(
              Icons.people_rounded,
              size: 35,
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('7:20 am',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/Creditcard.png'),
            radius: 28.0,
            child: Icon(
              Icons.people_rounded,
              size: 35,
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('7:20 am',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/Creditcard.png'),
            radius: 28.0,
            child: Icon(
              Icons.people_rounded,
              size: 35,
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('7:20 am',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/Creditcard.png'),
            radius: 28.0,
            child: Icon(
              Icons.people_rounded,
              size: 35,
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('7:20 am',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/Creditcard.png'),
            radius: 28.0,
            child: Icon(
              Icons.people_rounded,
              size: 35,
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('7:20 am',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/Creditcard.png'),
            radius: 28.0,
            child: Icon(
              Icons.people_rounded,
              size: 35,
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('7:20 am',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
*/
        //Customer ICon
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '5:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' am',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '05:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' AM',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '05:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' am',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '5:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' am',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '05:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' am',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '5:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' am',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '10:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' am',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
        Container(height: 4,color: backgroundColor,),
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '12:23',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.white)),
                  TextSpan(
                      text: ' am',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          title: Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
          subtitle: Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
          trailing: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }
/*
  Widget appointmentCard(){
    return ListView(
      children: [

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '11:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '7:10',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' pm',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '11:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '7:10',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' pm',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '5:23',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 27,
                                color: Colors.white)),
                        TextSpan(
                            text: ' am',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sai',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: primaryColor)),
                    Text('9987369901',style: TextStyle(color: primaryColor,fontSize: 15)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '₹',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28,color: primaryColor)),
                      TextSpan(text: ' ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color: primaryColor)),
                      TextSpan(text: '350.0',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26,color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  */

}
