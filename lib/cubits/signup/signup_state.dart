part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String password;
  final SignupStatus status;
  final auth.User? authUser;
  final User? user;

  bool get isFormValid => user!.email.isNotEmpty && password.isNotEmpty;

  const SignupState({
    required this.password,
    required this.status,
    this.authUser,
    this.user,
  });

  factory SignupState.initial() {
    return SignupState(
      password: '',
      status: SignupStatus.initial,
      authUser: null,
      user: User(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [password, status, authUser, user];

  SignupState copyWith({
    String? password,
    SignupStatus? status,
    auth.User? authUser,
    User? user,
  }) {
    return SignupState(
      password: password ?? this.password,
      status: status ?? this.status,
      authUser: authUser ?? this.authUser,
      user: user ?? this.user,
    );
  }
}
