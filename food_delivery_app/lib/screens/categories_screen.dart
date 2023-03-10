import 'package:flutter/material.dart';
import '../widgets/resturant_item.dart';
import '/dummy/dummy_data.dart';
import '/widgets/category_item.dart';
import '/dummy/dummy_resturants.dart';
import '../containers/order_review_container.dart';
import '../containers/become_a_pro_container.dart';
import '../sliders/daily_dealr_slider.dart';
import '../containers/panda_rewards_container.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar = AppBar(
      title: const Text('foodpanda'),
    );

    return Scaffold(
      appBar: appBar,
      body: ListView(children: [
        Container(
          color: const Color.fromARGB(26, 131, 129, 129),
          margin: const EdgeInsets.only(top: 10, bottom: 30),
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.52,
          child: GridView(
            // physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 8 / 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: DUMMY_CATEGORIES
                .map(
                  (catData) => CategoryItem(
                      catData.id,
                      catData.title,
                      catData.description,
                      catData.color,
                      catData.image as String),
                )
                .toList(),
          ),
        ),
        SizedBox(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.28,
            child: Stack(children: [
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Replace with your list of swipeable cards
                  itemBuilder: (BuildContext context, int index) {
                    final resData = DUMMY_RESTURANTS[index];
                    return ResturantItem(resData.id, resData.name,
                        resData.deliveryFee, resData.image);
                  }),
              const Positioned(
                  top: 0,
                  left: 16,
                  child: Text(
                    "Your Resturants",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ))
            ])),
        OrderReviewContainer(mediaQuery: mediaQuery, appBar: appBar),
        const DailyDealsSlider(),
      BecomeAProContainer(mediaQuery: mediaQuery, appBar: appBar),
        PandaRewardsContainer(mediaQuery: mediaQuery, appBar: appBar),
      
      ]),
    );
  }
}





