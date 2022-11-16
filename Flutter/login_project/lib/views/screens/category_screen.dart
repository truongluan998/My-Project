import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_project/constants/constants.dart';
import 'package:login_project/controllers/categories_controller.dart';
import 'package:login_project/dependencies/app_dependencies.dart';
import 'package:login_project/theme/login_app_color.dart';
import 'package:login_project/views/widget/custom_back_button.dart';
import 'package:login_project/views/widget/custom_title.dart';
import 'package:easy_localization/easy_localization.dart' as localized;
import 'package:login_project/views/widget/shimmer/shimmer_category_item.dart';
import 'package:provider/provider.dart';

import '../../config/size_config.dart';
import '../../config/theme_config.dart';
import '../../utils/utils.dart';
import '../widget/category/categories_item_card.dart';
import '../widget/category/custom_text_icon_button.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  static const String routeName = '/category';

  static Route route() => MaterialPageRoute(
        builder: (_) => const CategoryScreen(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final CategoriesController _categoriesController;

  @override
  void initState() {
    super.initState();
    _categoriesController = AppDependencies.getIt.get<CategoriesController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _categoriesController.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.screenWidth == null || ThemeConfig.textTheme.bodyText1 == null) {
      Utils.setConfigApp(context);
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: SizeConfig.screenWidth! * Dimens.posLeftBanner,
            top: SizeConfig.screenHeight! * Dimens.posNegativeTopBanner,
            child: Image.asset(
              ImagesAsset.bannerAsset,
              width: Dimens.size400,
              height: Dimens.size354,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                top: Dimens.size36,
                left: Dimens.size16,
                right: Dimens.size16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.size10,
                      bottom: Dimens.size16,
                    ),
                    child: CustomBackButton(
                      press: () {},
                      isShowBorder: true,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTitle(
                        title: localized.tr('category_screen.category_ipad'),
                        textTheme: ThemeConfig.textTheme.headline2,
                      ),
                      CustomTitle(
                        title: localized.tr('category_screen.category_mini'),
                        textTheme: ThemeConfig.textTheme.headline2!.copyWith(
                          color: LoginAppColor.balloonOneColor,
                          height: Dimens.size1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimens.size4),
                  CustomTitle(
                    title: localized.tr('category_screen.category_new_mini_2022'),
                    textTheme: ThemeConfig.textTheme.bodyText2!.copyWith(
                      color: LoginAppColor.titleTextColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: Dimens.size16),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: CustomTitle(
                            title: localized.tr('category_screen.category_sort_by'),
                            textTheme: ThemeConfig.textTheme.bodyText2!.copyWith(
                              color: LoginAppColor.textBlackColor,
                            ),
                          ),
                        ),
                        CustomTextIconButton(
                          title: localized.tr('category_screen.category_popular'),
                          press: () {},
                        ),
                        const Spacer(),
                        SvgPicture.asset(ImagesAsset.filterIconAsset)
                      ],
                    ),
                  ),
                  ChangeNotifierProvider.value(
                    value: _categoriesController,
                    child: Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async => await _categoriesController.getCategories(),
                        child: Consumer<CategoriesController>(
                          builder: (context, data, child) {
                            if (data.isLoading) {
                              return const ShimmerCategoryItem();
                            } else if (!data.getCategoriesStatus) {
                              return SizedBox(
                                height: double.infinity,
                                child: ScrollConfiguration(
                                  behavior: const ScrollBehavior(),
                                  child: SingleChildScrollView(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: SizeConfig.screenHeight! * Dimens.size0Dot3),
                                        child: CustomTitle(
                                          title: localized.tr('category_screen.category_pull_down'),
                                          textTheme: ThemeConfig.textTheme.subtitle2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.categoriesResponse.data?.length,
                                padding: const EdgeInsets.symmetric(vertical: Dimens.size8),
                                itemBuilder: (BuildContext context, int index) {
                                  return CategoriesItemCard(
                                    categoryName: data.categoriesResponse.data![index].deviceName!,
                                    categoryPrice: data.categoriesResponse.data![index].price!,
                                    rating: data.categoriesResponse.data![index].rate.toString(),
                                    imageUrl: data.categoriesResponse.data![index].url!,
                                    press: () {},
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _categoriesController.dispose();
    super.dispose();
  }
}
