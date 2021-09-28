part of 'shop_bloc.dart';

@immutable
abstract class ShopState extends Equatable {}

class ShopInitial extends ShopState {
  @override
  List<Object?> get props => [];
}

class ShopPageLoadedState extends ShopState {
  final ShopData shopData;
  final ShopData cartData;

  ShopPageLoadedState({required this.shopData, required this.cartData});

  @override
  List<Object?> get props => [];
}

class ItemAddingCartState extends ShopState {

  final ShopData? cartData;
  final List<ShopItem> cartItems;

  ItemAddingCartState({required this.cartData, required this.cartItems});

  @override
  List<Object?> get props => [];
}

class ItemAddedCartState extends ShopState{
  final List<ShopItem> cartItems;
  ItemAddedCartState({required this.cartItems});

  @override
  List<Object?> get props => [];
}

class ItemDeletingCartState extends ShopState {
  final List<ShopItem> cartItems;
  ItemDeletingCartState({required this.cartItems});

  @override
  List<Object?> get props => [];
}


