import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/dataBase/DataBaseHelperClass.dart';
import 'package:task1/ui_widgets/custom_textfield.dart';

class userprofile extends StatefulWidget {
  const userprofile({super.key});

  @override
  State<userprofile> createState() => _userprofileState();
}

class _userprofileState extends State<userprofile> {
  List<String> items = <String>['Male', 'Female'];
  File? _image;
  String? base64Image;

  final DataBaseHelper dbHelper = DataBaseHelper.instance;
  String dropdownValue = 'Male';
  final _formKey = GlobalKey<FormState>(); // Add Form key for validation

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

      List<int> imageBytes = await _image!.readAsBytes();
      base64Image = base64Encode(imageBytes);

      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("profileImage", base64Image!);
    }
  }

  Future<void> loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int? userId = sp.getInt('user_id');
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

    // Validate the form
    if (_formKey.currentState!.validate()) {
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
        await loadData();
        Navigator.pop(context, true);
      } catch (e) {
        print('Error saving profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields correctly')),
      );
    }
  }

  // Validation functions
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email (e.g., user@example.com)';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    final phoneRegExp = RegExp(r'^(\+\d{1,3}[- ]?)?\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number (e.g., +91 9876543210)';
    }
    if (RegExp(r'0{5,}').hasMatch(value)) {
      return 'Phone number cannot contain 5 or more consecutive zeros';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.brown.shade200,
      ),
      body: Form(
        key: _formKey, // Wrap in Form widget
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Stack(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
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
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.brown,
                        ),
                        child: InkWell(
                          onTap: _pickImage,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.brown.shade200,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextfield(
                  hintText: 'First Name',
                  controller: firstnameController,
                  suffixIcon: Icon(Iconsax.user),
                  validator: (value) => validateRequired(value, 'first name'),
                ),
                CustomTextfield(
                  hintText: 'Last Name',
                  controller: lastnameController,
                  suffixIcon: Icon(Iconsax.user),
                  validator: (value) => validateRequired(value, 'last name'),
                ),
                CustomTextfield(
                  hintText: 'Email',
                  controller: emailController,
                  suffixIcon: Icon(Icons.email),
                  validator: validateEmail,
                ),
                CustomTextfield(
                  hintText: 'Date of Birth',
                  controller: dateofbirthController,
                  suffixIcon: Icon(Iconsax.calendar),
                  validator: (value) => validateRequired(value, 'date of birth'),
                  onTap: () async {
                    DateTime? d1 = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2001, 1, 1),
                      lastDate: DateTime(2025, 1, 1),
                    );
                    if (d1 != null) {
                      dateofbirthController.text = DateFormat('dd/MM/yyyy').format(d1);
                    }
                  },
                ),
                CustomTextfield(
                  hintText: 'Phone Number',
                  controller: phonenoController,
                  suffixIcon: Icon(Icons.phone),
                  keyboardType: TextInputType.phone, // Numeric keyboard
                  validator: validatePhoneNumber,
                  onTap: () {
                    // Optional: Keep this for additional tap behavior if needed
                  },
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown.shade200,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
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
                  onPressed: saveData, // Call saveData directly
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade100,
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.brown.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}