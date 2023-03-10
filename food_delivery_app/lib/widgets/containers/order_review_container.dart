import 'package:flutter/material.dart';



class OrderReviewContainer extends StatelessWidget {
  const OrderReviewContainer({
    super.key,
    required this.mediaQuery,
    required this.appBar,
  });

  final MediaQueryData mediaQuery;
  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 0.3,
          )),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.18,
      child: Stack(
        children: [
          Row(
            children: [
              Text(
                'How was your order?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                  width: 20), // Add some spacing between text and image
            ],
          ),
          Positioned(
              top: 25,
              child: Text(
                'Delizia',
                style: Theme.of(context).textTheme.bodySmall,
              )),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              width: 82,
              child: Image.asset(
                'assets/images/panda.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    // code to execute when button is pressed
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                    shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: const Text('Rate order'),
                )),
          ),
        ],
      ),
    );
  }
}
