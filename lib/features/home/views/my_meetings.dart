
import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/constants/appwrite_contants.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/meeting_card.dart';
import 'package:adhikar_acehack4_o/models/meetings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyMeetingsView extends ConsumerStatefulWidget {
  const MyMeetingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyMeetingsState();
}

class _MyMeetingsState extends ConsumerState<MyMeetingsView> {
  @override
  Widget build(BuildContext context) {
    final currentUserData = ref.watch(currentUserDataProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Meetings'),
      ),
      body: ref.watch(getMeetingsListProvider(currentUserData!.uid)).when(
        data: (meetings) {
          return ref.watch(getLatestMeetingsProvider).when(
              data: (data) {
                if (data.events.contains(
                    'databases.*.collections.${AppwriteConstants.meetingsCollectionId}.documents.*.create')) {
                  meetings.insert(0, MeetingsModel.fromMap(data.payload));
                }
                //else write code to update the post
                return ListView.builder(
                    itemCount: meetings.length,
                    itemBuilder: (BuildContext context, int index) {
                      final meeting = meetings[index];

                      return MeetingCard(
                          lawyerName: meeting.lawyerName,
                          time: meeting.meetingTime,
                          date: meeting.meetingDate,
                          status: meeting.meetingStatus,
                          lawyerProfImage: meeting.lawyerProfileImg,
                          clientName: meeting.clientName);
                    });
              },
              error: (error, StackTrace) => ErrorText(error: error.toString()),
              loading: () => ListView.builder(
                  itemCount: meetings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = meetings[index];

                    return MeetingCard(
                        lawyerName: post.lawyerName,
                        time: post.meetingTime,
                        date: post.meetingDate,
                        status: post.meetingStatus,
                        lawyerProfImage: post.lawyerProfileImg,
                        clientName: post.clientName);
                  }));
        },
        error: (error, StackTrace) => ErrorText(error: error.toString()),
        loading: () => Loader()),
    );
  }
}
