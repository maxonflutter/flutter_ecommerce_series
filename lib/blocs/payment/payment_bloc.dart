import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState()) {
    on<StartPayment>(_onStartPayment);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<CreatePaymentIntent>(_onCreatePaymentIntent);
  }

  void _onStartPayment(
    StartPayment event,
    Emitter<PaymentState> emit,
  ) {
    emit(state.copyWith(status: PaymentStatus.initial));
  }

  void _onSelectPaymentMethod(
    SelectPaymentMethod event,
    Emitter<PaymentState> emit,
  ) {
    emit(state.copyWith(
      paymentMethod: event.paymentMethod,
      paymentMethodId: event.paymentMethodId,
    ));
  }

  void _onCreatePaymentIntent(
    CreatePaymentIntent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));

    final paymentIntentResults = await _callPayEndpointMethodId(
      useStripeSdk: true,
      paymentMethodId: event.paymentMethodId,
      currency: 'usd',
      amount: event.amount,
    );

    if (paymentIntentResults['error'] != null) {
      emit(state.copyWith(status: PaymentStatus.failure));
    }

    if (paymentIntentResults['clientSecret'] != null &&
        paymentIntentResults['requiresAction'] == null) {
      emit(state.copyWith(status: PaymentStatus.success));
    }

    if (paymentIntentResults['clientSecret'] != null &&
        paymentIntentResults['requiresAction'] == true) {
      // Add one more endpoint to confirm the payment intent.
    }
  }

  Future<Map<String, dynamic>> _callPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    required int amount,
    // List<Map<String, dynamic>>? items,
  }) async {
    final url = Uri.parse(
        'https://us-central1-flutter-ecommerce-app-12286.cloudfunctions.net/StripePayEndpointMethodId');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'useStripeSdk': useStripeSdk,
          'paymentMethodId': paymentMethodId,
          'currency': currency,
          'amount': amount,
        },
      ),
    );
    print(json.decode(response.body));
    return json.decode(response.body);
  }
}
