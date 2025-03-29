
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final UserModel user;
  const SearchCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return ProfileView(userModel: user);
        // }));
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: user.profileImage == ''
              ? NetworkImage(
                  'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
              : NetworkImage(user.profileImage),
        ),
        title: Text(
          user.firstName + ' ' + user.lastName,
          style: TextStyle(color: Pallete.backgroundColor),
        ),
        subtitle: Text(
          user.email,
          style: TextStyle(color: Pallete.greyColor),
        ),
      ),
    );
  }
}
