part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final Checkout checkout;

  UpdateCheckout(this.checkout);

  @override
  List<Object?> get props => [checkout];
}

class ConfirmCheckout extends CheckoutEvent {
  final bool isPaymentSuccessful;

  ConfirmCheckout(this.isPaymentSuccessful);

  @override
  List<Object?> get props => [isPaymentSuccessful];
}
