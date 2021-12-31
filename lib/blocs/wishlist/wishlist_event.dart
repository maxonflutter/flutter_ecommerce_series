part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class StartWishlist extends WishlistEvent {
  @override
  List<Object> get props => [];
}

class AddProductToWishlist extends WishlistEvent {
  final Product product;

  const AddProductToWishlist(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProductFromWishlist extends WishlistEvent {
  final Product product;

  const RemoveProductFromWishlist(this.product);

  @override
  List<Object> get props => [product];
}
