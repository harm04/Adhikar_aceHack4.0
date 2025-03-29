
import 'package:adhikar_acehack4_o/common/failure.dart';
import 'package:adhikar_acehack4_o/common/provider/provider.dart';
import 'package:adhikar_acehack4_o/common/type_def.dart';
import 'package:adhikar_acehack4_o/constants/appwrite_contants.dart';
import 'package:adhikar_acehack4_o/models/lawyer_model.dart';
import 'package:adhikar_acehack4_o/models/meetings_model.dart';
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

//
final userAPIProvider = Provider((ref) {
  return UserAPI(
      db: ref.watch(appwriteDatabaseProvider),
      realtime: ref.watch(appwriteRealTimeProvider));
});

abstract class IUserAPI {
  //
  FutureEitherVoid saveUserData(UserModel userModel);
  //
  Future<Document> getUserData(String uid);
//
  Future<List<Document>> searchUser(String name);

  FutureEitherVoid updateUser(UserModel userModel);
  //
  Stream<RealtimeMessage> getLatestUserProfileData();

  Future<List<Document>> getLawyers();

  FutureEitherVoid addToFollowers(UserModel userModel);

  FutureEitherVoid applyForLawyer(UserModel userModel, LawyerModel lawyerModel);

  FutureEitherVoid generateMeeting(MeetingsModel meetingsModel);

  FutureEitherVoid addToFollowing(UserModel userModel);

  Future<List<Document>> getMeetings(String clientUid);

  Stream<RealtimeMessage> getLatestMeetings();
  // Future<List<Document>> getMeetingsForLawyers(String lawyerUid);

  Stream<RealtimeMessage> getLatestMeetingsForLawyers();
}

class UserAPI implements IUserAPI {
  final Databases _db;
  final Realtime _realtime;
  UserAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;
  //
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: userModel.toMap());
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

//
  @override
  Future<Document> getUserData(String uid) {
    print('get suer data ${uid}');
    return _db.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollectionId,
        documentId: uid);
  }

//
  @override
  Future<List<Document>> searchUser(String name) async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollectionId,
        queries: [
          Query.search('firstName', name),
        ]);

    return documents.documents;
  }

  @override
  FutureEitherVoid updateUser(UserModel userModel) async {
    try {
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: userModel.toMap());
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  Stream<RealtimeMessage> getLatestUserProfileData() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.usersCollectionId}.documents'
    ]).stream;
  }

  @override
  FutureEitherVoid addToFollowers(UserModel userModel) async {
    try {
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: {'followers': userModel.followers});
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid addToFollowing(UserModel userModel) async {
    try {
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: {'following': userModel.following});
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid applyForLawyer(
      UserModel userModel, LawyerModel lawyerModel) async {
    try {
      //update usertype in usermodel
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: {'userType': userModel.userType});

      //create lawyermodel
      await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.lawyersCollectionId,
          documentId: userModel.uid,
          data: lawyerModel.toMap());
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  Future<List<Document>> getLawyers() async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.lawyersCollectionId,
    );

    return documents.documents;
  }

  @override
  FutureEitherVoid generateMeeting(MeetingsModel meetingsModel) async {
    try {
      //create meetingsModel
      await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.meetingsCollectionId,
          documentId: ID.unique(),
          data: meetingsModel.toMap());
      // //update meetings in usermodel
      // await _db.updateDocument(
      //     databaseId: AppwriteConstants.databaseId,
      //     collectionId: AppwriteConstants.usersCollectionId,
      //     documentId: userModel.uid,
      //     data: {'meetings': userModel.meetings});

      // //update meetings in lawyermodel
      // await _db.updateDocument(
      //     databaseId: AppwriteConstants.databaseId,
      //     collectionId: AppwriteConstants.lawyersCollectionId,
      //     documentId: lawyerModel.uid,
      //     data: {'meetings': lawyerModel.meetings});

      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  Future<List<Document>> getMeetings(String clientUid) async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.meetingsCollectionId,
        queries: [Query.equal('clientUid', clientUid)]);

    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestMeetings() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.postCollectionId}.documents'
    ]).stream;
  }

  // @override
  // Future<List<Document>> getMeetingsForLawyers(String lawyerUid) async {
  //   final documents = await _db.listDocuments(
  //     databaseId: AppwriteConstants.databaseId,
  //     collectionId: AppwriteConstants.meetingsCollectionId,
  //     queries: [Query.equal('lawyerUid', lawyerUid)]
  //   );

  //   return documents.documents;
  // }

  Future<List<Document>> getPendingMeetingsForLawyers(String lawyerUid) async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.meetingsCollectionId,
        queries: [
          Query.equal('lawyerUid', lawyerUid),
          Query.equal('meetingStatus', 'pending')
        ]);
    print('document ${documents.documents}');
    return documents.documents;
  }

  Future<List<Document>> getCompletedMeetingsForLawyers(
      String lawyerUid) async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.meetingsCollectionId,
        queries: [
          Query.equal('lawyerUid', lawyerUid),
          Query.equal('meetingStatus', 'completed')
        ]);

    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestMeetingsForLawyers() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.postCollectionId}.documents'
    ]).stream;
  }
}
