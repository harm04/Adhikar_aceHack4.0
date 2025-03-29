import 'dart:io';

import 'package:adhikar_acehack4_o/common/widgets/image_picker.dart';
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class EditWidget extends ConsumerStatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController bioController;
  final TextEditingController summaryController;
  final TextEditingController locationController;
  final TextEditingController instagramController;
  final TextEditingController facebookController;
  final TextEditingController linkedinController;
  final TextEditingController twitterController;
  final UserModel copyOfUserModel ;

  const EditWidget(
      {super.key,
      required this.firstNameController,
      required this.lastNameController,
      required this.bioController,
      required this.summaryController,
      required this.locationController,
      required this.instagramController,
      required this.facebookController,
      required this.linkedinController,
      required this.twitterController,required this.copyOfUserModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends ConsumerState<EditWidget> {
  File? profileImage;
//pick profile image
  void pickProfileImage() async {
    final profImage = await pickImage();
    if (profImage != null) {
      setState(() {
        profileImage = profImage;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Enable location services to proceed.")));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Location permissions are denied.")));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Location permissions are permanently denied.")));
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      setState(() {
        widget.locationController.text =
            "${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error fetching location")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: Pallete.primaryColor,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : widget.copyOfUserModel.profileImage == ''
                              ? NetworkImage(
                                  'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                              : NetworkImage(widget.copyOfUserModel.profileImage),
                    ),
                  ),
                  Positioned(
                      bottom: 5,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          pickProfileImage();
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Pallete.primaryColor,
                          child: CircleAvatar(
                            radius: 15,
                            child: Image.asset(
                              'assets/icons/ic_post.png',
                              height: 20,
                              color: Pallete.primaryColor,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Basic Info',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            //firstname
            customTextfieldForBasicInfo(widget.firstNameController, null, 'First Name',
                'Enter your first name', TextInputType.text),

            SizedBox(
              height: 25,
            ),
            //lastname
            customTextfieldForBasicInfo(widget.lastNameController, null, 'Last Name',
                'Enter your last name', TextInputType.text),
            SizedBox(
              height: 25,
            ),
            //bio
            customTextfieldForBasicInfo(widget.bioController, null, 'Bio',
                'Enter your bio', TextInputType.text),
            SizedBox(
              height: 25,
            ),
            //summary
            customTextfieldForBasicInfo(widget.summaryController, 250, 'Summary',
                'Enter your summary', TextInputType.text),
            SizedBox(
              height: 25,
            ),
            //location
            TextField(
              controller: widget.locationController,
              // Prevent manual input
              onTap: () async {
                await _getCurrentLocation();
                setState(() {}); // Fetch location and update text field
              },
              decoration: InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.location_on, color: Colors.red),
              ),
            ),

            SizedBox(
              height: 25,
            ),
            //social links

            Text('Social Info',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            //instagram
            customTextfieldForSocialLinks(
                widget.instagramController,
                null,
                'Instagram',
                'Enter your Instagram profile link',
                TextInputType.text,
                'assets/icons/ic_instagram.png'),
            SizedBox(
              height: 25,
            ),
            //facebook
            customTextfieldForSocialLinks(
                widget.facebookController,
                null,
                'Facebook',
                'Enter your Facebook profile link',
                TextInputType.text,
                'assets/icons/ic_facebook.png'),
            SizedBox(
              height: 25,
            ),
            //linkedin
            customTextfieldForSocialLinks(
                widget.linkedinController,
                null,
                'Linkedin',
                'Enter your Linkedin profile link',
                TextInputType.text,
                'assets/icons/ic_linkedin.png'),
            SizedBox(
              height: 25,
            ),
            //twitter
            customTextfieldForSocialLinks(
                widget.twitterController,
                null,
                'X',
                'Enter your X profile link',
                TextInputType.text,
                'assets/icons/ic_x.png'),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
    
  }

  Widget customTextfieldForBasicInfo(
      TextEditingController controller,
      maxLength,
      String labelText,
      String hintText,
      TextInputType keyboardType) {
    return TextField(
      cursorColor: Pallete.primaryColor,
      controller: controller,
      maxLength: maxLength,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Pallete.greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Pallete.primaryColor),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  Widget customTextfieldForSocialLinks(
      TextEditingController controller,
      maxLength,
      String labelText,
      String hintText,
      TextInputType keyboardType,
      String image) {
    return TextField(
      cursorColor: Pallete.primaryColor,
      controller: controller,
      maxLength: maxLength,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              image,
              height: 15,
            ),
          ),
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Pallete.greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Pallete.primaryColor),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
