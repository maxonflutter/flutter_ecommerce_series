part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final Checkout checkout;

  CheckoutLoaded({
    required this.checkout,
  });

  @override
  List<Object?> get props => [checkout];
}
