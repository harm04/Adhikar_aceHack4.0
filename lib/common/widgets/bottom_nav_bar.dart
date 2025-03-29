
import 'package:adhikar_acehack4_o/features/home/views/home_view.dart';
import 'package:adhikar_acehack4_o/marketplace/views/marketplace_view.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  late PageController pageController;

  List<Widget> pageList = [
    const HomeView(),
    const MarketPlaceScreen(),
    const Center(child: Text(" jobs")),
    const Center(child: Text("Notifications")),
    const Center(child: Text("news")),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: pageList,
        ),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Colors.white,
          backgroundColor: Pallete.backgroundColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Home',
              icon: ImageIcon(
                const AssetImage('assets/icons/ic_home.png'),
                size: 30,
                color: (_page == 0) ? Pallete.whiteColor : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Marketplace',
              icon: ImageIcon(
                const AssetImage('assets/icons/ic_marketplace.png'),
                size: 20,
                color: (_page == 1) ? Pallete.whiteColor : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Jobs',
              icon: ImageIcon(
                const AssetImage('assets/icons/ic_job.png'),
                size: 25,
                color: (_page == 2) ? Pallete.whiteColor : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Notifications',
              icon: ImageIcon(
                const AssetImage('assets/icons/ic_notification.png'),
                size: 25,
                color: (_page == 3) ? Pallete.whiteColor : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'News',
              icon: ImageIcon(
                const AssetImage('assets/icons/ic_news.png'),
                size: 20,
                color: (_page == 4) ? Pallete.whiteColor : Colors.grey,
              ),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        )

        // bottomNavigationBar: CupertinoTabBar(
        //     activeColor: Colors.white,
        //     backgroundColor: Colors.black,
        //     items: <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //         icon: ImageIcon(
        //           const AssetImage('assets/icons/ic_home.png'),
        //           size: 30,
        //           color: (_page == 0) ? Colors.white : Colors.grey,
        //         ),
        //         backgroundColor: Colors.white,
        //       ),
        //       BottomNavigationBarItem(
        //           icon: ImageIcon(
        //             const AssetImage('assets/icons/ic_ai.png'),
        //             size: 25,
        //             color: (_page == 1) ? Colors.white : Colors.grey,
        //           ),
        //           backgroundColor: Colors.white,
        //         ),
        //            BottomNavigationBarItem(
        //         icon: ImageIcon(
        //           const AssetImage('assets/icons/ic_marketplace.png'),
        //           size: 20,
        //           color: (_page == 2) ? Colors.white : Colors.grey,
        //         ),
        //         backgroundColor: Colors.white,
        //       ),
        //       BottomNavigationBarItem(
        //           icon: ImageIcon(
        //             const AssetImage('assets/icons/ic_job.png'),
        //             size: 25,
        //             color: (_page == 3) ? Colors.white : Colors.grey,
        //           ),
        //           backgroundColor: Colors.white,
        //         ),
        //          BottomNavigationBarItem(
        //           icon: ImageIcon(
        //             const AssetImage('assets/icons/ic_news.png'),
        //             size: 20,
        //             color: (_page == 4) ? Colors.white : Colors.grey,
        //           ),
        //           backgroundColor: Colors.white,
        //         ),
        //     ],
        //      onTap: navigationTapped,
        //       currentIndex: _page,
        //     ),
        );
  }
}
