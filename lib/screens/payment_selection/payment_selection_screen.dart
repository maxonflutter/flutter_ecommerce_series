import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:pay/pay.dart';

import '/blocs/blocs.dart';
import '/widgets/widgets.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PaymentSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Selection'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state.status == PaymentStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state.status == PaymentStatus.initial) {
            stripe.CardFormEditController controller =
                stripe.CardFormEditController();

            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Text(
                  'Add your Credit Card Details',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 10),
                stripe.CardFormField(controller: controller),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () async {
                    if (controller.details.complete) {
                      final stripePaymentMethod =
                          await stripe.Stripe.instance.createPaymentMethod(
                        stripe.PaymentMethodParams.card(
                          paymentMethodData: stripe.PaymentMethodData(
                            billingDetails: stripe.BillingDetails(
                              email: (context.read<CheckoutBloc>().state
                                      as CheckoutLoaded)
                                  .checkout
                                  .user!
                                  .email,
                            ),
                          ),
                        ),
                      );

                      context.read<PaymentBloc>().add(
                            SelectPaymentMethod(
                              paymentMethod: PaymentMethod.credit_card,
                              paymentMethodId: stripePaymentMethod.id,
                            ),
                          );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('The form is not complete.'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Pay with Credit Card',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Choose a different payment method',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 10),
                Platform.isIOS
                    ? RawApplePayButton(
                        style: ApplePayButtonStyle.black,
                        type: ApplePayButtonType.inStore,
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                                SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.apple_pay,
                                ),
                              );
                          Navigator.pop(context);
                        },
                      )
                    : SizedBox(),
                const SizedBox(height: 10),
                Platform.isAndroid
                    ? RawGooglePayButton(
                        style: GooglePayButtonStyle.black,
                        type: GooglePayButtonType.pay,
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                                SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.google_pay,
                                ),
                              );
                          Navigator.pop(context);
                        },
                      )
                    : SizedBox(),
              ],
            );
          } else {
            return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
