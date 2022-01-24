import 'dart:io';

import 'package:cash_drop/Admin/Appointment.dart';
import 'package:cash_drop/Admin/AdminHome.dart';
import 'package:cash_drop/Screens/Home.dart';
import 'package:cash_drop/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddAdminProfile extends StatefulWidget {
  const AddAdminProfile({Key? key}) : super(key: key);

  @override
  _AddAdminProfileState createState() => _AddAdminProfileState();
}

class _AddAdminProfileState extends State<AddAdminProfile> {

  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  final _globalKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController businessDescription = TextEditingController();
  TextEditingController dOB = TextEditingController();
  TextEditingController address = TextEditingController();

  var currency = ['\₹', '\$', '\£','\€'];
  var currencySelected = '';
  String? dropdownValue ;

  List<String> categories=['Saloon','Beauty Parlour','Chemist or Pharmacy (Medical)',
                            'Garage','Tour & Travel Organizers','Automobile Dealer',
                              'Event Organizers','Cleaning & Pest Control','Restaurant','Other'];

  DateTime date = DateTime.now();
  DateTime memberSince= DateTime.now();

  bool uploading = false;
  bool addImage = false;
  bool circular = false;
  bool validate = true;
  bool alphabetsOnly = false;
  late String errorText;

  Widget Logo() {
    return InkWell(
      child: Container(
        height: MediaQuery.of(context).size.height*0.25,
        color: Colors.grey,
        child: _imageFile == null
            ? Container(
          child: Center(
              child: addImage
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.redAccent,
                  ),
                  Text('Add Image!',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          textStyle:
                          TextStyle(color: Colors.redAccent)))
                ],
              )
                  : Icon(
                Icons.image,
                size: 100,
                color: Colors.white,
              )),
          height: 150,
        )
            : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(_imageFile!.path)),
                  fit: BoxFit.cover,
                ))),
      ),
      onTap: () async {
        final pickedFile = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 10);
        setState(() {
          _imageFile = pickedFile;
        });
      },
    );
  }

  Widget buildBusinessNameTF(
      TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        decoration: InputDecoration(
          errorText: validate ? null: errorText ,
          labelText: "$label",
          counterText: '',
        ),
        maxLines: 1,
        maxLength: 15,
      ),
    );
  }

  Widget buildCategoryTF(
      TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        validator: (value) {
          if ((value ==null || value.isEmpty) && dropdownValue == 'Other') {
            return "Enter Business Category";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "$label",
        ),
        maxLines: 1,
      ),
    );
  }

  Widget buildCategory(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value ==null || value.isEmpty) {
            return "Select Business Category";
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Category'),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        elevation: 16,

        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: categories
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildBusinessDescriptionTF(
      TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        validator: (value) {
          if (value ==null || value.isEmpty) {
            return "Enter $label";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "$label",
        ),
        maxLines: 3,
      ),
    );
  }

  Widget buildEmailidTF(
      TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(

        controller: controller,
        validator: (value) {
          if (value ==null || value.isEmpty) {
            return "Enter $label";
          }
          return null;
        },
        onTap: () async {
          // Below line stops keyboard from appearing
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        decoration: InputDecoration(

            labelText: "$label",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: user!.email!,
            hintStyle: TextStyle(
                color: Colors.black
            )
        ),
        maxLines: 1,
      ),
    );
  }

  Widget buildAddressTF(
      TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value ==null || value.isEmpty) {
            return "Enter $label";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "$label",
          counterText: '',
        ),
        maxLines: 2,
      ),
    );
  }

  Widget buildDateOfBirthField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
          controller: dOB,
          validator: (value){
            if (value ==null || value.isEmpty) {
              return "Enter Date Of Birth";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Date Of Birth",
          ),
          maxLines: 1,
          onTap: () async {
            // Below line stops keyboard from appearing
            FocusScope.of(context).requestFocus(new FocusNode());
            // Show Date Picker Here
            await _selectDate(context);
            dOB.text = DateFormat('dd - MM - yyyy').format(date);
            //setState(() {});
          }),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      print('hello $picked');
      setState(() {
        date = picked;
      });
    }
  }

  checkBusinessName() async {
    if (businessName.text.length == 0) {
      setState(() {
        // circular = false;
        validate = false;
        errorText = "Username Can't be empty";
      });
      return;
    }
    else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(businessName.text)) {
      setState(() {
        // circular = false;
        validate = false;
        errorText = "Enter alphabets only";
      });
      return;
    }
    else {
      // print("user id ${authController.userId}");
      try {
        var response = await db
            .collection('Business Profile')
            .where('Name Check', isEqualTo: businessName.text.toLowerCase())
            .get();
        if (response.docs.length > 0) {
          setState(() {
            circular = false;
            validate = false;
            errorText = "Business Name already taken";
          });
        } else {
          setState(() {
            // circular = false;
            validate = true;
          });
        }
        print(response.docs[0]['First Name']);
      } on FirebaseException catch (e) {
        print(e);
      } catch (error) {
        print(error);
      }
    }
  }

  setSearchParam(String businessName) {
    List<String> businessSearchList = [] ;
    String temp = "";
    for (int i = 0; i < businessName.length; i++) {
      temp = temp + businessName[i];
      businessSearchList.add(temp);
    }
    return businessSearchList;
  }

  void updateDisplayName() async {
    user!.updateDisplayName(businessName.text)
        .then((value) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AdminHome(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Profile',style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,fontSize: 28,
            textStyle: TextStyle(color: Colors.white))),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Logo(),
              SizedBox(height: 20),
              buildBusinessNameTF(businessName, "Business Name"),
              SizedBox(height: 20),
              buildCategory(),
              SizedBox(height: 20),
              if(dropdownValue=='Other') buildCategoryTF(category, 'Category'),
              if(dropdownValue=='Other') SizedBox(height: 20),
              buildBusinessDescriptionTF(businessDescription, "Business Description"),
              SizedBox(height: 20),
              buildEmailidTF(email, "Email ID"),
              SizedBox(height: 20),
              buildAddressTF(address, "Address")
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async{

          email.text=user!.email!;
          checkBusinessName();
          setState(() {
            addImage = true;
          });
          if(_globalKey.currentState!.validate() && validate == true && _imageFile != null ){
            final storage = FirebaseStorage.instance
                .ref()
                .child('Logo')
                .child(
                '${businessName.text}');
            final result = await storage.putFile(File(_imageFile!.path));
            final imageURL = await result.ref.getDownloadURL();
            db.collection('Business Profile').add({
              'uid': user!.uid,
              'Logo':imageURL,
              'Business Name': businessName.text,
              'Name Check': businessName.text.toLowerCase(),
              'Business Search':setSearchParam(businessName.text),
              if(dropdownValue != 'other') 'Category': dropdownValue,
              if(dropdownValue == 'other') 'Category': category.text,
              'Business Description': businessDescription.text,
              'Email': email.text,
              'Member Since': DateFormat('dd - MM - yyyy').format(memberSince),
              'Address': address.text
            }).then((value) => updateDisplayName());
          }
        },
        child: circular?CircularProgressIndicator():Icon(Icons.thumb_up_alt_rounded),
      ),
    );
  }
}
