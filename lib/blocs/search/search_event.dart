part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class LoadSearch extends SearchEvent {}

class SearchProduct extends SearchEvent {
  final String productName;
  final Category? category;

  const SearchProduct({
    required this.productName,
    this.category,
  });

  @override
  List<Object?> get props => [productName, category];
}

class UpdateResults extends SearchEvent {
  final List<Product> products;

  const UpdateResults(this.products);

  @override
  List<Object?> get props => [products];
}
