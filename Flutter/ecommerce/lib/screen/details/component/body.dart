import 'package:ecommerce/component/default_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/model/Product.dart';
import 'package:ecommerce/screen/details/component/product_description.dart';
import 'package:ecommerce/screen/details/component/product_image.dart';
import 'package:ecommerce/screen/details/component/top_rounded_container.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_dotss.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImage(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                    color: Color(0xFFF6F7F9),
                    child: Column(
                      children: [
                        ColorsDots(product: product),
                        TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.15,
                                  right: SizeConfig.screenWidth * 0.15,
                                top: getProportionateScreenWidth(15),
                                bottom: getProportionateScreenWidth(40)
                              ),
                              child: DefaultButton(
                                text: 'Add to Cart',
                                press: () {},
                              ),
                            ))
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
