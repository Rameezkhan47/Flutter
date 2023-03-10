import 'package:flutter/material.dart';
import '../widgets/image_item.dart';
import '../dummy/dummy_images_list.dart';


class DailyDealsSlider extends StatelessWidget {
  const DailyDealsSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [SizedBox(
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8, // Replace with your list of swipeable cards
            itemBuilder: (BuildContext context, int index) {
              final imgData = DUMMY_IMAGES[index];
              return ImageItem(imgData.id, imgData.image);
            }),
      ),
      const Positioned(
              top: 0,
              left: 16,
              child: Text(
                "Your Daily Deals",
                style: TextStyle(
                  fontSize: 15,
                ),
              ))
      ]);
  }
}