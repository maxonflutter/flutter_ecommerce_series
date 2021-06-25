import 'package:flutter_ecommerce_app/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}
