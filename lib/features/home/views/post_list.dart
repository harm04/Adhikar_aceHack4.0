
import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/constants/appwrite_contants.dart';
import 'package:adhikar_acehack4_o/features/home/controller/post_controller.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/post_card.dart';
import 'package:adhikar_acehack4_o/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostList extends ConsumerStatefulWidget {
  const PostList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostListState();
}

class _PostListState extends ConsumerState<PostList> {
  @override
  Widget build(BuildContext context) {
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

    return ref.watch(getPostProvider).when(
        data: (posts) {
         return  ref.watch(getLatestPostProvider).when(
              data: (data) {
                if (data.events.contains(
                    'databases.*.collections.${AppwriteConstants.postCollectionId}.documents.*.create')) {
                  posts.insert(0, PostModel.fromMap(data.payload));
                }
                //else write code to update the post
                return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = posts[index];
                      String podImage = getPod(post.pod);
                      return PostCard(post: post, podImage: podImage);
                    });
              },
              error: (error, StackTrace) => ErrorText(error: error.toString()),
              loading: () => ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = posts[index];
                    String podImage = getPod(post.pod);
                    return PostCard(post: post, podImage: podImage);
                  }));
        },
        error: (error, StackTrace) => ErrorText(error: error.toString()),
        loading: () => Loader());
  }
}
