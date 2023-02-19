import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quik_shop/body_widgets/search_bar.dart';
import 'package:quik_shop/constants.dart';
import 'package:quik_shop/models/categories_model.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quik_shop/screens/categories_screen.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 18, right: 10, bottom: 6),
              child: Text('Search', style: kTextStyleHeadings),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 16, right: 16, bottom: 6),
              child: GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: SearchBar());
                },
                child: Container(
                  width: 380,
                  height: 55,
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16),
                  decoration: kContainerDecoration,
                  child: const Icon(CupertinoIcons.search),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 18, right: 10, bottom: 6),
              child: Text('Categories', style: kTextStyleHeaders),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 6),
              child: SizedBox(
                height: 570,
                child: MasonryGridView.builder(
                  gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => CategoriesScreen(
                          name: CategoriesClass.getCategory[index].name,
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: kContainerDecoration.copyWith(
                          color: CategoriesClass.getCategory[index].color,
                        ),
                        width: 200,
                        height: 83,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(CategoriesClass.getCategory[index].name,
                                  style: kTextStyleSmallBold),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image(
                                    image: NetworkImage(CategoriesClass
                                        .getCategory[index].image),
                                    width: 50,
                                    height: 40,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: CategoriesClass.getCategory.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}