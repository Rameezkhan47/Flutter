import 'package:flutter/material.dart';


class PandaRewardsContainer extends StatelessWidget {
  const PandaRewardsContainer({
    super.key,
    required this.mediaQuery,
    required this.appBar,
  });

  final MediaQueryData mediaQuery;
  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
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
                'Try panda rewards!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Positioned(
              top: 25,
              child: Text(
                'Earn points and win prizes',
                style: Theme.of(context).textTheme.bodySmall,
              )),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              width: 42,
              child: Image.asset('assets/images/panda2.jpeg',

                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}