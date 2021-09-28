part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent extends Equatable {
  const ShopEvent();
}

class ShopPageInitializedEvent extends ShopEvent{
  @override
  List<Object?> get props => [];
}

class ItemAddingCartEvent extends ShopEvent{
  final List<ShopItem> cartItems;
  ItemAddingCartEvent({required this.cartItems});

  @override
  List<Object?> get props => [];
}

class ItemAddedCartEvent extends ShopEvent{
  final List<ShopItem> cartItems;
  ItemAddedCartEvent({required this.cartItems});

  @override
  List<Object?> get props => [];
}

class DeleteItemCartEvent extends ShopEvent{
  final List<ShopItem> cartItems;
  final int? index;
  DeleteItemCartEvent({required this.cartItems, required this.index});

  @override
  List<Object?> get props => [];
}
