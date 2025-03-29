import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LawyerVerificationScreem extends StatefulWidget {
  const LawyerVerificationScreem({super.key});

  @override
  State<LawyerVerificationScreem> createState() =>
      _LawyerVerificationScreemState();
}

class _LawyerVerificationScreemState extends State<LawyerVerificationScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification pending '),
        backgroundColor: Pallete.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Pallete.primaryColor,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/ic_verification.png'),
            SizedBox(
              height: 20,
            ),
            Text(
                'Your request for verification has been sent. Please wait while our team verifies your documents. It usually takes 24 hrs')
          ],
        ),
      )),
    );
  }
}
