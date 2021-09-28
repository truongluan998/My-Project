import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/module/class.dart';
import 'package:shoppingcart/module/product_bloc.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        actions: [
          BlocProvider.of<ProductBloc>(context).cartProducts.length>0 ?
          IconButton(
              onPressed: () =>
                  BlocProvider.of<ProductBloc>(context).add(ClearCart()),
              icon: Icon(CupertinoIcons.trash_slash))
              : Container()
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: BlocBuilder<ProductBloc, BlocState>(
            builder: (context, state) => state is LoadingState
                ? CupertinoActivityIndicator()
                : state is FailState
                    ? Center(
                        child: Text('${state.fail}'),
                      )
                    : state is SuccessState
                        ? Column(
                            children: [
                              Card(
                                elevation: 12,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  width: double.infinity,
                                  child: Text(
                                    'Total Cart Products: ${state.cartProduct.length}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: state.cartProduct.length,
                                    itemBuilder: (context, index) {
                                      Product _product = state.cartProduct[index];
                                      // var countProductInList = 0;
                                      // var listProduct = [];
                                      // state.cartProduct.forEach((element) {
                                      //   if(_product.id == state.cartProduct[index].id) {
                                      //     countProductInList++;
                                      //     listProduct.add(element);
                                      //   }
                                      // });
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    _product.picurl!),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '${_product.name}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${_product.price}\$',
                                                    style: TextStyle(
                                                        color: _product.off! > 0
                                                            ? Colors.red
                                                            : Colors.black,
                                                        decoration:
                                                            _product.off! > 0
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : TextDecoration
                                                                    .none),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  _product.off! > 0
                                                      ? Text(
                                                          '${(_product.price! - (_product.price! * (_product.off as num))).toStringAsFixed(2)}')
                                                      : Container()
                                                ],
                                              )),
                                              IconButton(
                                                  onPressed: () => BlocProvider
                                                          .of<ProductBloc>(
                                                              context)
                                                      .add(DeleteFromCart(
                                                          product: _product)),
                                                  icon: Icon(
                                                    CupertinoIcons.trash,
                                                    color: Colors.red,
                                                  )),
                                              // Text('x$countProductInList')
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              BlocProvider.of<ProductBloc>(context).cartProducts.length>0 ?
                              Card(
                                elevation: 12,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  width: double.infinity,
                                  color: Colors.amber,
                                  child: Text(
                                    'Total Price: ${BlocProvider.of<ProductBloc>(context).cartProducts.reduce((val, element) =>
                                        Product(price: val.price! + (element.price! - (element.price! * (element.off as num))))).price!.toStringAsFixed(2)}\$',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ): Container(),
                            ],
                          )
                        : Container(),
          ),
        ),
      ),
    );
  }
}
