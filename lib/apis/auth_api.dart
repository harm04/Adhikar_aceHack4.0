
import 'package:adhikar_acehack4_o/common/failure.dart';
import 'package:adhikar_acehack4_o/common/provider/provider.dart';
import 'package:adhikar_acehack4_o/common/type_def.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final authAPIProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteAccountProvider));
});

abstract class IAuthApi {
  Future<User?> currentUserAccount();
  FutureEither<User> signUp({required String email, required String password});
  FutureEither<Session> login(
      {required String email, required String password});
  FutureEitherVoid signout();
}

class AuthAPI implements IAuthApi {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;
  @override
  FutureEither<User> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return right(account);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  FutureEither<Session> login(
      {required String email, required String password}) async {
    try {
      final session = await _account.createEmailPasswordSession(
          email: email, password: password);
      return right(session);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  Future<User?> currentUserAccount() async {
    try {
      return await _account.get();
    } catch (err) {
      return null;
    }
  }

  @override
  FutureEitherVoid signout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }
}
