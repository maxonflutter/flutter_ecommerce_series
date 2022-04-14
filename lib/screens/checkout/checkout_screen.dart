import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '/blocs/blocs.dart';
import '/widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              var user = state.user ?? User.empty;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CUSTOMER INFORMATION',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  CustomTextFormField(
                    title: 'Email',
                    initialValue: user.email,
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(
                              user: state.checkout.user!.copyWith(email: value),
                            ),
                          );
                    },
                  ),
                  CustomTextFormField(
                    title: 'Full Name',
                    initialValue: user.fullName,
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(
                              user: state.checkout.user!
                                  .copyWith(fullName: value),
                            ),
                          );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'DELIVERY INFORMATION',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  CustomTextFormField(
                    title: 'Address',
                    initialValue: user.address,
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(
                              user:
                                  state.checkout.user!.copyWith(address: value),
                            ),
                          );
                    },
                  ),
                  CustomTextFormField(
                    title: 'City',
                    initialValue: user.city,
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(
                              user: state.checkout.user!.copyWith(city: value),
                            ),
                          );
                    },
                  ),
                  CustomTextFormField(
                    title: 'Country',
                    initialValue: user.country,
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(
                              user:
                                  state.checkout.user!.copyWith(country: value),
                            ),
                          );
                    },
                  ),
                  CustomTextFormField(
                    title: 'ZIP Code',
                    initialValue: user.zipCode,
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(
                              user:
                                  state.checkout.user!.copyWith(zipCode: value),
                            ),
                          );
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/payment-selection',
                              );
                            },
                            child: Text(
                              'SELECT A PAYMENT METHOD',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'ORDER SUMMARY',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  OrderSummary()
                ],
              );
            } else {
              return Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
