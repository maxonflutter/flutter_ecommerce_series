import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';
import '/widgets/widgets.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SignupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Signup'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _UserInput(
                  labelText: 'Email',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(email: value),
                        );
                  },
                ),
                const SizedBox(height: 10),
                _UserInput(
                  labelText: 'Full Name',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(fullName: value),
                        );
                  },
                ),
                const SizedBox(height: 10),
                _UserInput(
                  labelText: 'Country',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(country: value),
                        );
                  },
                ),
                const SizedBox(height: 10),
                _UserInput(
                  labelText: 'City',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(city: value),
                        );
                  },
                ),
                const SizedBox(height: 10),
                _UserInput(
                  labelText: 'Address',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(address: value),
                        );
                  },
                ),
                _UserInput(
                  labelText: 'ZIP Code',
                  onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                          state.user!.copyWith(zipCode: value),
                        );
                  },
                ),
                _PasswordInput(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignupCubit>().signUpWithCredentials();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    primary: Colors.black,
                    fixedSize: Size(200, 40),
                  ),
                  child: Text(
                    'Signup',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  const _UserInput({
    Key? key,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (password) {
        context.read<SignupCubit>().passwordChanged(password);
      },
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
    );
  }
}
