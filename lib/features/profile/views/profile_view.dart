
import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/constants/appwrite_contants.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/profile/widget/profile.dart';
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  final UserModel userModel;
  const ProfileView({super.key, required this.userModel});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    UserModel copyOfUserModel = widget.userModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile on Adhikar'),
        centerTitle: true,
      ),
      body: ref.watch(getlatestUserDataProvider).when(
          data: (user) {
            if (user.events.contains(
                'databases.*.collections.${AppwriteConstants.usersCollectionId}.documents.${copyOfUserModel.uid}.update')) {
              copyOfUserModel = UserModel.fromMap(user.payload);
            }
            return ProfileWidget(userModel: copyOfUserModel);
          },
          error: (error, st) => ErrorText(error: error.toString()),
          loading: () => ProfileWidget(userModel: copyOfUserModel)),
      //
    );
  }
}
