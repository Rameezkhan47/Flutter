import 'package:flutter/material.dart';

class BecomeAProContainer extends StatelessWidget {
  const BecomeAProContainer({
    super.key,
    required this.mediaQuery,
    required this.appBar,
  });

  final MediaQueryData mediaQuery;
  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 40),
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
            0.11,
        child: Stack(
          children: [
            Row(
              children: [
                Text(
                  'Become a pro',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Positioned(
                top: 25,
                child: Text(
                  'and get exclusive deals',
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: 122,
                height: 75,
                child: Image.asset(
                  'assets/images/panda_glasses.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          
          ],
        ),
      );
  }
}

