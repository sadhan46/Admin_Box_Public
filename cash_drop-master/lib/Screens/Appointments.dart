import 'package:cash_drop/Admin/Model/ServiceModel.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {


  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  List<String> startTime = ["6:00 am","9:00 am"];
  List<String> name = ["Gaitonde","Raju Kaamati"];
  List<String> totalTime = ["1 hr 30 mins","0hr 30mins"];
  List<String> service = ["Abcdef","Ghijklm"];

  int _date = 0;
  DateTime date = DateTime.now();
  DateTime nulltime = DateTime(0,0,0,0,0);
  DateTime add = DateTime(0,0,0,0,0);

  int serviceTime=0;
  int services=0;
  double total=0;
  bool loading=true;
  bool? data;
  String? message ;
  var appointments;


  TextStyle headingStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xff1C396D));
  TextStyle contentStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'sfpro');

  @override
  void initState() {
    super.initState();
    fetchTimings(0);
    //updateProfile();
  }

  void fetchTimings(d) async {
    setState(() {
      loading=true;
    });
    //var response1 = await networkHandler.get(
      //  "/appointment/try1/getappointments/${DateFormat('y-M-d').format(date.add(Duration(days: d))).toString()}");

    var response = await db
        .collection('Appointments')
        .where('businessName', isEqualTo: 'cgvd')
        .where('date', isEqualTo:'2021-12-5' )
        .get();
    print('appointmentssssssssss');
    print(response.docs.length);
    print(response.docs[0]['totalMin']);
    print(response.docs[0]['totalMin'][0]['name']);
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
/*
  void updateProfile() async {
    var response = await networkHandler.get("/profile/getData");
      profileModel = ProfileModel.fromJson(response["data"]);
      print ("upload data");
      if(profileModel.date != DateFormat('y-M-d').format(date).toString() && customer.data != null) {
        //for number of services
        print("hour1");
        for(int i = 0;i < customer.data.length ;i++){
          print("service data");
          services=services+customer.data[i].cart.length;
        }
        //for total service hours
        print("hour2");
        for(int i = 0;i < customer.data.length ;i++){
          String total_time = customer.data[i].total_time;
          add = nulltime.add(Duration(hours: int.parse(total_time.split(":")[0]),minutes: int.parse(total_time.split(":")[1])));
        }
        //for total earnings
        print("hour3");
        for(int i = 0;i < customer.data.length ;i++){
          total=total+double.parse(customer.data[i].Total);
        }
        print("hour3.5");
        Map<String, String> data = {
          "services": services.toString(),
          "service_time": "${add.hour}:${add.minute}",
          "total": total.toString(),
          "date": DateFormat('y-M-d').format(date).toString(),
        };
        print("hour4");
        await networkHandler.patch("/profile/update", data);
      }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xff1C396D),

        //title:Image.asset('assets/shoptree_admin.png',height: 40),
        automaticallyImplyLeading: false,
      ),
      body:Container(
        padding: EdgeInsets.all(5),

        child: ListView(
          shrinkWrap: true,
          children: [
            Text("Date",style:headingStyle.copyWith(fontSize: 18)),
            SizedBox(height: 5,),
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
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0
              ),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 5,),
            Text("Appointments",style:headingStyle.copyWith(fontSize: 15 )),
            SizedBox(height: 5,),
            loading
                ?
            Center(child: CircularProgressIndicator())
                :
            data!
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
                    ),
                    Container(
                      height: 2,
                      color: Colors.grey.withOpacity(0.03),
                    )
                  ],
                );
            },
              itemCount: appointments.docs.length,
              shrinkWrap: true,
            )
                :
            Center(
              child: Text(message!),
            )
            /*
            ListTile(
              minVerticalPadding: 0.2,
                title: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("${startTime[0]}" ,style: TextStyle(fontSize: 17),),
                    ),
                    Expanded(
                      child: Container(
                        child: Text("${name[0]}",style: TextStyle(fontSize: 17),),
                      ),
                    )
                  ],
                ),
                subtitle: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("${totalTime[0]}",style: TextStyle(fontSize: 15),),
                    ),
                    Expanded(
                      child: Container(
                        child: Text("${Service[0]}, ${Service[1]}",style: TextStyle(fontSize: 15),),
                      ),
                    )
                  ],
                )
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
                title: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("${startTime[1]}" ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text("${name[1]}"),
                      ),
                    )
                  ],
                ),
                subtitle: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("${totalTime[1]}"),
                    ),
                    Expanded(
                      child: Container(
                        child: Text("${Service[0]}, ${Service[1]}"),
                      ),
                    )
                  ],
                )
            ),
             */

          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          /*Navigator.push(context,
              MaterialPageRoute(builder: (context) => ServiceMenu()));
        */
        },

        child: const Icon(Icons.add),
        backgroundColor: Color(0xff1C396D),
      ),
    );
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
            _date == d ? Color(0xff1C396D) : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: contentStyle.copyWith(
                  color: _date == d ? Colors.white : Color(0xff1C396D),
                  fontSize: 16),
            ),
            Text(
              date,
              style: contentStyle.copyWith(
                  color: _date == d ? Colors.white : Color(0xff1C396D),
                  fontSize: 16),
            )
          ],
        ),
      ),
    );
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
                    Text(customerName,
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
                              fontSize: 26.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none)),
                      TextSpan(text: total,
                          style: TextStyle(
                              fontSize: 23.0,
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
                                    fontSize: 26.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none)),
                            TextSpan(text:cartProduct[index]['cost'],
                                style: TextStyle(
                                    fontSize: 23.0,
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

}