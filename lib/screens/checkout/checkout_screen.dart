import 'package:ecommerce/screens/order_confirmation/order_confirmation_screen.dart';
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
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
          listener: ((context, state) {
            if ((state as CheckoutLoaded).checkout.isPaymentSuccessful) {
              Navigator.pushNamed(
                context,
                OrderConfirmation.routeName,
                arguments: state.checkout.id,
              );
            }
          }),
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              var user = state.checkout.user ?? User.empty;

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
                      User user = state.checkout.user!.copyWith(email: value);

                      context.read<CheckoutBloc>().add(UpdateCheckout(
                            state.checkout.copyWith(user: user),
                          ));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Full Name',
                    initialValue: user.fullName,
                    onChanged: (value) {
                      User user =
                          state.checkout.user!.copyWith(fullName: value);

                      context.read<CheckoutBloc>().add(UpdateCheckout(
                            state.checkout.copyWith(user: user),
                          ));
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
                      User user = state.checkout.user!.copyWith(address: value);

                      context.read<CheckoutBloc>().add(UpdateCheckout(
                            state.checkout.copyWith(user: user),
                          ));
                    },
                  ),
                  CustomTextFormField(
                    title: 'City',
                    initialValue: user.city,
                    onChanged: (value) {
                      User user = state.checkout.user!.copyWith(city: value);

                      context.read<CheckoutBloc>().add(UpdateCheckout(
                            state.checkout.copyWith(user: user),
                          ));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Country',
                    initialValue: user.country,
                    onChanged: (value) {
                      User user = state.checkout.user!.copyWith(country: value);

                      context.read<CheckoutBloc>().add(UpdateCheckout(
                            state.checkout.copyWith(user: user),
                          ));
                    },
                  ),
                  CustomTextFormField(
                    title: 'ZIP Code',
                    initialValue: user.zipCode,
                    onChanged: (value) {
                      User user = state.checkout.user!.copyWith(zipCode: value);

                      context.read<CheckoutBloc>().add(UpdateCheckout(
                            state.checkout.copyWith(user: user),
                          ));
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
                  OrderSummary(cart: state.checkout.cart)
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
