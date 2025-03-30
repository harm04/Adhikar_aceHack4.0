
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/home/views/apply_for_lawyer.dart';
import 'package:adhikar_acehack4_o/features/home/views/create_post_view.dart';
import 'package:adhikar_acehack4_o/features/home/views/my_meetings.dart';
import 'package:adhikar_acehack4_o/features/home/views/pods_list_view.dart';
import 'package:adhikar_acehack4_o/features/home/views/post_list.dart';
import 'package:adhikar_acehack4_o/features/home/views/search_view.dart';
import 'package:adhikar_acehack4_o/features/nyaysahayak/chat_screen.dart';
import 'package:adhikar_acehack4_o/features/nyaysahayak/nyaysahayak_home.dart';
import 'package:adhikar_acehack4_o/features/profile/views/profile_view.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void logout() {
    ref.read(authControllerProvider.notifier).signout(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final currentuser = ref.watch(currentUserDataProvider).value;
    return currentuser == null && isLoading
        ? LoadingPage()
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              key: _scaffoldKey,
              //drawer
              drawer: Drawer(
                backgroundColor: Pallete.whiteColor,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProfileView(
                                  userModel: currentuser,
                                );
                              })),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: currentuser!
                                                .profileImage ==
                                            ''
                                        ? NetworkImage(
                                            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                                        : NetworkImage(
                                            currentuser.profileImage),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            currentuser.firstName +
                                                ' ' +
                                                currentuser.lastName,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5),
                                        Text(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            currentuser.bio == ''
                                                ? 'Adhikar user'
                                                : currentuser.bio,
                                            style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Pallete.primaryColor,
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ApplyForLawyerScreen();
                                }));
                              },
                              title: Text('Apply for Adhikar Lawyer',
                                  style: TextStyle(fontSize: 18)),
                              leading: Image.asset(
                                'assets/icons/ic_gavel.png',
                                height: 30,
                                color: Pallete.primaryColor,
                              ),
                            ),
                            ListTile(
                              title: Text('Bookmarked',
                                  style: TextStyle(fontSize: 18)),
                              leading: Image.asset(
                                'assets/icons/ic_bookmark_filled.png',
                                height: 28,
                                color: Pallete.primaryColor,
                              ),
                            ),
                            ListTile(
                              title: Text('Settings',
                                  style: TextStyle(fontSize: 18)),
                              leading: Image.asset(
                                'assets/icons/ic_settings.png',
                                height: 28,
                                color: Pallete.primaryColor,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PodsListView();
                                }));
                              },
                              title:
                                  Text('Pods', style: TextStyle(fontSize: 18)),
                              leading: Image.asset(
                                'assets/icons/ic_pods.png',
                                height: 30,
                                color: Pallete.primaryColor,
                              ),
                            ),
                            currentuser.userType == 'User'
                                ? ListTile(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return MyMeetingsView();
                                      }));
                                    },
                                    title: Text('Meetings',
                                        style: TextStyle(fontSize: 18)),
                                    leading: Image.asset(
                                      'assets/icons/ic_marketplace.png',
                                      height: 30,
                                      color: Pallete.primaryColor,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              logout();
                            },
                            child: ListTile(
                              title: Text('Logout',
                                  style: TextStyle(fontSize: 18)),
                              leading: Image.asset(
                                'assets/icons/ic_logout.png',
                                height: 30,
                                color: Pallete.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //floatingActionButton
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreatePostView();
                  }));
                },
                child: Image.asset('assets/icons/ic_post.png',
                    height: 30, color: Pallete.whiteColor),
              ),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: currentuser.profileImage == ''
                            ? NetworkImage(
                                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                            : NetworkImage(currentuser.profileImage),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        //navigate to search screen
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchView();
                        }));
                      },
                      child: Image.asset(
                        'assets/icons/search.png',
                        height: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                     // navigate to ai screen
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NyaysahayakHomePage();
                      }));
                    },
                    child: Image.asset(
                      'assets/icons/ic_ai.png',
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'assets/icons/ic_message.png',
                    height: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                ],
                bottom: TabBar(
                  labelColor: Pallete.whiteColor,
                  dividerColor: Pallete.primaryColor,
                  unselectedLabelColor: Pallete.greyColor,
                  tabs: [
                    Tab(
                        child:
                            Text('Community', style: TextStyle(fontSize: 17))),
                    Tab(
                        child:
                            Text('Past Cases', style: TextStyle(fontSize: 17))),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  PostList(),
                  // ListView.builder(
                  //     shrinkWrap: false,
                  //     itemCount: 20,
                  //     itemBuilder: (context, index) {
                  //       return PostCard();
                  //     }),
                  Center(child: Text('Past Cases')),
                ],
              ),
            ),
          );
  }
}
