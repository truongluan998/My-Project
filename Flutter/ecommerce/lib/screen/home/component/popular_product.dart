import 'package:ecommerce/component/product_card.dart';
import 'package:ecommerce/model/Product.dart';
import 'package:ecommerce/screen/details/details_screen.dart';
import 'package:ecommerce/screen/home/component/section_title.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class PopularProduct extends StatelessWidget {
  const PopularProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(text: 'Popular Product', press: () {}),
        SizedBox(
          height: getProportionateScreenWidth(20),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(demoProducts.length, (index) {
                if (demoProducts[index].isPopular) {
                  return ProductCard(
                    product: demoProducts[index],
                    press: () => Navigator.pushNamed(
                        context, DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(
                            product: demoProducts[index])),
                  );
                }
                //default width anh height is 0
                return SizedBox.shrink();
              })
            ],
          ),
          padding: EdgeInsets.only(right: 20),
        ),
      ],
    );
  }
}
