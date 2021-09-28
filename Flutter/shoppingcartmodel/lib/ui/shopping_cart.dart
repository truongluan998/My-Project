import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcartmodel/model/shop.dart';
import 'package:shoppingcartmodel/shop/shop_bloc.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ShopItem> cartItems = [];
  double totalAmount = 0.0;

  void calculateTotalAmount(List<ShopItem> list) {
    double res = 0.0;
    list.forEach((element) {
      res += element.price * element.quantity;
    });
    totalAmount = res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopPageLoadedState) {
          cartItems = state.cartData.shopItems;
          calculateTotalAmount(cartItems);
        }
        if (state is ItemAddedCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        if (state is ItemDeletingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        if (state is ItemAddingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        return Scaffold(
          backgroundColor: Colors.yellow,
          appBar: AppBar(
            backgroundColor: Color(0XFFF8F5F0),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.purple,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Shopping Cart',
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 8,
                  color: Color(0xFF000000).withOpacity(0.20)
                ),
                BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    color: Color(0xFF000000).withOpacity(0.20)
                ),
                BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    color: Color(0xFF000000).withOpacity(0.20)
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Total Amount'),
                  Text('\$${totalAmount.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
          body: cartItems == null || cartItems.length == 0
              ? Center(
                  child: Text('Cart is empty'),
                )
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    cartItems[index].imageUrl,
                                    height: 64,
                                    width: 64,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('${cartItems[index].title}'),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (state is ShopPageLoadedState) {
                                            state.cartData.shopItems
                                                .removeAt(index);
                                            calculateTotalAmount(cartItems);
                                            BlocProvider.of<ShopBloc>(context)
                                              ..add(DeleteItemCartEvent(
                                                  cartItems:
                                                      state.cartData.shopItems,
                                                  index: null));
                                          } else if (state
                                              is ItemAddedCartState) {
                                            state.cartItems.removeAt(index);
                                            calculateTotalAmount(cartItems);
                                            BlocProvider.of<ShopBloc>(context)
                                              ..add(DeleteItemCartEvent(
                                                  cartItems: state.cartItems,
                                                  index: null));
                                          } else if (state
                                              is ItemDeletingCartState) {
                                            state.cartItems.removeAt(index);
                                            calculateTotalAmount(cartItems);
                                            BlocProvider.of<ShopBloc>(context)
                                              ..add(DeleteItemCartEvent(
                                                  cartItems: state.cartItems,
                                                  index: null));
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.cancel))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (cartItems[index].quantity > 0) {
                                          setState(() {
                                            calculateTotalAmount(cartItems);
                                            cartItems[index].quantity--;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.remove)),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Text(
                                          cartItems[index].quantity.toString()),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          calculateTotalAmount(cartItems);
                                          cartItems[index].quantity++;
                                        });
                                      },
                                      icon: Icon(Icons.add)),
                                  Spacer(),
                                  Text('\$${(cartItems[index].price * cartItems[index].quantity).toStringAsFixed(2)}')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        );
      },
    );
  }
}
