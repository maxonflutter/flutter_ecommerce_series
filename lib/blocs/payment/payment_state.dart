part of 'payment_bloc.dart';

enum PaymentMethod { apple_pay, google_pay, credit_card }

enum PaymentStatus { initial, loading, success, failure }

class PaymentState extends Equatable {
  final PaymentStatus status;
  final PaymentMethod paymentMethod;
  final stripe.CardFieldInputDetails? cardFieldInputDetails;
  final String? paymentMethodId;

  const PaymentState({
    this.status = PaymentStatus.initial,
    this.paymentMethod = PaymentMethod.credit_card,
    this.cardFieldInputDetails =
        const stripe.CardFieldInputDetails(complete: false),
    this.paymentMethodId,
  });

  PaymentState copyWith({
    PaymentStatus? status,
    PaymentMethod? paymentMethod,
    stripe.CardFieldInputDetails? cardFieldInputDetails,
    String? paymentMethodId,
  }) {
    return PaymentState(
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardFieldInputDetails:
          cardFieldInputDetails ?? this.cardFieldInputDetails,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        paymentMethod,
        cardFieldInputDetails,
        paymentMethodId,
      ];
}
