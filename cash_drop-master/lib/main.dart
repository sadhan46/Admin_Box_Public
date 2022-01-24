import 'package:cash_drop/Admin/AddAdminProfile.dart';
import 'package:cash_drop/Admin/Appointment.dart';
import 'package:cash_drop/Admin/AdminProfile.dart';
import 'package:cash_drop/Admin/ChatRoom.dart';
import 'package:cash_drop/Admin/Chats.dart';
import 'package:cash_drop/Admin/Clips.dart';
import 'package:cash_drop/Admin/Model/message_model.dart';
import 'package:cash_drop/Admin/Trying.dart';
import 'package:cash_drop/Admin/UploadClip.dart';
import 'package:cash_drop/Admin/AddWorkingHours.dart';
import 'package:cash_drop/Screens/Business.dart';
import 'package:cash_drop/Admin/Catalog.dart';
import 'package:cash_drop/Screens/BusinessProfile.dart';
import 'package:cash_drop/Screens/Home.dart';
import 'package:cash_drop/Screens/Login.dart';
import 'package:cash_drop/Screens/NewHome.dart';
import 'package:cash_drop/Screens/Pay.dart';
import 'package:cash_drop/Screens/AddProfile.dart';
import 'package:cash_drop/Screens/Profile.dart';
import 'package:cash_drop/Screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUp(),
    );
  }
}

