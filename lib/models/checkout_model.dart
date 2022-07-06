import 'package:equatable/equatable.dart';
import '../blocs/payment/payment_bloc.dart';
import '/models/models.dart';

class Checkout extends Equatable {
  final String id;
  final User? user;
  final Cart cart;
  final PaymentMethod paymentMethod;
  final String? paymentMethodId;
  final bool isPaymentSuccessful;

  const Checkout({
    this.id = '',
    this.user = User.empty,
    required this.cart,
    this.paymentMethod = PaymentMethod.credit_card,
    this.isPaymentSuccessful = false,
    this.paymentMethodId,
  });

  Checkout copyWith({
    String? id,
    User? user,
    Cart? cart,
    PaymentMethod? paymentMethod,
    String? paymentMethodId,
    bool? isPaymentSuccessful,
  }) {
    return Checkout(
      id: id ?? this.id,
      user: user ?? this.user,
      cart: cart ?? this.cart,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      isPaymentSuccessful: isPaymentSuccessful ?? this.isPaymentSuccessful,
    );
  }

  int get total {
    double subtotal =
        this.cart.products.fold(0, (total, current) => total + current.price);
    if (subtotal >= 30.0) {
      return (subtotal * 100).toInt();
    } else
      return ((subtotal + 10.0) * 100).toInt();
  }

  @override
  List<Object?> get props => [
        id,
        user,
        cart,
        paymentMethod,
        paymentMethodId,
        isPaymentSuccessful,
      ];

  Map<String, Object> toDocument() {
    return {
      'user': user?.toDocument() ?? User.empty.toDocument(),
      'cart': cart.toDocument(),
      'paymentMethod': paymentMethod.name,
      'paymentMethodId': paymentMethodId ?? '',
      'isPaymentSuccessful': isPaymentSuccessful,
    };
  }

  static Checkout fromJson(
    Map<String, dynamic> json, [
    String? id,
  ]) {
    Checkout checkout = Checkout(
      id: id ?? json['id'],
      user: User.fromJson(json['user']),
      cart: Cart.fromJson(json['cart']),
      paymentMethod: PaymentMethod.values.firstWhere(
        (value) {
          return value.toString().split('.').last == json['paymentMethod'];
        },
      ),
      paymentMethodId: json['paymentMethodId'],
      isPaymentSuccessful: json['isPaymentSuccessful'],
    );
    return checkout;
  }
}
