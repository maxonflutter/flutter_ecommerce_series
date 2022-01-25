part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final PaymentMethod paymentMethod;

  PaymentLoaded({
    this.paymentMethod = PaymentMethod.apple_pay,
  });

  @override
  List<Object> get props => [paymentMethod];
}
