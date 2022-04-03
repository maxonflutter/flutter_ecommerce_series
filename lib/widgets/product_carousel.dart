import 'package:flutter/material.dart';
import '/models/models.dart';

import 'product_card.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  final bool? isRecommendedCarousel;
  final bool? isMostPopularCarousel;

  const ProductCarousel({
    Key? key,
    required this.products,
    this.isRecommendedCarousel,
    this.isMostPopularCarousel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 165,
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: ProductCard.catalog(product: products[index]),
            );
          },
        ),
      ),
    );
  }
}
