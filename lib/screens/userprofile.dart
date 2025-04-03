import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/screens/getData.dart';
import 'package:task1/ui_widgets/custom_textfield.dart';

import '../dataBase/DataBaseHelperClass.dart';


class userprofile extends StatefulWidget {
  const userprofile({super.key});


  @override
  State<userprofile> createState() => _userprofileState();

}

class _userprofileState extends State<userprofile> {
  List<String> items = <String>['Male', 'Female'];
  File? _image;
  String? base64Image;  // For storing the image string

  final DataBaseHelper dbHelper = DataBaseHelper.instance;
  String dropdownValue = 'Male';

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateofbirthController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      // Convert image to Base64
      List<int> imageBytes = await _image!.readAsBytes();
      base64Image = base64Encode(imageBytes);

      // Save to SharedPreferences
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("profileImage", base64Image!);
    }
  }





  // Method to load sqlite data
  Future<void> loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int? userId = sp.getInt('user_id'); // Get user ID from login
    if (userId == null) {
      print('No user ID found in SharedPreferences');
      return;
    }

    try {
      final profile = await dbHelper.getUserProfile(userId);
      if (profile != null) {
        setState(() {
          firstnameController.text = profile[DataBaseHelper.P_FIRSTNAME] ?? '';
          lastnameController.text = profile[DataBaseHelper.P_LASTNAME] ?? '';
          emailController.text = profile[DataBaseHelper.P_EMAIL] ?? '';
          dateofbirthController.text = profile[DataBaseHelper.P_DOB] ?? '';
          phonenoController.text = profile[DataBaseHelper.P_PHONE] ?? '';
          dropdownValue = profile[DataBaseHelper.P_GENDER] ?? 'Male';
          base64Image = profile[DataBaseHelper.P_IMAGE];
        });
        print('Profile loaded: $profile');
      } else {
        print('No profile data found for user ID: $userId');
      }
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  Future<void> saveData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int? userId = sp.getInt('user_id');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    Map<String, dynamic> profileData = {
      DataBaseHelper.P_FIRSTNAME: firstnameController.text,
      DataBaseHelper.P_LASTNAME: lastnameController.text,
      DataBaseHelper.P_EMAIL: emailController.text,
      DataBaseHelper.P_DOB: dateofbirthController.text,
      DataBaseHelper.P_PHONE: phonenoController.text,
      DataBaseHelper.P_GENDER: dropdownValue,
      DataBaseHelper.P_IMAGE: base64Image,
    };

    try {
      await dbHelper.saveUserProfile(userId, profileData);
      print('Profile saved: $profileData');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data Saved Successfully',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown.shade700),
          ),
          backgroundColor: Colors.brown.shade100,
          duration: Duration(seconds: 2),
        ),
      );
      await loadData(); // Reload data to ensure UI reflects the saved values
    } catch (e) {
      print('Error saving profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.brown.shade200,
          ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Stack(
                children: [
                  SizedBox(height: 120,width: 120,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : base64Image != null
                          ? Image.memory(base64Decode(base64Image!), fit: BoxFit.cover)
                          : const Image(
                        image: NetworkImage(
                          'https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      // child: const Image(image: NetworkImage( 'https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg?semt=ais_hybrid'),),
                    ) ,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.brown),
                      child: InkWell(onTap: () {
                        _pickImage();

                      },
                          child: Icon(Icons.camera_alt , size: 20,color: Colors.brown.shade200,)),
                    ),
                  )
                ],
              ),
              CustomTextfield(hintText: 'FirstName', controller: firstnameController,suffixIcon: Icon(Iconsax.user),),
              CustomTextfield(hintText: 'Last Name', controller: lastnameController,suffixIcon: Icon(Iconsax.user),),
              CustomTextfield(hintText: 'Email', controller: emailController,suffixIcon: Icon(Icons.email),),
              CustomTextfield(hintText: 'date Of Birth', controller: dateofbirthController,suffixIcon: Icon(Iconsax.calendar),),
              CustomTextfield(hintText: 'Phone Number', controller: phonenoController,suffixIcon: Icon(Icons.phone),),

              Center(
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown.shade200,

                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(32)),
                  child: DropdownButton<String>(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    borderRadius: BorderRadius.circular(10),

                    iconSize: 24,

                    onChanged: (String? newValue) {
                      dropdownValue = newValue!;
                      if (mounted) setState(() {});
                    },

                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    value: dropdownValue,
                    items: items.map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,


                        );
                      },
                    ).toList(),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                saveData();
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text('Data Saved Successfully',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown.shade700),),
                  //     backgroundColor: Colors.brown.shade100,
                  //     duration: Duration(seconds: 2),
                  //   ),
                  // );
                  Navigator.pop(context, true);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade100,
                  minimumSize: Size(200, 50),
                ),

                child: Text(
                  'Continue',
                  style: TextStyle(
                      color: Colors.brown.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )

            ],

          ),
        ),
      ),
    );
  }
}
