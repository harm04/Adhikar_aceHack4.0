
import 'dart:io';

import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/constants/appwrite_contants.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/profile/widget/edit.dart';
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileView extends ConsumerStatefulWidget {
  final UserModel userModel;
  const EditProfileView({super.key, required this.userModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  File? profileImage;

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    summaryController.dispose();
    instagramController.dispose();
    facebookController.dispose();
    twitterController.dispose();
    linkedinController.dispose();
    locationController.dispose();
  }

  //pick profile image
  // void pickProfileImage() async {
  //   final profImage = await pickImage();
  //   if (profImage != null) {
  //     setState(() {
  //       profileImage = profImage;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.userModel.firstName;
    lastNameController.text = widget.userModel.lastName;
    bioController.text =
        widget.userModel.bio == '' ? 'Adhikar user' : widget.userModel.bio;
    summaryController.text = widget.userModel.summary == ''
        ? 'Adhikar user'
        : widget.userModel.summary;
    instagramController.text = widget.userModel.instagram;
    facebookController.text = widget.userModel.facebook;
    twitterController.text = widget.userModel.twitter;
    linkedinController.text = widget.userModel.linkedin;
    locationController.text = widget.userModel.location == ''
        ? locationController.text
        : widget.userModel.location;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    UserModel copyOfUserModel = widget.userModel;

    return isLoading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              actions: [
                Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        if (firstNameController.text.isNotEmpty &&
                            lastNameController.text.isNotEmpty) {
                        
                          ref.read(authControllerProvider.notifier).updateUser(
                              userModel: copyOfUserModel,
                              context: context,
                              profileImage: profileImage,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              bio: bioController.text,
                              location: locationController.text,
                              linkedin: linkedinController.text,
                              twitter: twitterController.text,
                              instagram: instagramController.text,
                              facebook: facebookController.text,
                              summary: summaryController.text);
                        }
                      },
                      child: Image.asset(
                        'assets/icons/ic_correct.png',
                        height: 25,
                        color: Colors.green,
                      ),
                    )),
              ],
            ),
            body: ref.watch(getlatestUserDataProvider).when(
                data: (user) {
                  if (user.events.contains(
                      'databases.*.collections.${AppwriteConstants.usersCollectionId}.documents.${copyOfUserModel.uid}.update')) {
                    copyOfUserModel = UserModel.fromMap(user.payload);
                  }
                  return EditWidget(
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                      bioController: bioController,
                      summaryController: summaryController,
                      locationController: locationController,
                      instagramController: instagramController,
                      facebookController: facebookController,
                      linkedinController: linkedinController,
                      twitterController: twitterController,
                      copyOfUserModel: copyOfUserModel);
                },
                error: (error, st) => ErrorText(error: error.toString()),
                loading: () => EditWidget(
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    bioController: bioController,
                    summaryController: summaryController,
                    locationController: locationController,
                    instagramController: instagramController,
                    facebookController: facebookController,
                    linkedinController: linkedinController,
                    twitterController: twitterController,
                    copyOfUserModel: copyOfUserModel)));
  }
}
