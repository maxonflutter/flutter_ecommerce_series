import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/checkout_model.dart';
import '/repositories/checkout/base_checkout_repository.dart';

class CheckoutRepository extends BaseCheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<String> addCheckout(Checkout checkout) async {
    DocumentReference<Map<String, dynamic>> data = await _firebaseFirestore
        .collection('checkout')
        .add(checkout.toDocument());
    return data.id;
  }

  @override
  Future<Checkout> getCheckout(String checkoutId) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firebaseFirestore.collection('checkout').doc(checkoutId).get();

    return Checkout.fromJson(doc.data()!, doc.id);
    ;
  }
}
