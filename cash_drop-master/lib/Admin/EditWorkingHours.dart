import 'package:cash_drop/Admin/AddWorkingHours.dart';
import 'package:cash_drop/Admin/Appointment.dart';
import 'package:cash_drop/Admin/AdminHome.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditWorkingHours extends StatefulWidget {
  @override
  _EditWorkingHoursState createState() => _EditWorkingHoursState();
}

class _EditWorkingHoursState extends State<EditWorkingHours> {

  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  var shedule;

  bool circular = true;
  bool _shedule = false;

  TextStyle headingStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500
  );
  TextStyle contentStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: 'sfpro'
  );

  int breakz = 0;
  String _openingtime = "Enter Opening time";
  String _closingtime = "Enter Closing time";

  String _break_1_from = "Enter Break 1 Starting time";
  String _break_1_to = "Enter Break 1 Closing time";

  String _break_2_from = "Enter Break 2 Starting time";
  String _break_2_to = "Enter Break 2 Closing time";

  String _break_3_from = "Enter Break 3 Starting time";
  String _break_3_to = "Enter Break 3 Closing time";

  String _break_4_from = "Enter Break 4 Starting time";
  String _break_4_to = "Enter Break 4 Closing time";

  String _break_5_from = "Enter Break 5 Starting time";
  String _break_5_to = "Enter Break 5 Closing time";

//from side validation

  String break_1_from_gt_break_1_to =
      "Break 1 starting time is greater than its ending time";
  String break_2_from_gt_break_2_to =
      "Break 2 starting time is greater than its ending time";
  String break_3_from_gt_break_3_to =
      "Break 3 starting time is greater than its ending time";
  String break_4_from_gt_break_4_to =
      "Break 4 starting time is greater than its ending time";
  String break_5_from_gt_break_5_to =
      "Break 5 starting time is greater than its ending time";

// to side validation

  String opening_gt_break_1_from =
      "Break 1 should start after opening time";
  String break_1_to_gt_break_2_from =
      "Break 2 should start after Break 1's ending time";
  String break_2_to_gt_break_3_from =
      "Break 3 should start after Break 2's ending time";
  String break_3_to_gt_break_4_from =
      "Break 4 should start after Break 3's ending time";
  String break_4_to_gt_break_5_from =
      "Break 5 should start after Break 4's ending time";
  String break_5_to_gt_closing_time =
      "Break 5 should end before Closing time";

  String opening_gt_closing = "Opening time should be less than Closing time";

  List<TimeOfDay> breaks_from = [];
  List<TimeOfDay> breaks_to = [];

  //List<TimeOfDay> from;
  //List<TimeOfDay> to;

  TimeOfDay? openingtime;
  TimeOfDay? closingtime;

  TimeOfDay? break_1_from;
  TimeOfDay? break_1_to;

  TimeOfDay? break_2_from;
  TimeOfDay? break_2_to;

  TimeOfDay? break_3_from;
  TimeOfDay? break_3_to;

  TimeOfDay? break_4_from;
  TimeOfDay? break_4_to;

  TimeOfDay? break_5_from;
  TimeOfDay? break_5_to;

  List<String> close_Days=[];
  bool _monday=false;
  bool _tuesday=false;
  bool _wednesday=false;
  bool _thursday=false;
  bool _friday=false;
  bool _saturday=false;
  bool _sunday=false;

  List<String> slots=[];
  List<String> slots1=[];

  List<bool> timeChange=[false,false,false,false,false,false,
    false,false,false,false,false,false,];

  @override
  void initState() {
    super.initState();
    fetchServicesData();
  }

  Future<void> fetchServicesData() async {
    // print("user id ${authController.userId}");
    try {
      var response = await db
          .collection('Working Hours')
          .where('Business Name', isEqualTo: user!.displayName)
          .limit(1)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });
      if (response.docs.length > 0) {
          shedule = response;
          slots1.add(shedule.docs[0]['slot_1_starting_time']);
          slots1.add(shedule.docs[0]['slot_1_ending_time']);
          slots1.add(shedule.docs[0]['slot_2_starting_time']);
          slots1.add(shedule.docs[0]['slot_2_ending_time']);
          slots1.add(shedule.docs[0]['slot_3_starting_time']);
          slots1.add(shedule.docs[0]['slot_3_ending_time']);
          slots1.add(shedule.docs[0]['slot_4_starting_time']);
          slots1.add(shedule.docs[0]['slot_4_ending_time']);
          slots1.add(shedule.docs[0]['slot_5_starting_time']);
          slots1.add(shedule.docs[0]['slot_5_ending_time']);
          slots1.add(shedule.docs[0]['slot_6_starting_time']);
          slots1.add(shedule.docs[0]['slot_6_ending_time']);
          slots1.removeWhere((item) => item == "");
          String x = slots1.last;
          slots1.remove(slots1.last);
          if(slots1.length<12){
            for(int i = slots1.length;i<12;i++){
              slots1.add("");
            }
            slots1[11]=x;

            openingtime = slots1[0] == "" ? null : stringToTime (slots1[0]);
            break_1_from = slots1[1] == "" ? null : stringToTime(slots1[1]);
            break_1_to = slots1[2] == "" ? null : stringToTime(slots1[2]);
            break_2_from = slots1[3] == "" ? null : stringToTime(slots1[3]);
            break_2_to = slots1[4] == "" ? null : stringToTime(slots1[4]);
            break_3_from = slots1[5] == "" ? null : stringToTime(slots1[5]);
            break_3_to = slots1[6] == "" ? null : stringToTime(slots1[6]);
            break_4_from = slots1[7] == "" ? null : stringToTime(slots1[7]);
            break_4_to = slots1[8] == "" ? null : stringToTime(slots1[8]);
            break_5_from = slots1[9] == "" ? null : stringToTime(slots1[9]);
            break_5_to = slots1[10] == "" ? null : stringToTime(slots1[10]);
            closingtime = slots1[11] == "" ? null : stringToTime(slots1[11]);
          }
          if(shedule.docs[0]['close_days'].contains("Mon")){setState(() {
            _monday=true;
            close_Days.add("Mon");
          }); }
          if(shedule.docs[0]['close_days'].contains("Tue")){setState(() {
            _tuesday=true;
            close_Days.add("Tue");
          }); }
          if(shedule.docs[0]['close_days'].contains("Wed")){setState(() {
            _wednesday=true;
            close_Days.add("Wed");
          }); }
          if(shedule.docs[0]['close_days'].contains("Thu")){setState(() {
            _thursday=true;
            close_Days.add("Thu");
          }); }
          if(shedule.docs[0]['close_days'].contains("Fri")){setState(() {
            _friday=true;
            close_Days.add("Fri");
          }); }
          if(shedule.docs[0]['close_days'].contains("Sat")){setState(() {
            _saturday=true;
            close_Days.add("Sat");
          }); }
          if(shedule.docs[0]['close_days'].contains("Sun")){setState(() {
            _sunday=true;
            close_Days.add("Sun");
          }); }

          circular = false;

          setState(() { });

        return ;
      }
      if(response.docs.length == 0){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddWorkingHours(),
          ),
        );
      }
      else{
        setState(() {
        });
      }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  /*void fetchData() async {
    var response = await networkHandler.get("/add_shedule/getShedule");
    setState(() {
      shedule=Appointment.fromJson(response["data"]);
      setState(() {
        _shedule=true;
        if(_shedule==true) {
          slots1.add(shedule.slot_1_starting_time);
          slots1.add(shedule.slot_1_ending_time);
          slots1.add(shedule.slot_2_starting_time);
          slots1.add(shedule.slot_2_ending_time);
          slots1.add(shedule.slot_3_starting_time);
          slots1.add(shedule.slot_3_ending_time);
          slots1.add(shedule.slot_4_starting_time);
          slots1.add(shedule.slot_4_ending_time);
          slots1.add(shedule.slot_5_starting_time);
          slots1.add(shedule.slot_5_ending_time);
          slots1.add(shedule.slot_6_starting_time);
          slots1.add(shedule.slot_6_ending_time);
          slots1.removeWhere((item) => item == "null");
          String x = slots1.last;
          slots1.remove(slots1.last);
          if(slots1.length<12){
            for(int i = slots1.length;i<12;i++){
              slots1.add("");
            }
            slots1[11]=x;

            openingtime = slots1[0] == "" ? null : stringToTime (slots1[0]);
            break_1_from = slots1[1] == "" ? null : stringToTime(slots1[1]);
            break_1_to = slots1[2] == "" ? null : stringToTime(slots1[2]);
            break_2_from = slots1[3] == "" ? null : stringToTime(slots1[3]);
            break_2_to = slots1[4] == "" ? null : stringToTime(slots1[4]);
            break_3_from = slots1[5] == "" ? null : stringToTime(slots1[5]);
            break_3_to = slots1[6] == "" ? null : stringToTime(slots1[6]);
            break_4_from = slots1[7] == "" ? null : stringToTime(slots1[7]);
            break_4_to = slots1[8] == "" ? null : stringToTime(slots1[8]);
            break_5_from = slots1[9] == "" ? null : stringToTime(slots1[9]);
            break_5_to = slots1[10] == "" ? null : stringToTime(slots1[10]);
            closingtime = slots1[11] == "" ? null : stringToTime(slots1[11]);
          }
          if(shedule.close_days.contains("Mon")){setState(() {
            _monday=true;
            close_Days.add("Mon");
          }); }
          if(shedule.close_days.contains("Tue")){setState(() {
            _tuesday=true;
            close_Days.add("Tue");
          }); }
          if(shedule.close_days.contains("Wed")){setState(() {
            _wednesday=true;
            close_Days.add("Wed");
          }); }
          if(shedule.close_days.contains("Thu")){setState(() {
            _thursday=true;
            close_Days.add("Thu");
          }); }
          if(shedule.close_days.contains("Fri")){setState(() {
            _friday=true;
            close_Days.add("Fri");
          }); }
          if(shedule.close_days.contains("Sat")){setState(() {
            _saturday=true;
            close_Days.add("Sat");
          }); }
          if(shedule.close_days.contains("Sun")){setState(() {
            _sunday=true;
            close_Days.add("Sun");
          }); }
        }
        circular = false;
      });
    });
  }
*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text('Schedule',style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,fontSize: 28,
            textStyle: TextStyle(color: Colors.white))),
        centerTitle: true,
      ),
      body: circular ? Center(child: CircularProgressIndicator()) : Container(
        padding: EdgeInsets.fromLTRB(8,8,8,0),
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.only(left: 10,top: 10),

                decoration: BoxDecoration(
                    color: Colors.white,
                ),
                child: Text("Business hours", style: headingStyle,)),
            Container(
                padding: EdgeInsets.only(left:20 ,right: 20,top: 5,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))

                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //opening time
                    ListTile(
                      title: Text(openingtime == null
                          ? "Opening time :- "
                          : openingtime?.period == DayPeriod.am
                          ? "Opening time :- ${openingtime?.hour}:${openingtime?.minute} AM"
                          : "Opening time :- ${openingtime?.hour}:${openingtime?.minute} PM"),
                      trailing: Icon(Icons.add),
                      onTap: () async {
                        TimeOfDay? o = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (o != null)
                          setState(() {
                            openingtime = o;
                            timeChange[0] = true;
                          });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        //shrinkWrap: true,
                        children: [
                          //break1
                          ListTile(
                            title: Row(
                              children: [
                                Text("Break 1:-"),
                                TextButton(
                                    onPressed: () async {
                                      if (openingtime == null) {
                                        _errorMessageDialog(context, _openingtime);
                                      }
                                      else if (closingtime == null) {
                                        _errorMessageDialog(context, _closingtime);
                                      }
                                      else{TimeOfDay? b1f = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      if (b1f != null)
                                        setState(() {
                                          break_1_from = b1f;
                                          timeChange[1] = true;
                                        });
                                      }},
                                    child: Text(break_1_from == null
                                        ? "NA"
                                        : break_1_from?.period == DayPeriod.am
                                        ? "${break_1_from?.hour}:${break_1_from?.minute} AM"
                                        : "${break_1_from?.hour}:${break_1_from?.minute} PM")),
                                Text("-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_1_from == null) {
                                        _errorMessageDialog(context, _break_1_from);
                                      }
                                      if ((openingtime!.hour.toDouble() +
                                          openingtime!.minute.toDouble() / 60.0) >
                                          (break_1_from!.hour.toDouble() +
                                              break_1_from!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, opening_gt_break_1_from);
                                      }
                                      else{
                                        TimeOfDay? b1t = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                        if (b1t != null)
                                          setState(() {
                                            break_1_to = b1t;
                                            timeChange[2] = true;

                                          });
                                      }},
                                    child: Text(break_1_to == null
                                        ? "NA"
                                        : break_1_to?.period == DayPeriod.am
                                        ?  "${break_1_to?.hour}:${break_1_to?.minute} AM"
                                        :   "${break_1_to?.hour}:${break_1_to?.minute} PM")),
                              ],
                            ),
                            /* trailing: Icon(Icons.remove),
                              onTap: ()  {
                                   setState(() {
                                    break_1_from = null;
                                    break_1_to = null;
                                  });
                              }*/
                          ),
                          // break 2
                          ListTile(
                            title: Row(
                              children: [
                                Text("Break 2:-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_1_to == null) {
                                        _errorMessageDialog(context, _break_1_to);
                                      }
                                      if ((break_1_from!.hour.toDouble() +
                                          break_1_from!.minute.toDouble() / 60.0) >
                                          (break_1_to!.hour.toDouble() +
                                              break_1_to!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, break_1_from_gt_break_1_to);
                                      }
                                      else{
                                        TimeOfDay? b2f = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                        if (b2f != null)
                                          setState(() {
                                            break_2_from = b2f;
                                            timeChange[3] = true;
                                          });
                                      }},
                                    child: Text(break_2_from == null
                                        ? "NA"
                                        : break_2_from?.period == DayPeriod.am
                                        ?  "${break_2_from?.hour}:${break_2_from?.minute} AM"
                                        :   "${break_2_from?.hour}:${break_2_from?.minute} PM")),
                                Text("-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_2_from == null) {
                                        _errorMessageDialog(context, _break_2_from);
                                      }
                                      if ((break_1_to!.hour.toDouble() +
                                          break_1_to!.minute.toDouble() / 60.0) >
                                          (break_2_from!.hour.toDouble() +
                                              break_2_from!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, break_1_to_gt_break_2_from);
                                      }
                                      else{
                                        TimeOfDay? b2t = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                        if (b2t != null)
                                          setState(() {
                                            break_2_to = b2t;
                                            timeChange[4] = true;
                                          });
                                      }},
                                    child: Text(break_2_to == null
                                        ? "NA"
                                        : break_2_to?.period == DayPeriod.am
                                        ?  "${break_2_to?.hour}:${break_2_to?.minute} AM"
                                        :   "${break_2_to?.hour}:${break_2_to?.minute} PM")),
                              ],
                            ),
/*
                              trailing: Icon(Icons.remove),
                              onTap: ()  {
                                setState(() {
                                  break_2_from = null;
                                  break_2_to = null;
                                });
                              }*/
                          ),
                          //break 3
                          ListTile(
                            title: Row(
                              children: [
                                Text("Break 3:-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_2_to == null) {
                                        _errorMessageDialog(context, _break_2_to);
                                      }
                                      else if ((break_2_from!.hour.toDouble() +
                                          break_2_from!.minute.toDouble() / 60.0) >
                                          (break_2_to!.hour.toDouble() +
                                              break_2_to!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, break_2_from_gt_break_2_to);
                                      }
                                      else{TimeOfDay? b3f = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      if (b3f != null)
                                        setState(() {
                                          break_3_from = b3f;
                                          timeChange[5] = true;

                                        });
                                      }},
                                    child: Text(break_3_from == null
                                        ? "NA"
                                        : break_3_from?.period == DayPeriod.am
                                        ?  "${break_3_from?.hour}:${break_3_from?.minute} AM"
                                        :   "${break_3_from?.hour}:${break_3_from?.minute} PM")),
                                Text("-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_3_from == null) {
                                        _errorMessageDialog(context, _break_3_from);
                                      }
                                      if ((break_2_to!.hour.toDouble() +
                                          break_2_to!.minute.toDouble() / 60.0) >
                                          (break_3_from!.hour.toDouble() +
                                              break_3_from!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, break_2_to_gt_break_3_from);
                                      }
                                      else{TimeOfDay? b3t = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      if (b3t != null)
                                        setState(() {
                                          break_3_to = b3t;
                                          timeChange[6] = true;
                                        });
                                      }},
                                    child: Text(break_3_to == null
                                        ? "NA"
                                        : break_3_to?.period == DayPeriod.am
                                        ?  "${break_3_to?.hour}:${break_3_to?.minute} AM"
                                        :   "${break_3_to?.hour}:${break_3_to?.minute} PM")),
                              ],
                            ),
                            /*
                              trailing: Icon(Icons.remove),
                              onTap: ()  {
                                setState(() {
                                  break_3_from = null;
                                  break_3_to = null;
                                });
                              }*/
                          ),
                          //break 4
                          ListTile(
                            title: Row(
                              children: [
                                Text("Break 4:-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_3_to == null) {
                                        _errorMessageDialog(context, _break_3_to);
                                      } else if ((break_3_from!.hour.toDouble() +
                                          break_3_from!.minute.toDouble() / 60.0) >
                                          (break_3_to!.hour.toDouble() +
                                              break_3_to!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, break_3_from_gt_break_3_to);
                                      }
                                      else{TimeOfDay? b4f = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      if (b4f != null)
                                        setState(() {
                                          break_4_from = b4f;
                                          timeChange[7] = true;
                                        });
                                      }},
                                    child: Text(break_4_from == null
                                        ? "NA"
                                        : break_4_from?.period == DayPeriod.am
                                        ?  "${break_4_from?.hour}:${break_4_from?.minute} AM"
                                        :   "${break_4_from?.hour}:${break_4_from?.minute} PM")),
                                Text("-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_4_from == null) {
                                        _errorMessageDialog(context, _break_4_from);
                                      }
                                      if ((break_3_to!.hour.toDouble() +
                                          break_3_to!.minute.toDouble() / 60.0) >
                                          (break_4_from!.hour.toDouble() +
                                              break_4_from!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, break_3_to_gt_break_4_from);
                                      }
                                      else{TimeOfDay? b4t = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      if (b4t != null)
                                        setState(() {
                                          break_4_to = b4t;
                                          timeChange[8] = true;
                                        });
                                      }},
                                    child: Text(break_4_to == null
                                        ? "NA"
                                        : break_4_to?.period == DayPeriod.am
                                        ?  "${break_4_to?.hour}:${break_4_to?.minute} AM"
                                        :   "${break_4_to?.hour}:${break_4_to?.minute} PM")),
                              ],
                            ),
                            /*
                              trailing: Icon(Icons.remove),
                              onTap: ()  {
                                setState(() {
                                  break_4_from = null;
                                  break_4_to = null;
                                });
                              }*/
                          ),
                          //break 5
                          ListTile(
                            title: Row(
                              children: [
                                Text("Break 5:-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_4_to == null) {
                                        _errorMessageDialog(context, _break_4_to);
                                      } else if ((break_4_from!.hour.toDouble() +
                                          break_4_from!.minute.toDouble() / 60.0) >
                                          (break_4_to!.hour.toDouble() +
                                              break_4_to!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, break_4_from_gt_break_4_to);
                                      }
                                      else{TimeOfDay? b5f = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      if (b5f != null)
                                        setState(() {
                                          break_5_from = b5f;
                                          timeChange[9] = true;
                                        });
                                      }},
                                    child: Text(break_5_from == null
                                        ? "NA"
                                        : break_5_from?.period == DayPeriod.am
                                        ?  "${break_5_from?.hour}:${break_5_from?.minute} AM"
                                        :   "${break_5_from?.hour}:${break_5_from?.minute} PM")),
                                Text("-"),
                                TextButton(
                                    onPressed: () async {
                                      if (break_5_from == null) {
                                        _errorMessageDialog(context, _break_5_from);
                                      }
                                      if ((break_4_to!.hour.toDouble() +
                                          break_4_to!.minute.toDouble() / 60.0) >
                                          (break_5_from!.hour.toDouble() +
                                              break_5_from!.minute.toDouble() / 60.0)) {
                                        _errorMessageDialog(
                                            context, break_4_to_gt_break_5_from);
                                      }
                                      else{TimeOfDay? b5t = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      if (b5t != null)
                                        setState(() {
                                          break_5_to = b5t;
                                          timeChange[10] = true;
                                        });
                                      }},
                                    child: Text(break_5_to == null
                                        ? "NA"
                                        : break_5_to?.period == DayPeriod.am
                                        ?  "${break_5_to?.hour}:${break_5_to?.minute} AM"
                                        :   "${break_5_to?.hour}:${break_5_to?.minute} PM")),
                              ],
                            ), /*
                              trailing: Icon(Icons.remove),
                              onTap: ()  {
                                setState(() {
                                  break_5_from = null;
                                  break_5_to = null;
                                });
                              }*/
                          ),
                        ],
                      ),
                    ),
                    //closing time
                    ListTile(
                      title: Text(closingtime == null
                          ? "Closing time :-"
                          : closingtime?.period == DayPeriod.am
                          ? "Closing time :- ${closingtime?.hour}:${closingtime?.minute} AM"
                          : "Closing time :- ${closingtime?.hour}:${closingtime?.minute} PM"),
                      trailing: Icon(Icons.add),
                      onTap: () async {
                        if (openingtime == null) {
                          _errorMessageDialog(context, _openingtime);
                        }
                        else{TimeOfDay? c = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (c != null)
                          setState(() {
                            closingtime = c;
                            timeChange[11] = true;
                          });
                        }},
                    ),
                  ],
                )),
            //SizedBox(height: 10,),
            /*Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              height: 1,
              width: MediaQuery.of(context).size.width-300,
              alignment: Alignment.center,
              color: Colors.blue,
            ),*/

            Container(
              height: 10,
              color: backgroundColor,
            ),
            Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                color: Colors.white,
                child: Text("Close days", style: headingStyle,)),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 80),
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                      title: Text("Monday"),
                      value: _monday,
                      onChanged: (value){
                        setState(() {
                          _monday=value!;
                          _monday? close_Days.add("Mon"):close_Days.remove("Mon");
                          print("close days:-$close_Days");
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Tuesday"),
                      value: _tuesday,
                      onChanged: (value){
                        setState(() {
                          _tuesday=value!;
                          _tuesday? close_Days.add("Tue"):close_Days.remove("Tue");
                          print("close days:-$close_Days");
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Wednesday"),
                      value: _wednesday,
                      onChanged: (value){
                        setState(() {
                          _wednesday=value!;
                          _wednesday? close_Days.add("Wed"):close_Days.remove("Wed");
                          print("close days:-$close_Days");
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Thursday"),
                      value: _thursday,
                      onChanged: (value){
                        setState(() {
                          _thursday=value!;
                          _thursday? close_Days.add("Thu"):close_Days.remove("Thu");
                          print("close days:-$close_Days");
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Friday"),
                      value: _friday,
                      onChanged: (value){
                        setState(() {
                          _friday=value!;
                          _friday? close_Days.add("Fri"):close_Days.remove("Fri");
                          print("close days:-$close_Days");
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Saturday"),
                      value: _saturday,
                      onChanged: (value){
                        setState(() {
                          _saturday=value!;
                          _saturday? close_Days.add("Sat"):close_Days.remove("Sat");
                          print("close days:-$close_Days");
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Sunday"),
                      value: _sunday,
                      onChanged: (value){
                        setState(() {
                          _sunday=value!;
                          _sunday? close_Days.add("Sun"):close_Days.remove("Sun");
                          print("close days:-$close_Days");
                        });
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(circular==false) {

            /*
                        if(openingtime==null){
                          _errorMessageDialog(context, _openingtime);
                        }
                        else if(break_1_from==null && break_1_to!=null){
                          _errorMessageDialog(context, _break_1_from);
                        }
                        else if(break_1_from!=null && break_1_to==null){
                          _errorMessageDialog(context, _break_1_to);
                        }
                        else if(break_2_from==null && break_2_to!=null){
                          _errorMessageDialog(context, _break_2_from);
                        }
                        else if(break_2_from!=null && break_2_to==null){
                          _errorMessageDialog(context, _break_2_to);
                        }
                        else if(break_3_from==null && break_3_to!=null){
                          _errorMessageDialog(context, _break_3_from);
                        }
                        else if(break_3_from!=null && break_3_to==null){
                          _errorMessageDialog(context, _break_3_to);
                        }
                        else if(break_4_from==null && break_4_to!=null){
                          _errorMessageDialog(context, _break_4_from);
                        }
                        else if(break_4_from!=null && break_4_to==null){
                          _errorMessageDialog(context, _break_4_to);
                        }
                        else if(break_5_from==null && break_5_to!=null){
                          _errorMessageDialog(context, _break_5_from);
                        }
                        else*/
            if (break_1_from != null &&
                break_2_from != null &&
                break_3_from != null &&
                break_4_from != null &&
                break_5_from != null) {
              if (break_5_to == null) {
                _errorMessageDialog(context, _break_5_to);
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_break_1_from);
              } else if ((break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0) >
                  (break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_from_gt_break_1_to);
              } else if ((break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0) >
                  (break_2_from!.hour.toDouble() +
                      break_2_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_to_gt_break_2_from);
              } else if ((break_2_from!.hour.toDouble() +
                      break_2_from!.minute.toDouble() / 60.0) >
                  (break_2_to!.hour.toDouble() +
                      break_2_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_2_from_gt_break_2_to);
              }
              if ((break_2_to!.hour.toDouble() +
                      break_2_to!.minute.toDouble() / 60.0) >
                  (break_3_from!.hour.toDouble() +
                      break_3_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_2_to_gt_break_3_from);
              } else if ((break_3_from!.hour.toDouble() +
                      break_3_from!.minute.toDouble() / 60.0) >
                  (break_3_to!.hour.toDouble() +
                      break_3_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_3_from_gt_break_3_to);
              }
              if ((break_3_to!.hour.toDouble() +
                      break_3_to!.minute.toDouble() / 60.0) >
                  (break_4_from!.hour.toDouble() +
                      break_4_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_3_to_gt_break_4_from);
              } else if ((break_4_from!.hour.toDouble() +
                      break_4_from!.minute.toDouble() / 60.0) >
                  (break_4_to!.hour.toDouble() +
                      break_4_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_4_from_gt_break_4_to);
              }
              if ((break_4_to!.hour.toDouble() +
                      break_4_to!.minute.toDouble() / 60.0) >
                  (break_5_from!.hour.toDouble() +
                      break_5_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_4_to_gt_break_5_from);
              }
              if ((break_5_from!.hour.toDouble() +
                      break_5_from!.minute.toDouble() / 60.0) >
                  (break_5_to!.hour.toDouble() +
                      break_5_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_5_from_gt_break_5_to);
              } else if ((break_5_to!.hour.toDouble() +
                      break_5_to!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_5_to_gt_closing_time);
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_closing);
              } else {
                slotPrint(5);
              }
            }

            if (break_1_from != null &&
                break_2_from != null &&
                break_3_from != null &&
                break_4_from != null &&
                break_5_from == null) {
              if (break_4_to == null) {
                _errorMessageDialog(context, _break_4_to);
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_break_1_from);
              } else if ((break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0) >
                  (break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_from_gt_break_1_to);
              } else if ((break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0) >
                  (break_2_from!.hour.toDouble() +
                      break_2_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_to_gt_break_2_from);
              } else if ((break_2_from!.hour.toDouble() +
                      break_2_from!.minute.toDouble() / 60.0) >
                  (break_2_to!.hour.toDouble() +
                      break_2_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_2_from_gt_break_2_to);
              }
              if ((break_2_to!.hour.toDouble() +
                      break_2_to!.minute.toDouble() / 60.0) >
                  (break_3_from!.hour.toDouble() +
                      break_3_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_2_to_gt_break_3_from);
              } else if ((break_3_from!.hour.toDouble() +
                      break_3_from!.minute.toDouble() / 60.0) >
                  (break_3_to!.hour.toDouble() +
                      break_3_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_3_from_gt_break_3_to);
              }
              if ((break_3_to!.hour.toDouble() +
                      break_3_to!.minute.toDouble() / 60.0) >
                  (break_4_from!.hour.toDouble() +
                      break_4_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_3_to_gt_break_4_from);
              } else if ((break_4_from!.hour.toDouble() +
                      break_4_from!.minute.toDouble() / 60.0) >
                  (break_4_to!.hour.toDouble() +
                      break_4_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_4_from_gt_break_4_to);
              } else if ((break_4_to!.hour.toDouble() +
                      break_4_to!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(
                    context, "Break 4 should end before Closing time");
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_closing);
              } else {
                slotPrint(4);
              }
            }

            if (break_1_from != null &&
                break_2_from != null &&
                break_3_from != null &&
                break_4_from == null &&
                break_5_from == null) {
              if (break_3_to == null) {
                _errorMessageDialog(context, _break_4_to);
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_break_1_from);
              } else if ((break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0) >
                  (break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_from_gt_break_1_to);
              } else if ((break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0) >
                  (break_2_from!.hour.toDouble() +
                      break_2_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_to_gt_break_2_from);
              } else if ((break_2_from!.hour.toDouble() +
                      break_2_from!.minute.toDouble() / 60.0) >
                  (break_2_to!.hour.toDouble() +
                      break_2_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_2_from_gt_break_2_to);
              }
              if ((break_2_to!.hour.toDouble() +
                      break_2_to!.minute.toDouble() / 60.0) >
                  (break_3_from!.hour.toDouble() +
                      break_3_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_2_to_gt_break_3_from);
              } else if ((break_3_from!.hour.toDouble() +
                      break_3_from!.minute.toDouble() / 60.0) >
                  (break_3_to!.hour.toDouble() +
                      break_3_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_3_from_gt_break_3_to);
              }
              if ((break_3_to!.hour.toDouble() +
                      break_3_to!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(
                    context, "Break 3 should end before Closing time");
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_5_from_gt_break_5_to);
              } else {
                slotPrint(3);
              }
            }

            if (break_1_from != null &&
                break_2_from != null &&
                break_3_from == null &&
                break_4_from == null &&
                break_5_from == null) {
              if (break_2_to == null) {
                _errorMessageDialog(context, _break_4_to);
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_break_1_from);
              } else if ((break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0) >
                  (break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_from_gt_break_1_to);
              } else if ((break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0) >
                  (break_2_from!.hour.toDouble() +
                      break_2_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_to_gt_break_2_from);
              } else if ((break_2_from!.hour.toDouble() +
                      break_2_from!.minute.toDouble() / 60.0) >
                  (break_2_to!.hour.toDouble() +
                      break_2_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_2_from_gt_break_2_to);
              } else if ((break_2_to!.hour.toDouble() +
                      break_2_to!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(
                    context, "Break 2 should end before Closing time");
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_closing);
              } else {
                slotPrint(2);
              }
            }

            if (break_1_from != null &&
                break_2_from == null &&
                break_3_from == null &&
                break_4_from == null &&
                break_5_from == null) {
              if (break_1_to == null) {
                _errorMessageDialog(context, _break_4_to);
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_break_1_from);
              } else if ((break_1_from!.hour.toDouble() +
                      break_1_from!.minute.toDouble() / 60.0) >
                  (break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_1_from_gt_break_1_to);
              } else if ((break_1_to!.hour.toDouble() +
                      break_1_to!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(
                    context, "Break 1 should end before Closing time");
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, break_5_from_gt_break_5_to);
              } else {
                slotPrint(1);
              }
            }

            if (break_1_from == null) {
              if (openingtime == null) {
                _errorMessageDialog(context, _openingtime);
              } else if (closingtime == null) {
                _errorMessageDialog(context, _closingtime);
              } else if ((openingtime!.hour.toDouble() +
                      openingtime!.minute.toDouble() / 60.0) >
                  (closingtime!.hour.toDouble() +
                      closingtime!.minute.toDouble() / 60.0)) {
                _errorMessageDialog(context, opening_gt_closing);
              } else {
                slotPrint(0);
              }
            }

            /*slots.add(openingtime);
          if(break_1_from!=null){slots.add(break_1_from);}
          else if (break_1_to !=null){slots.add(break_1_to);}
          else if (break_2_from != null){slots.add(break_2_from);}
          else if (break_2_to != null){slots.add(break_2_to);}
          else if (break_3_from != null){slots.add(break_3_from);}
          else if (break_3_to != null){slots.add(break_3_to);}
          else if (break_4_from != null){slots.add(break_4_from);}
          else if (break_4_to != null){slots.add(break_4_to);}
          else if (break_5_from != null){slots.add(break_5_from);}
          else if (break_5_to != null){slots.add(break_5_to);}
          else {slots.add(closingtime);}
          print(slots);*/
          }
        },
        tooltip: 'Done',
        child: Icon(Icons.done),
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

  slotPrint(int x) async{
    print("0");
    slots.clear();
    slots.add("${openingtime?.hour}:${openingtime?.minute}");
    if(break_1_from!=null){slots.add("${break_1_from?.hour}:${break_1_from?.minute}");}
    if (break_1_to !=null){slots.add("${break_1_to?.hour}:${break_1_to?.minute}");}
    if (break_2_from != null){slots.add("${break_2_from?.hour}:${break_2_from?.minute}");}
    if (break_2_to != null){slots.add("${break_2_to?.hour}:${break_2_to?.minute}");}
    if (break_3_from != null){slots.add("${break_3_from?.hour}:${break_3_from?.minute}");}
    if (break_3_to != null){slots.add("${break_3_to?.hour}:${break_3_to?.minute}");}
    if (break_4_from != null){slots.add("${break_4_from?.hour}:${break_4_from?.minute}");}
    if (break_4_to != null){slots.add("${break_4_to?.hour}:${break_4_to?.minute}");}
    if (break_5_from != null){slots.add("${break_5_from?.hour}:${break_5_from?.minute}");}
    if (break_5_to != null){slots.add("${break_5_to?.hour}:${break_5_to?.minute}");}
    slots.add("${closingtime?.hour}:${closingtime?.minute}");

    for(var i=slots.length;i<=11;i++){
      slots.add("");
    }

    print (slots);
    print (close_Days);
    print ("1");

     db.collection('Cash Drop').doc(shedule.docs[0].id)
         .update({
       'uid': user!.uid,
       'Business Name': user!.displayName,
       'slot_1_starting_time': slots[0].toString(),
       'slot_1_ending_time':slots[1].toString() ,
       'slot_2_starting_time': slots[2].toString(),
       'slot_2_ending_time': slots[3].toString(),
       'slot_3_starting_time': slots[4].toString(),
       'slot_3_ending_time':slots[5].toString() ,
       'slot_4_starting_time': slots[6].toString(),
       'slot_4_ending_time': slots[7].toString(),
       'slot_5_starting_time': slots[8].toString(),
       'slot_5_ending_time': slots[9].toString(),
       'slot_6_starting_time': slots[10].toString(),
       'slot_6_ending_time': slots[11].toString(),
       'close_days': close_Days,
    }).then((value) => fetchServicesData());
  }

  stringToTime(String slotTime){
    return slotTime=="null"?null:TimeOfDay(
        hour: int.parse(slotTime.split(":")[0]),
        minute: int.parse(slotTime.split(":")[1]));
  }


}