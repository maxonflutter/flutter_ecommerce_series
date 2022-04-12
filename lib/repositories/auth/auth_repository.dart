import 'package:ecommerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth, required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  @override
  Future<auth.User?> signUp({
    required String password,
    required User user,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      user.copyWith(id: credential.user!.uid);

      await _userRepository.createUser(user);
    } catch (_) {}
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
