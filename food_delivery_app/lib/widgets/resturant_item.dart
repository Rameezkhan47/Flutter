import 'package:flutter/material.dart';

class ResturantItem extends StatelessWidget {
  final String id;
  final String name;
  final double deliveryFee;
  final String image;
  const ResturantItem(this.id, this.name, this.deliveryFee, this.image,
      {super.key});

  @override
  
  Widget build(BuildContext context) {
        final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 5),
      
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top:25),
            height: mediaQuery.size.height*0.18,
            width: 250,
            padding: const EdgeInsets.all(5), // add padding here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 6,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 6,
            child: Text(
              'PKR $deliveryFee delivery fee' ,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
