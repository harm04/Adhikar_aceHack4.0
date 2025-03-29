
import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/features/home/controller/post_controller.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/post_card.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PodsView extends ConsumerStatefulWidget {
  final String podimage;
  final String podTitle;
  final String podDescription;
  final String podBanner;
  const PodsView(
      {super.key,
      required this.podimage,
      required this.podTitle,
      required this.podDescription,
      required this.podBanner});

  @override
  ConsumerState<PodsView> createState() => _PodsViewState();
}

class _PodsViewState extends ConsumerState<PodsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(widget.podBanner, fit: BoxFit.cover),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(1),
                              spreadRadius: 70,
                              blurRadius: 100,
                              blurStyle: BlurStyle.normal)
                        ]),
                      )),
                  Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 27,
                                backgroundImage: AssetImage(
                                  widget.podimage,
                                ),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                widget.podTitle,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.whiteColor),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(widget.podDescription,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Pallete.whiteColor,
                                )),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                ref.watch(getPodsPostProvider(widget.podTitle)).when(
                    data: (pod) {
                      return pod.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Center(
                                  child: Text(
                                "No posts available in ${widget.podTitle}",
                                style: TextStyle(fontSize: 18),
                              )),
                            )
                          : Column(
                              children: pod
                                  .map((post) => PostCard(
                                      post: post, podImage: widget.podimage))
                                  .toList(),
                            );
                    },
                    error: (error, st) => ErrorText(error: error.toString()),
                    loading: () => LoadingPage()),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
