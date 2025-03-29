
import 'package:adhikar_acehack4_o/common/failure.dart';
import 'package:adhikar_acehack4_o/common/provider/provider.dart';
import 'package:adhikar_acehack4_o/common/type_def.dart';
import 'package:adhikar_acehack4_o/constants/appwrite_contants.dart';
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
      db: ref.watch(appwriteDatabaseProvider),
      realtime: ref.watch(appwriteRealTimeProvider));
});

abstract class IUserAPI {
  
  FutureEitherVoid saveUserData(UserModel userModel);
  
  Future<Document> getUserData(String uid);

  Future<List<Document>> searchUser(String name);

  Stream<RealtimeMessage> getLatestUserProfileData();
  
}

class UserAPI implements IUserAPI {
  final Databases _db;
  final Realtime _realtime;
  UserAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;
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

  @override
  Future<Document> getUserData(String uid) {
    print('get suer data ${uid}');
    return _db.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollectionId,
        documentId: uid);
  }

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
  Stream<RealtimeMessage> getLatestUserProfileData() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.usersCollectionId}.documents'
    ]).stream;
  }

 
}
