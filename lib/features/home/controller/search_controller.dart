
import 'package:adhikar_acehack4_o/apis/user_api.dart';
import 'package:adhikar_acehack4_o/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final SearchUserControllerProvider = StateNotifierProvider((ref) {
  return SearchUserController(userAPI: ref.watch(userAPIProvider));
});

final searchUserProvider = FutureProvider.family((ref, String name) async {
  final searchUserController = ref.watch(SearchUserControllerProvider.notifier);
  return searchUserController.searchUSer(name);
});

class SearchUserController extends StateNotifier<bool> {
  final UserAPI _userAPI;

  SearchUserController({required UserAPI userAPI})
      : _userAPI = userAPI,
        super(false);

  Future<List<UserModel>> searchUSer(String name) async {
    final users = await _userAPI.searchUser(name);
    return users.map((e) => UserModel.fromMap(e.data)).toList();
  }
}
