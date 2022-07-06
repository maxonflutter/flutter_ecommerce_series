part of 'order_confirmation_bloc.dart';

abstract class OrderConfirmationEvent extends Equatable {
  const OrderConfirmationEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderConfirmation extends OrderConfirmationEvent {
  final String checkoutId;

  LoadOrderConfirmation({required this.checkoutId});

  @override
  List<Object> get props => [checkoutId];
}
