import 'package:ecommerce/model/Product.dart';
import 'package:ecommerce/screen/details/component/body.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments routeArguments =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details',
          textAlign: TextAlign.center,
        ),
      ),
      body: Body(product: routeArguments.product),
    );
  }
}

//use name route so need to create a arguments class
class ProductDetailsArguments {
  final Product product;
  ProductDetailsArguments({required this.product});
}
