import 'dart:io';

import 'package:adhikar_acehack4_o/common/widgets/custom_button.dart';
import 'package:adhikar_acehack4_o/common/widgets/image_picker.dart';
import 'package:adhikar_acehack4_o/common/widgets/snackbar.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplyForLawyerScreen extends ConsumerStatefulWidget {
  const ApplyForLawyerScreen({super.key});

  @override
  ConsumerState<ApplyForLawyerScreen> createState() =>
      _ApplyForLawyerScreenState();
}

class _ApplyForLawyerScreenState extends ConsumerState<ApplyForLawyerScreen> {
  TextEditingController statecontroller = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController casesWonController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    statecontroller.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dobController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    casesWonController.dispose();
    experienceController.dispose();
    descriptionController.dispose();
  }

  PlatformFile? proofFile;
  PlatformFile? idFile;
  File? profileImage;
  // Uint8List? profImage;

  Future selectFileForProof() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        proofFile = result.files.first;
      });
      print(proofFile!.name);
    } else {
      ShowSnackbar(context, 'File not selected');
    }
  }

  Future selectFileForId() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        idFile = result.files.first;
      });
      print(idFile!.name);
    } else {
      ShowSnackbar(context, 'File not selected');
    }
  }

  void pickProfileImage() async {
    final profImage = await pickImage();
    if (profImage != null) {
      setState(() {
        profileImage = profImage;
      });
    }
  }

  // void selectProfImage() async {
  //   Uint8List im = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     profImage = im;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final List<String> states = [
      "Andhra Pradesh",
      "Arunachal Pradesh",
      "Assam",
      "Bihar",
      "Chhattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttar Pradesh",
      "Uttarakhand",
      "West Bengal",
      "Andaman and Nicobar Islands",
      "Chandigarh",
      "Dadra and Nagar Haveli and Daman and Diu",
      "Lakshadweep",
      "Delhi (National Capital Territory)",
      "Puducherry",
      "Ladakh",
      "Jammu and Kashmir",
    ];
    final currentUser = ref.watch(currentUserDataProvider).value;
    if (currentUser != null) {
      emailController.text = currentUser.email;
      firstNameController.text = currentUser.firstName;
      lastNameController.text = currentUser.lastName;
      currentUser.profileImage != ''
          ? profileImage != currentUser.profileImage
          : profileImage != "";
    }
    bool isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Pallete.primaryColor,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Apply for Adhikar Lawyer',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Pallete.primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          profileImage != null
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                      radius: 66,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          FileImage(profileImage!)),
                                )
                              : currentUser!.profileImage != ''
                                  ? CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                          radius: 66,
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                              currentUser.profileImage)),
                                    )
                                  : const CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.black,
                                      child: const CircleAvatar(
                                        radius: 66,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          'https://image.cdn2.seaart.me/2024-09-16/crjon2de878c739kmukg-2/363d4f7dce80aad62b4b1cdc12bb1ec6_high.webp',
                                        ),
                                      ),
                                    ),
                          Positioned(
                              bottom: -0,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  pickProfileImage();
                                },
                                child: const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.black,
                                  child: const CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.grey,
                                      )),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('First name'),
                    customTextField(
                        controller: firstNameController,
                        hinttext: 'Jhon Doe',
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Last name'),
                    customTextField(
                        controller: lastNameController,
                        hinttext: 'Jhon Doe',
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Email'),
                    customTextField(
                        controller: emailController,
                        hinttext: 'adhikar@gmail.com',
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Phone'),
                    customTextField(
                        controller: phoneController,
                        hinttext: '9999999999',
                        keyboardType: TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Date of birth'),
                    customTextField(
                        controller: dobController,
                        hinttext: '04/03/2004',
                        keyboardType: TextInputType.datetime),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Address line 1'),
                    customTextField(
                        controller: address1Controller,
                        hinttext: 'Flat no / Building',
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Address line 2'),
                    customTextField(
                        controller: address2Controller,
                        hinttext: 'Area / Street',
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Address line 3'),
                    customTextField(
                        controller: cityController,
                        hinttext: 'City',
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Choose your State'),
                    Row(
                      children: [
                        Expanded(
                          child: DropDownField(
                            enabled: true,
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            controller: statecontroller,
                            hintText: 'Select your State',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            items: states,
                            itemsVisibleInDropdown: 5,
                            onValueChanged: (value) {
                              setState(() {
                                statecontroller.text = value!;
                              });
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Upload proof of beign Lawyer'),
                    GestureDetector(
                      onTap: () {
                        selectFileForProof();
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              240,
                              239,
                              239,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: proofFile != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/ic_pdf.png',
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        proofFile!.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Upload',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Upload identity proof'),
                    GestureDetector(
                      onTap: () {
                        selectFileForId();
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              240,
                              239,
                              239,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: idFile != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/ic_pdf.png',
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        idFile!.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Upload',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Cases won'),
                    customTextField(
                        controller: casesWonController,
                        hinttext: 'Cases won',
                        keyboardType: TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Experience (in years)'),
                    customTextField(
                        controller: experienceController,
                        hinttext: '10+',
                        keyboardType: TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Add description about yourself'),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            240,
                            239,
                            239,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: descriptionController,
                        maxLength: 1000,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            suffixText: '*',
                            suffixStyle: const TextStyle(
                                color: Colors.red, letterSpacing: 10),
                            hintText: 'Describe yourself within 1000 letters',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (emailController.text.isNotEmpty &&
                              firstNameController.text.isNotEmpty &&
                              lastNameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty &&
                              dobController.text.isNotEmpty &&
                              statecontroller.text.isNotEmpty &&
                              cityController.text.isNotEmpty &&
                              address1Controller.text.isNotEmpty &&
                              address2Controller.text.isNotEmpty &&
                              casesWonController.text.isNotEmpty &&
                              experienceController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty &&
                              profileImage != null &&
                              idFile != null &&
                              proofFile != null) {
                            ref
                                .read(authControllerProvider.notifier)
                                .applyForLawyer(
                                    userModel: currentUser!,
                                    context: context,
                                    phone: phoneController.text,
                                    dob: dobController.text,
                                    countryState: statecontroller.text,
                                    city: cityController.text,
                                    address1: address1Controller.text,
                                    address2: address2Controller.text,
                                    proofDoc: proofFile!,
                                    idDoc: idFile!,
                                    casesWon: casesWonController.text,
                                    experience: experienceController.text,
                                    description: descriptionController.text,
                                    approved: 'false',
                                    profImage: profileImage!);
                          } else {
                            ShowSnackbar(context, 'Please fill all the fields');
                          }
                        },
                        child: const CustomButton(
                            text: 'Submit for verification')),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget customTextField(
      {required TextEditingController controller,
      required String hinttext,
      required TextInputType keyboardType,
      bool obsecureText = false}) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(
            255,
            240,
            239,
            239,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        obscureText: obsecureText,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            suffixText: '*',
            suffixStyle: const TextStyle(color: Colors.red, letterSpacing: 10),
            hintText: hinttext,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  Widget customButton({required String text}) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(16, 32, 55, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      )),
    );
  }
}
