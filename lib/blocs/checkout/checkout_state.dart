part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final User? user;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  final Checkout checkout;
  final PaymentMethod paymentMethod;

  CheckoutLoaded({
    this.user = User.empty,
    this.products,
    this.subtotal,
    this.deliveryFee,
    this.total,
    this.paymentMethod = PaymentMethod.google_pay,
  }) : checkout = Checkout(
          user: user,
          products: products,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          total: total,
        );

  @override
  List<Object?> get props => [
        user,
        products,
        subtotal,
        deliveryFee,
        total,
        checkout,
        paymentMethod,
      ];
}
