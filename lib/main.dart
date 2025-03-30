
import 'package:adhikar_acehack4_o/common/widgets/bottom_nav_bar.dart';
import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/auth/views/login.dart';
import 'package:adhikar_acehack4_o/features/home/views/lawyer_verification_screen.dart';
import 'package:adhikar_acehack4_o/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
} 
  
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adhikar3.o',
      theme: AppTheme.theme,
      home:ref.watch(currentUserAccountProvider).when(data: (user) {
  if (user != null) {
    final currentUserAsyncValue = ref.watch(currentUserDataProvider);
    return currentUserAsyncValue.when(
      data: (currentUser) {
        if (currentUser != null) {
          print('current user ${currentUser}');
          return currentUser.userType == 'User' || currentUser.userType == 'Lawyer'
              ? BottomNavBar()
              : LawyerVerificationScreem();
        } else {
          return LoginScreen();
        }
      },
      loading: () => Loader(),
      error: (err, st) => ErrorText(error: err.toString()),
    );
  } else {
    return LoginScreen();
  }
}, error: (err, st) {
  return ErrorText(error: err.toString());
}, loading: () {
  return Loader();
}),
    );
  }
}
