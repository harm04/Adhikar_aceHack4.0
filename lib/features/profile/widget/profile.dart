
import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/home/controller/post_controller.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/post_card.dart';
import 'package:adhikar_acehack4_o/features/profile/views/add_education.dart';
import 'package:adhikar_acehack4_o/features/profile/views/add_experience.dart';
import 'package:adhikar_acehack4_o/features/profile/views/edit_profile_view.dart';
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileWidget extends ConsumerStatefulWidget {
  final UserModel userModel;
  const ProfileWidget({super.key, required this.userModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends ConsumerState<ProfileWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String getPod(String text) {
    Map<String, String> podImageMap = {
      'General': 'assets/icons/ic_general.png',
      'Freelance & Legal Services': 'assets/icons/ic_freelance_services.png',
      'Criminal & Civil Law': 'assets/icons/ic_criminal_law.png',
      'Corporate & Business Law': 'assets/icons/ic_businees_law.png',
      'Moot Court & Bar Exam Prep': 'assets/icons/ic_exam_prep.png',
      'Internships & Job Opportunities':
          'assets/icons/ic_internship_and_job.png',
      'Legal Tech & AI': 'assets/icons/ic_legal_tech_and_ai.png',
      'Case Discussions': 'assets/icons/ic_case_discussion.png',
      'Legal News & Updates': 'assets/icons/ic_legal_news_and_updates.png',
    };

    for (var keyword in podImageMap.keys) {
      if (text.contains(keyword)) {
        return podImageMap[keyword]!;
      }
    }

    return 'assets/icons/ic_general.png';
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDataProvider);
    bool isLoading = ref.watch(authControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Pallete.primaryColor,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage: widget.userModel.profileImage == ''
                            ? NetworkImage(
                                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                            : NetworkImage(widget.userModel.profileImage),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.userModel.firstName +
                                  ' ' +
                                  widget.userModel.lastName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              widget.userModel.bio == ''
                                  ? 'Adhikar user'
                                  : widget.userModel.bio,
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.userModel.uid == currentUser.value!.uid
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileView(
                                      userModel: widget.userModel,
                                    )));
                      },
                      child: Image.asset(
                        'assets/icons/ic_post.png',
                        height: 25,
                        color: Pallete.primaryColor,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/ic_location.png',
                height: 25,
                color: Pallete.greyColor,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                    widget.userModel.location == ''
                        ? 'India, India'
                        : widget.userModel.location,
                    style: TextStyle(
                      color: Pallete.greyColor,
                    )),
              ),
              SizedBox(width: 20),
              Image.asset(
                'assets/icons/ic_calender.png',
                height: 25,
                color: Pallete.greyColor,
              ),
              SizedBox(width: 5),
              Text('Joined on ${widget.userModel.createdAt}',
                  style: TextStyle(
                    color: Pallete.greyColor,
                  )),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              Image.asset(
                widget.userModel.linkedin == ''
                    ? 'assets/icons/ic_linkedin_grey.png'
                    : 'assets/icons/ic_linkedin.png',
                height: 40,
              ),
              SizedBox(width: 9),
              Image.asset(
                widget.userModel.instagram == ''
                    ? 'assets/icons/ic_instagram_grey.png'
                    : 'assets/icons/ic_instagram.png',
                height: 40,
              ),
              SizedBox(width: 9),
              Image.asset(
                widget.userModel.twitter == ''
                    ? 'assets/icons/ic_x_grey.png'
                    : 'assets/icons/ic_x.png',
                height: 40,
              ),
              SizedBox(width: 9),
              Image.asset(
                widget.userModel.facebook == ''
                    ? 'assets/icons/ic_facebook_grey.png'
                    : 'assets/icons/ic_facebook.png',
                height: 40,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.userModel.uid != currentUser.value!.uid
                        ? ref.read(authControllerProvider.notifier).followUser(
                            userModel: widget.userModel,
                            currentUser: currentUser.value!,
                            context: context)
                        : SizedBox();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Pallete.primaryColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        child: isLoading
                            ? Loader()
                            : Text(
                                widget.userModel.uid == currentUser.value!.uid
                                    ? '${widget.userModel.followers.length} Followers'
                                    : currentUser.value!.following
                                            .contains(widget.userModel.uid)
                                        ? 'Unfollow'
                                        : 'Follow',
                                style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Pallete.primaryColor),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/ic_message.png',
                            height: 25,
                            color: Pallete.primaryColor,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Messages',
                            style: TextStyle(
                              color: Pallete.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TabBar(
          controller: _tabController,
          labelColor: Pallete.primaryColor,
          unselectedLabelColor: Pallete.greyColor,
          tabs: [
            Tab(child: Text('About', style: TextStyle(fontSize: 17))),
            Tab(child: Text('Posts', style: TextStyle(fontSize: 17))),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text('Summary',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      widget.userModel.summary == ''
                          ? 'Adhikar user'
                          : widget.userModel.summary,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Experience',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        widget.userModel.uid == currentUser.value!.uid
                            ? GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddExperience())),
                                child: widget.userModel.experienceTitle == ''
                                    ? Image.asset(
                                        'assets/icons/ic_add.png',
                                        height: 25,
                                        color: Pallete.primaryColor,
                                      )
                                    : Image.asset(
                                        'assets/icons/ic_post.png',
                                        height: 25,
                                        color: Pallete.primaryColor,
                                      ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Education',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        widget.userModel.uid == currentUser.value!.uid
                            ? GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddEducation())),
                                child: widget.userModel.eduDegree == ''
                                    ? Image.asset(
                                        'assets/icons/ic_add.png',
                                        height: 25,
                                        color: Pallete.primaryColor,
                                      )
                                    : Image.asset(
                                        'assets/icons/ic_post.png',
                                        height: 25,
                                        color: Pallete.primaryColor,
                                      ),
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
              ref.watch(getUsersPostProvider(widget.userModel)).when(
                    data: (posts) {
                      return posts.isEmpty
                          ? Center(child: Text("No posts available"))
                          : ListView.builder(
                              itemCount: posts.length,
                              // shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final post = posts[index];
                                String podImage = getPod(post.pod);
                                return PostCard(
                                  post: post,
                                  podImage: podImage,
                                );
                              },
                            );
                    },
                    error: (error, st) => ErrorText(error: error.toString()),
                    loading: () => LoadingPage(),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
