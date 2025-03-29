
import 'package:adhikar_acehack4_o/common/failure.dart';
import 'package:adhikar_acehack4_o/common/provider/provider.dart';
import 'package:adhikar_acehack4_o/common/type_def.dart';
import 'package:adhikar_acehack4_o/constants/appwrite_contants.dart';
import 'package:adhikar_acehack4_o/models/post_model.dart';
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final postAPIProvider = Provider((ref) {
  return PostAPI(
      db: ref.watch(appwriteDatabaseProvider),
      realtime: ref.watch(appwriteRealTimeProvider));
});

abstract class IPostAPI {
  FutureEither<Document> sharePost(PostModel postModel);
  Future<List<Document>> getPosts();
  Stream<RealtimeMessage> getLatestPosts();
  FutureEither<Document> likePost(PostModel postModel);
  Future<List<Document>> getComments(PostModel postModel);
   Future<List<Document>> getUsersPost(UserModel userModel);
    Future<List<Document>> getPodsPost(String podName);
}

class PostAPI implements IPostAPI {
  final Databases _db;
  final Realtime _realtime;
  PostAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;
  @override
  FutureEither<Document> sharePost(PostModel postModel) async {
    try {
      final document = await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.postCollectionId,
          documentId: ID.unique(),
          data: postModel.toMap());
      return right(document);
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<List<Document>> getPosts() async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.postCollectionId,
        queries: [Query.orderDesc('createdAt')]);

    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestPosts() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.postCollectionId}.documents'
    ]).stream;
  }

  @override
  FutureEither<Document> likePost(PostModel postModel) async {
    try {
      final document = await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.postCollectionId,
          documentId: postModel.id,
          data: {'likes': postModel.likes});
      return right(document);
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<List<Document>> getComments(PostModel postModel) async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.postCollectionId,
        queries: [
          Query.equal('commentedTo', postModel.id),
        ]);

    return documents.documents;
  }
  
 @override
  Future<List<Document>> getUsersPost( UserModel userModel) async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.postCollectionId,
        queries: [
          Query.equal('uid', userModel.uid),
        ]);

    return documents.documents;
  }

    @override
  Future<List<Document>> getPodsPost(String podName) async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.postCollectionId,
        queries: [
          Query.equal('pod', podName),
        ]);

    return documents.documents;
  }
}
