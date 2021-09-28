import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/module/class.dart';
import 'package:shoppingcart/module/product_bloc.dart';
import 'package:shoppingcart/screen/shopping_cart.dart';

void main() {
  runApp(BlocProvider<ProductBloc>(
    create: (context) => ProductBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        leading: Stack(
          children: [
          Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(CupertinoIcons.shopping_cart),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShoppingCart())),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.red,
            child: BlocBuilder<ProductBloc, BlocState>(
              builder: (context, state) =>
                  Text('${BlocProvider
                      .of<ProductBloc>(context)
                      .cartProducts
                      .length}', style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold))
                  ),
            ),
          )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: FutureBuilder<List<Product>>(
            future: Product.loadData(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) =>
                        Card(
                          child: ListTile(
                            onTap: () {},
                            title: Container(
                              height: 300,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Image(
                                        image: NetworkImage(
                                            snap.data![index].picurl!),
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Expanded(
                                      child: Text(
                                        snap.data![index].name!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            '${snap.data![index].price}\$',
                                            style: TextStyle(
                                                color: snap.data![index].off! > 0
                                                    ? Colors.red
                                                    : Colors.black,
                                                decoration:
                                                snap.data![index].off! > 0
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          snap.data![index].off! > 0
                                              ? Text(
                                              '${(snap.data![index].price! -
                                                  (snap.data![index].price! *
                                                      snap.data![index].off!))
                                                  .toStringAsFixed(2)}')
                                              : Container()
                                        ],
                                      )),
                                  IconButton(
                                      onPressed: () =>
                                          BlocProvider.of<ProductBloc>(context)
                                              .add(AddToCart(
                                              product: snap.data![index])),
                                      icon: Icon(CupertinoIcons.shopping_cart)),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
