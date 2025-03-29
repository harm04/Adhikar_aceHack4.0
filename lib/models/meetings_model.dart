// ignore_for_file: public_member_api_docs, sort_constructors_first

class MeetingsModel {
  final String id;
  
  final String clientName;
  final String lawyerName;
  final String meetingDate;
  final String meetingTime;
  final String clientUid;
  final String lawyerUid;
  final String meetingStatus;
  final String clientProfileImg;
  final String lawyerProfileImg;
  MeetingsModel({
    required this.id,
    required this.clientUid,
    required this.lawyerUid,
    required this.clientName,
    required this.lawyerName,
    required this.meetingDate,
    required this.meetingTime,
    required this.meetingStatus,
    required this.clientProfileImg,
    required this.lawyerProfileImg,
  });

  MeetingsModel copyWith({
    String? clientName,
    String? clientUid,
    String?id,
    String? lawyerUid,
    String? lawyerName,
    String? meetingDate,
    String? meetingTime,
    String? meetingStatus,
    String? clientProfileImg,
    String? lawyerProfileImg,
  }) {
    return MeetingsModel(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      clientUid: clientUid ?? this.clientUid,
      lawyerUid: lawyerUid ?? this.lawyerUid,
      lawyerName: lawyerName ?? this.lawyerName,
      meetingDate: meetingDate ?? this.meetingDate,
      meetingTime: meetingTime ?? this.meetingTime,
      meetingStatus: meetingStatus ?? this.meetingStatus,
      clientProfileImg: clientProfileImg ?? this.clientProfileImg,
      lawyerProfileImg: lawyerProfileImg ?? this.lawyerProfileImg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientName': clientName,
      'lawyerName': lawyerName,
      'clientUid': clientUid,
      'lawyerUid': lawyerUid,
      'meetingDate': meetingDate,
      'meetingTime': meetingTime,
      'meetingStatus': meetingStatus,
      'clientProfileImg': clientProfileImg,
      'lawyerProfileImg': lawyerProfileImg,
    };
  }

  factory MeetingsModel.fromMap(Map<String, dynamic> map) {
    return MeetingsModel(
      id: map['\$id'] as String,
      clientName: map['clientName'] as String,
      clientUid: map['clientUid'] as String,
      lawyerUid: map['lawyerUid'] as String,
      lawyerName: map['lawyerName'] as String,
      meetingDate: map['meetingDate'] as String,
      meetingTime: map['meetingTime'] as String,
      meetingStatus: map['meetingStatus'] as String,
      clientProfileImg: map['clientProfileImg'] as String,
      lawyerProfileImg: map['lawyerProfileImg'] as String,
    );
  }

  @override
  String toString() {
    return 'meetings(uid: $id,clientUid:$clientUid,lawyerUid:$lawyerUid, clientName: $clientName, lawyerName: $lawyerName, meetingDate: $meetingDate, meetingTime: $meetingTime, meetingStatus: $meetingStatus, clientProfileImg: $clientProfileImg, lawyerProfileImg: $lawyerProfileImg)';
  }

  @override
  bool operator ==(covariant MeetingsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.clientName == clientName &&
        other.lawyerName == lawyerName &&
        other.clientUid == clientUid &&
        other.lawyerUid == lawyerUid &&
        other.meetingDate == meetingDate &&
        other.meetingTime == meetingTime &&
        other.meetingStatus == meetingStatus &&
        other.clientProfileImg == clientProfileImg &&
        other.lawyerProfileImg == lawyerProfileImg;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clientName.hashCode ^
        lawyerName.hashCode ^
        meetingDate.hashCode ^
        meetingTime.hashCode ^
        meetingStatus.hashCode ^
        clientProfileImg.hashCode ^
        clientUid.hashCode ^
        lawyerUid.hashCode ^
        lawyerProfileImg.hashCode;
  }
}
