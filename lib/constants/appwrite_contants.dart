class AppwriteConstants {
  static const String endpoint = 'https://cloud.appwrite.io/v1';
  static const String projectID = '67e7a7cf0030a5565573';
  static const String databaseId = '67e7c7fd00113dde1bb1';
  static const String usersCollectionId = '67e7c8480027d7754d36';
  static const String postCollectionId = '67e7dfe8000f08b61331';
  static const String lawyersCollectionId = '67e7e0070038aa757c4b';
  static const String meetingsCollectionId = '67e7e01f002ae8ba7187';

  static const String postStorageBucketID = '67e80142003e4ed7e5ce';

  static String imageUrl(String imageId) =>
      '$endpoint/storage/buckets/$postStorageBucketID/files/$imageId/view?project=$projectID&mode=admin';

  static const String razorpayKey = 'rzp_test_rLY2CNgq2Qdge0';
}
