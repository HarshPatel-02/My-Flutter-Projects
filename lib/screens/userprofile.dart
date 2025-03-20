import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/screens/getData.dart';
import 'package:task1/ui_widgets/custom_textfield.dart';

class userprofile extends StatefulWidget {
  const userprofile({super.key});


  @override
  State<userprofile> createState() => _userprofileState();

}

class _userprofileState extends State<userprofile> {
  List<String> items = <String>['Male', 'Female'];
  File? _image;
  String? base64Image;  // For storing the image string

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





  // Method to load SharedPreferences data
  Future<void> loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      firstnameController.text = sp.getString("firstname") ?? '';
      lastnameController.text = sp.getString("lastname") ?? '';
      emailController.text = sp.getString("email") ?? '';
      dateofbirthController.text = sp.getString("dateofbirth") ?? '';
      phonenoController.text = sp.getString("mobileno") ?? '';
      dropdownValue = sp.getString("gender") ?? 'Male';

      base64Image = sp.getString("profileImage");
    });
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
              CustomTextfield(hintText: 'FirstName', controller: firstnameController),
              CustomTextfield(hintText: 'Last Name', controller: lastnameController),
              CustomTextfield(hintText: 'Email', controller: emailController),
              CustomTextfield(hintText: 'date Of Birth', controller: dateofbirthController),
              CustomTextfield(hintText: 'Phone Number', controller: phonenoController),

              Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: DropdownButton<String>(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    borderRadius: BorderRadius.circular(10),
                    iconSize: 24,
                    onChanged: (String? newValue) {
                      dropdownValue = newValue!;
                      if (mounted) setState(() {});
                    },
                    elevation: 16,
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
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.setString("firstname", firstnameController.text);
                  sp.setString("lastname", lastnameController.text);
                  sp.setString("email", emailController.text);
                  sp.setString("dateofbirth", dateofbirthController.text);
                  sp.setString("mobileno", phonenoController.text);
                  sp.setString("gender", dropdownValue);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data Saved Successfully',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown.shade700),),
                      backgroundColor: Colors.brown.shade100,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context, true);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade200,
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
