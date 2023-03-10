import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  final String id;
  final String image;
  const ImageItem(this.id, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        margin: const EdgeInsets.only(top: 25),

        padding: const EdgeInsets.all(5), // add padding here
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
