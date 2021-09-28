import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/module/class.dart';

abstract class BlocEvent {}

abstract class BlocState {}

class AddToCart extends BlocEvent {
  Product product;

  AddToCart({required this.product});
}

class DeleteFromCart extends BlocEvent {
  Product product;

  DeleteFromCart({required this.product});
}

class ClearCart extends BlocEvent {}

class LoadingState extends BlocState {}

class SuccessState extends BlocState {
  List<Product> cartProduct;
  SuccessState({required this.cartProduct});
}

class FailState extends BlocState {
  String fail;

  FailState({required this.fail});
}

class ProductBloc extends Bloc<BlocEvent, BlocState> {
  ProductBloc() : super(SuccessState(cartProduct: []));

  List<Product> cartProducts = [];

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    yield LoadingState();
    try {
      if (event is AddToCart) {
        cartProducts.add(event.product);
      } else if (event is DeleteFromCart) {
        cartProducts.remove(event.product);
      } else if (event is ClearCart) {
        cartProducts = [];
      }
      yield SuccessState(cartProduct: cartProducts);
    } catch (e) {
      yield FailState(fail: e.toString());
    }
  }
}
