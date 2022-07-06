part of 'order_confirmation_bloc.dart';

abstract class OrderConfirmationState extends Equatable {
  const OrderConfirmationState();

  @override
  List<Object> get props => [];
}

class OrderConfirmationLoading extends OrderConfirmationState {}

class OrderConfirmationLoaded extends OrderConfirmationState {
  final Checkout checkout;

  OrderConfirmationLoaded(this.checkout);

  @override
  List<Object> get props => [checkout];
}
