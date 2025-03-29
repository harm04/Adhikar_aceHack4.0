class AppwriteConstants {
  static const String endpoint = 'https://cloud.appwrite.io/v1';
  static const String projectID = '67e7a7cf0030a5565573';
  static const String databaseId = '67e7c7fd00113dde1bb1';
  static const String usersCollectionId = '67e7c8480027d7754d36';
  // static const String postCollectionId = '';
  // static const String lawyersCollectionId = '';
  // static const String meetingsCollectionId = '';

  static const String postStorageBucketID = '';

  static String imageUrl(String imageId) =>
      '$endpoint/storage/buckets/$postStorageBucketID/files/$imageId/view?project=$projectID&mode=admin';

  static const String razorpayKey = 'rzp_test_rLY2CNgq2Qdge0';
}
