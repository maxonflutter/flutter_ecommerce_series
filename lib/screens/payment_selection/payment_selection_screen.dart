import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/models.dart';
import 'package:pay/pay.dart';
import '/widgets/widgets.dart';
import '/blocs/blocs.dart';

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
          if (state is PaymentLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Text(
                  'CHOOSE A PAYMENT OPTION',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 10),
                Platform.isIOS
                    ? RawApplePayButton(
                        style: ApplePayButtonStyle.black,
                        type: ApplePayButtonType.inStore,
                        onPressed: () {
                          print('Payment Selected');
                          context.read<PaymentBloc>().add(
                                SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.apple_pay,
                                ),
                              );
                          Navigator.pop(context);
                        },
                      )
                    : SizedBox(),
                Platform.isAndroid
                    ? RawGooglePayButton(
                        style: GooglePayButtonStyle.black,
                        type: GooglePayButtonType.pay,
                        onPressed: () {
                          print('Payment Selected');
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
            return Text('Something went wrong.');
          }
        },
      ),
    );
  }
}
