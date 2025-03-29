
import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/constants/appwrite_contants.dart';
import 'package:adhikar_acehack4_o/enums/post_type_enum.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/home/controller/post_controller.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/carousel.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/hashtags.dart';
import 'package:adhikar_acehack4_o/models/post_model.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

class CommentView extends ConsumerStatefulWidget {
  final PostModel post;
  final String podImage;
  const CommentView({super.key, required this.post, required this.podImage});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentViewState();
}

class _CommentViewState extends ConsumerState<CommentView> {
  bool isAnonymous = false;
  TextEditingController commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDataProvider).value;
    return ref.watch(userDataProvider(widget.post.uid)).when(
        data: (user) {
          return Scaffold(
            resizeToAvoidBottomInset: true,

            appBar: AppBar(
              title: Text('Post on Adhikar'),
            ),
            //bottom nav bar
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Pallete.greyColor, width: 0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isAnonymous = !isAnonymous;
                          });
                        },
                        child: CircleAvatar(
                          radius: 20,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: !isAnonymous
                                    ? NetworkImage(
                                        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                                    : AssetImage(
                                        'assets/icons/ic_anonymous.png',
                                      ),
                              ),
                              Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(70)),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/ic_replace.png',
                                      height: 35,
                                      color: Pallete.whiteColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'Enter your reply here...',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            autofocus: true, // Auto-focus when tapping
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0, top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete.greyColor,
                          ),
                          onPressed: () {
                            ref.read(postControllerProvider.notifier).sharePost(
                                text: commentController.text,
                                isAnonymous: isAnonymous,
                                pod: 'comment',
                                images: [],
                                context: context,
                                commentedTo: widget.post.id);
                            print(widget.post.id);
                          },
                          child: Text('Post',
                              style: TextStyle(color: Pallete.whiteColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //profile image

                            CircleAvatar(
                              radius: 25,
                              backgroundImage: widget.post.isAnonymous
                                  ? AssetImage('assets/icons/ic_anonymous.png')
                                  : (user.profileImage == ''
                                      ? NetworkImage(
                                          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                                      : NetworkImage(user.profileImage)),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      //username
                                      Text(
                                        '${user.firstName} ${user.lastName}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      //time
                                      Text(
                                        ' . ${timeago.format(
                                          widget.post.createdAt,
                                          locale: 'en_short',
                                        )}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Pallete.greyColor),
                                      ),
                                    ],
                                  ),
                                  //bio
                                  Text(
                                    user.bio == ''
                                        ? 'Adhikar user'
                                        : '${user.bio}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14, color: Pallete.greyColor),
                                  ),
                                ],
                              ),
                            ),
                            //pod
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage(widget.podImage),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //hashtags
                              HashTags(text: widget.post.text),
                              SizedBox(
                                height: 5,
                              ),
                              //images
                              if (widget.post.type == PostType.image)
                                CarouselImage(imageLinks: widget.post.images),
                              if (widget.post.link.isNotEmpty) ...[
                                SizedBox(
                                  height: 4,
                                ),

                                //link preview
                                AnyLinkPreview(
                                  link: widget.post.link
                                      .toString()
                                      .replaceAll(RegExp(r'[\[\]]'), ''),
                                  displayDirection:
                                      UIDirection.uiDirectionHorizontal,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                              ],
                            ],
                          ),
                        ),
                        //like,comment,share,more
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/icons/ic_bookmark_outline.png',
                              height: 26,
                              color: Pallete.greyColor,
                            ),
                            Row(
                              children: [
                                LikeButton(
                                  size: 26,
                                  isLiked: widget.post.likes
                                      .contains(currentUser!.uid),
                                  onTap: (isLiked) async {
                                    ref
                                        .read(postControllerProvider.notifier)
                                        .likePost(widget.post, currentUser);
                                    return !isLiked;
                                  },
                                  likeBuilder: (isLiked) {
                                    return isLiked
                                        ? Image.asset(
                                            'assets/icons/ic_like_filled.png',
                                            color: Pallete.redColor,
                                          )
                                        : Image.asset(
                                            'assets/icons/ic_like_outline.png',
                                            color: Pallete.greyColor,
                                          );
                                  },
                                  likeCount: widget.post.likes.length,
                                  countBuilder: (likeCount, isLiked, text) =>
                                      Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text(
                                      text,
                                      style: TextStyle(
                                          color: isLiked
                                              ? Pallete.redColor
                                              : Pallete.greyColor,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/ic_insights.png',
                                  height: 26,
                                  color: Pallete.greyColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (widget.post.likes.length +
                                          widget.post.commentIds.length)
                                      .toString(),
                                  style:
                                      TextStyle(color: Pallete.backgroundColor),
                                )
                              ],
                            ),
                            Image.asset(
                              'assets/icons/ic_more.png',
                              height: 26,
                              color: Pallete.greyColor,
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 25,
                        ),
                        Text('Comments',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 15,
                        ),
                        ref.watch(getCommentsProvider(widget.post)).when(
                            data: (posts) {
                              return ref.watch(getLatestPostProvider).when(
                                  data: (data) {
                                    final latestComments =
                                        PostModel.fromMap(data.payload);
                                    bool isPostAlreadyPresent = false;
                                    for (final postsmodel in posts) {
                                      if (postsmodel.id == latestComments.id) {
                                        isPostAlreadyPresent = true;
                                        break;
                                      }
                                    }
                                    if (!isPostAlreadyPresent &&
                                        latestComments.commentedTo ==
                                            widget.post.id) {
                                      if (data.events.contains(
                                          'databases.*.collections.${AppwriteConstants.postCollectionId}.documents.*.create')) {
                                        posts.insert(
                                            0, PostModel.fromMap(data.payload));
                                      }
                                    }
                                    //else write code to update the post
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: posts.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final post = posts[index];

                                          return ref
                                              .watch(userDataProvider(post.uid))
                                              .when(
                                                  data: (user) {
                                                    return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              //profile image
                                                              CircleAvatar(
                                                                radius: 25,
                                                                backgroundImage: post
                                                                        .isAnonymous
                                                                    ? AssetImage(
                                                                        'assets/icons/ic_anonymous.png')
                                                                    : user.profileImage ==
                                                                            ''
                                                                        ? NetworkImage(
                                                                            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                                                                        : NetworkImage(
                                                                            user.profileImage),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        //username
                                                                        Text(
                                                                          '${user.firstName} ${user.lastName}',
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        //time
                                                                        Text(
                                                                          ' . ${timeago.format(
                                                                            post.createdAt,
                                                                            locale:
                                                                                'en_short',
                                                                          )}',
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Pallete.greyColor),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    //bio
                                                                    Text(
                                                                      user.bio ==
                                                                              ''
                                                                          ? 'Adhikar user'
                                                                          : '${user.bio}',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Pallete.greyColor),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              //hashtags
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  HashTags(
                                                                      text: post
                                                                          .text),
                                                                  LikeButton(
                                                                    size: 26,
                                                                    isLiked: post
                                                                        .likes
                                                                        .contains(
                                                                            currentUser.uid),
                                                                    onTap:
                                                                        (isLiked) async {
                                                                      ref.read(postControllerProvider.notifier).likePost(
                                                                          post,
                                                                          currentUser);
                                                                      return !isLiked;
                                                                    },
                                                                    likeBuilder:
                                                                        (isLiked) {
                                                                      return isLiked
                                                                          ? Image
                                                                              .asset(
                                                                              'assets/icons/ic_like_filled.png',
                                                                              color: Pallete.redColor,
                                                                            )
                                                                          : Image
                                                                              .asset(
                                                                              'assets/icons/ic_like_outline.png',
                                                                              color: Pallete.greyColor,
                                                                            );
                                                                    },
                                                                    likeCount: post
                                                                        .likes
                                                                        .length,
                                                                    countBuilder: (likeCount,
                                                                            isLiked,
                                                                            text) =>
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              3.0),
                                                                      child:
                                                                          Text(
                                                                        text,
                                                                        style: TextStyle(
                                                                            color: isLiked
                                                                                ? Pallete.redColor
                                                                                : Pallete.greyColor,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                            ],
                                                          ),
                                                          //like,

                                                          Divider()
                                                        ]);
                                                  },
                                                  error: (error, StackTrace) =>
                                                      ErrorText(
                                                          error:
                                                              error.toString()),
                                                  loading: () => SizedBox());
                                        });
                                  },
                                  error: (error, StackTrace) =>
                                      ErrorText(error: error.toString()),
                                  loading: () => ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: posts.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final post = posts[index];

                                        return ref
                                            .watch(userDataProvider(post.uid))
                                            .when(
                                                data: (user) {
                                                  return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            //profile image
                                                            CircleAvatar(
                                                              radius: 25,
                                                              backgroundImage: post
                                                                      .isAnonymous
                                                                  ? AssetImage(
                                                                      'assets/icons/ic_anonymous.png')
                                                                  : user.profileImage ==
                                                                          ''
                                                                      ? NetworkImage(
                                                                          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                                                                      : NetworkImage(
                                                                          user.profileImage),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      //username
                                                                      Text(
                                                                        '${user.firstName} ${user.lastName}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      //time
                                                                      Text(
                                                                        ' . ${timeago.format(
                                                                          post.createdAt,
                                                                          locale:
                                                                              'en_short',
                                                                        )}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Pallete.greyColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  //bio
                                                                  Text(
                                                                    user.bio ==
                                                                            ''
                                                                        ? 'Adhikar user'
                                                                        : '${user.bio}',
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Pallete
                                                                            .greyColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            //hashtags
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                HashTags(
                                                                    text: post
                                                                        .text),
                                                                LikeButton(
                                                                  size: 26,
                                                                  onTap:
                                                                      (isLiked) async {
                                                                    ref
                                                                        .read(postControllerProvider
                                                                            .notifier)
                                                                        .likePost(
                                                                            post,
                                                                            currentUser);
                                                                    return !isLiked;
                                                                  },
                                                                  isLiked: post
                                                                      .likes
                                                                      .contains(
                                                                          user.uid),
                                                                  likeBuilder:
                                                                      (isLiked) {
                                                                    return isLiked
                                                                        ? Image
                                                                            .asset(
                                                                            'assets/icons/ic_like_filled.png',
                                                                            color:
                                                                                Pallete.redColor,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            'assets/icons/ic_like_outline.png',
                                                                            color:
                                                                                Pallete.greyColor,
                                                                          );
                                                                  },
                                                                  likeCount: post
                                                                      .likes
                                                                      .length,
                                                                  countBuilder: (likeCount,
                                                                          isLiked,
                                                                          text) =>
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            3.0),
                                                                    child: Text(
                                                                      text,
                                                                      style: TextStyle(
                                                                          color: isLiked
                                                                              ? Pallete.redColor
                                                                              : Pallete.greyColor,
                                                                          fontSize: 16),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                          ],
                                                        ),
                                                        //like,

                                                        Divider()
                                                      ]);
                                                },
                                                error: (error, StackTrace) =>
                                                    ErrorText(
                                                        error:
                                                            error.toString()),
                                                loading: () => SizedBox());
                                      }));
                            },
                            error: (error, StackTrace) =>
                                ErrorText(error: error.toString()),
                            loading: () => Loader()),
                      ]),
                ),
              ),
            ),
          );
        },
        error: (error, StackTrace) => ErrorText(error: error.toString()),
        loading: () => SizedBox());
  }
}
