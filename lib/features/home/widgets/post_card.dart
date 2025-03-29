import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/enums/post_type_enum.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/home/controller/post_controller.dart';
import 'package:adhikar_acehack4_o/features/home/views/comment_view.dart';
import 'package:adhikar_acehack4_o/features/home/views/pods_list_view.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/carousel.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/hashtags.dart';
import 'package:adhikar_acehack4_o/models/post_model.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends ConsumerStatefulWidget {
  final PostModel post;
  final String podImage;

  const PostCard({super.key, required this.post, required this.podImage});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDataProvider).value;
    if (widget.post.commentedTo == '') {
      return ref.watch(userDataProvider(widget.post.uid)).when(
          data: (user) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //profile image
                        GestureDetector(
                          onTap: () {
                            //navigate to profile screen
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: widget.post.isAnonymous
                                ? AssetImage('assets/icons/ic_anonymous.png')
                                : user.profileImage == ''
                                    ? NetworkImage(
                                        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                                    : NetworkImage(user.profileImage),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              //navigate to profile screen
                            },
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
                        ),
                        //pod
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return PodsListView();
                              }),
                            );
                          },
                          child: CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(widget.podImage),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 7),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CommentView(
                                  post: widget.post, podImage: widget.podImage);
                            }),
                          );
                        },
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
                              isLiked:
                                  widget.post.likes.contains(currentUser!.uid),
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
                              'assets/icons/ic_comment.png',
                              height: 26,
                              color: Pallete.greyColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.post.commentIds.length.toString(),
                                style:
                                    TextStyle(color: Pallete.backgroundColor))
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
                              style: TextStyle(color: Pallete.backgroundColor),
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
                    Divider()
                  ]),
            );
          },
          error: (error, StackTrace) => ErrorText(error: error.toString()),
          loading: () => SizedBox());
    }
    return SizedBox();
  }
}
