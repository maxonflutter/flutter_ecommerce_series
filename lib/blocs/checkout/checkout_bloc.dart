import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/blocs.dart';
import '/models/models.dart';
import '/repositories/checkout/checkout_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final AuthBloc _authBloc;
  final CartBloc _cartBloc;
  final PaymentBloc _paymentBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _authSubscription;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _paymentSubscription;

  CheckoutBloc({
    required AuthBloc authBloc,
    required CartBloc cartBloc,
    required PaymentBloc paymentBloc,
    required CheckoutRepository checkoutRepository,
  })  : _authBloc = authBloc,
        _cartBloc = cartBloc,
        _paymentBloc = paymentBloc,
        _checkoutRepository = checkoutRepository,
        super(
          cartBloc.state is CartLoaded
              ? CheckoutLoaded(
                  checkout: Checkout(
                    user: authBloc.state.user,
                    cart: (cartBloc.state as CartLoaded).cart,
                  ),
                )
              : CheckoutLoading(),
        ) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _authSubscription = _authBloc.stream.listen(
      (state) {
        if (state.status == AuthStatus.unauthenticated) {
          Checkout checkout = (this.state as CheckoutLoaded)
              .checkout
              .copyWith(user: User.empty);
          add(UpdateCheckout(checkout));
        } else {
          Checkout checkout = (this.state as CheckoutLoaded)
              .checkout
              .copyWith(user: state.user);
          add(UpdateCheckout(checkout));
        }
      },
    );

    _cartSubscription = _cartBloc.stream.listen(
      (state) {
        if (state is CartLoaded) {
          Checkout checkout = (this.state as CheckoutLoaded)
              .checkout
              .copyWith(cart: state.cart);
          add(UpdateCheckout(checkout));
        }
      },
    );

    _paymentSubscription = _paymentBloc.stream.listen(
      (state) {
        if (state.status == PaymentStatus.initial) {
          Checkout checkout = (this.state as CheckoutLoaded).checkout.copyWith(
                paymentMethod: state.paymentMethod,
                paymentMethodId: state.paymentMethodId,
              );
          add(UpdateCheckout(checkout));
        }
        if (state.status == PaymentStatus.success) {
          add(ConfirmCheckout(true));
        }
      },
    );
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  ) {
    if (this.state is CheckoutLoaded) {
      emit(
        CheckoutLoaded(checkout: event.checkout),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    if (this.state is CheckoutLoaded) {
      try {
        final state = this.state as CheckoutLoaded;
        Checkout checkout = state.checkout.copyWith(isPaymentSuccessful: true);
        String checkoutId =
            await _checkoutRepository.addCheckout(state.checkout);
        emit(CheckoutLoaded(checkout: checkout.copyWith(id: checkoutId)));
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    return super.close();
  }
}
