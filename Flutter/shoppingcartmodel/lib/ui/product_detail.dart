import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcartmodel/model/shop.dart';
import 'package:shoppingcartmodel/shop/shop_bloc.dart';
import 'package:shoppingcartmodel/ui/shopping_cart.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.shopItem}) : super(key: key);

  final ShopItem shopItem;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<ShopItem> _cartItems = [];
  bool _itemSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ItemAddingCartState) {
          _cartItems = state.cartItems;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Image.network(widget.shopItem.imageUrl),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${widget.shopItem.title}'),
                      Text('\$${widget.shopItem.price}')
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Text('Quantity'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (widget.shopItem.quantity > 0) {
                            setState(() {
                              widget.shopItem.quantity--;
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
                            border: Border.all(color: Colors.black)),
                        child: Text(widget.shopItem.quantity.toString()),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.shopItem.quantity++;
                          });
                        },
                        icon: Icon(Icons.add)),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: FlatButton(
                      color: Colors.pink,
                      onPressed: () {
                        if (_itemSelected == false) {
                          ShopItem cartItem = ShopItem(
                              imageUrl: widget.shopItem.imageUrl,
                              thumbnail: null,
                              price: widget.shopItem.price,
                              quantity: widget.shopItem.quantity,
                              title: widget.shopItem.title);

                          _cartItems.add(cartItem);

                          BlocProvider.of<ShopBloc>(context)
                            ..add(ItemAddingCartEvent(cartItems: _cartItems));
                          setState(() {
                            _itemSelected = true;
                          });
                        } else {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) =>
                                  BlocProvider.value(
                                      value: BlocProvider.of<ShopBloc>(
                                          context), child: ShoppingCart(),)));
                        }
                      },
                      child: Text(
                        _itemSelected ? 'Go To Cart' : 'Add To Cart',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
