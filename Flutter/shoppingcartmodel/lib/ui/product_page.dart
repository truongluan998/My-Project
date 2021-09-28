import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcartmodel/model/shop.dart';
import 'package:shoppingcartmodel/shop/shop_bloc.dart';
import 'package:shoppingcartmodel/ui/product_detail.dart';
import 'package:shoppingcartmodel/ui/shopping_cart.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ShopItem> shopItems = [];
  List<ShopItem> cartItems = [];
  bool loadingData = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is ShopInitial) {
          loadingData = true;
        }
        if (state is ShopPageLoadedState) {
          shopItems = state.shopData.shopItems;
          cartItems = state.cartData.shopItems;
          loadingData = false;
        }
        if (state is ItemAddedCartState) {
          cartItems = state.cartItems;
        }
        if (state is ItemDeletingCartState) {
          cartItems = state.cartItems;
        }
      },
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('E-Com'),
              backgroundColor: Colors.orange,
              elevation: 0,
            ),
            backgroundColor: Color(0xFFEEEEEE),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<ShopBloc>(context),
                          child: ShoppingCart(),
                        )));
              },
              child: Text('${cartItems.length}'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: shopItems.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<ShopBloc>(
                                                context)
                                              ..add(ItemAddedCartEvent(
                                                  cartItems: cartItems)),
                                            child: ProductDetails(
                                              shopItem: shopItems[index],
                                            ),
                                          )));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 240,
                                  width: 156,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 30),
                                            blurRadius: 60,
                                            color: Color(0xFF393939)
                                                .withOpacity(0.1))
                                      ],
                                      borderRadius: BorderRadius.circular(60)),
                                ),
                                Positioned(
                                    top: 0,
                                    child: Image.asset(
                                      'assets/images/shape1.png',
                                      height: 99,
                                    )),
                                Positioned(
                                    right: 22,
                                    bottom: 60,
                                    child: Image.asset(
                                      'assets/images/shape2.png',
                                      height: 99,
                                    )),
                                Positioned(
                                  right: 50,
                                  top: 40,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.network(
                                          shopItems[index].imageUrl,
                                          height: 80,
                                        ),
                                        Text(
                                          '${shopItems[index].title}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('\$${shopItems[index].price}'),
                                        FlatButton(
                                          color: Color(0xFF845EC2),
                                          onPressed: () {
                                            setState(() {
                                              cartItems.add(shopItems[index]);
                                            });
                                          },
                                          child: Text(
                                            'Add to cart',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
