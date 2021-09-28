import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoppingcartmodel/model/shop.dart';
import 'package:shoppingcartmodel/repository/shop_data_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {

  ShopDataProvider shopDataProvider = ShopDataProvider();
  ShopBloc() : super(ShopInitial()) {
    add(ShopPageInitializedEvent());
  }

  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    if(event is ShopPageInitializedEvent) {
      ShopData shopData = await shopDataProvider.getShopItems();
      ShopData cartData = await shopDataProvider.getCartItems();
      yield ShopPageLoadedState(shopData: shopData, cartData: cartData);
    }
    if(event is ItemAddingCartEvent) {
      yield ItemAddingCartState(cartItems: event.cartItems, cartData: null);
    }
    if(event is ItemAddedCartEvent) {
      yield ItemAddedCartState(cartItems: event.cartItems);
    }
    if(event is DeleteItemCartEvent) {
      yield ItemDeletingCartState(cartItems: event.cartItems);
    }
  }
}
