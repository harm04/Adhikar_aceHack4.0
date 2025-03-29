
import 'package:adhikar_acehack4_o/features/home/widgets/meeting_card.dart';
import 'package:adhikar_acehack4_o/models/meetings_model.dart';
import 'package:flutter/material.dart';

class LawyerPendingMeetings extends StatelessWidget {
  final List<MeetingsModel> data;

  const LawyerPendingMeetings({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: Text('No data found', style: TextStyle(color: Colors.black)));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final meeting = data[index];
        return MeetingCard(
          lawyerName: meeting.lawyerName,
          time: meeting.meetingTime,
          date: meeting.meetingDate,
          status: meeting.meetingStatus,
          lawyerProfImage: meeting.lawyerProfileImg,
          clientName: meeting.clientName,
        );
      },
    );
  }
}

class LawyerCompletedMeetings extends StatelessWidget {
  final List<MeetingsModel> data;

  const LawyerCompletedMeetings({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: Text('No data found', style: TextStyle(color: Colors.black)));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final meeting = data[index];
        return MeetingCard(
          lawyerName: meeting.lawyerName,
          time: meeting.meetingTime,
          date: meeting.meetingDate,
          status: meeting.meetingStatus,
          lawyerProfImage: meeting.lawyerProfileImg,
          clientName: meeting.clientName,
        );
      },
    );
  }
}
