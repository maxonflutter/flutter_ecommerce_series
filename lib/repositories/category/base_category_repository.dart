import 'package:flutter_ecommerce_app/models/models.dart';

abstract class BaseCategoryRepository {
  Stream<List<Category>> getAllCategories();
}
