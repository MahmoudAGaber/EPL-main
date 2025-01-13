import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double winPerH;
  final double drawerPer;
  final double winPerA;

  const ProgressBar({
    required this.winPerH,
    required this.drawerPer,
    required this.winPerA,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure the percentages add up to 1
    final total = winPerH + drawerPer + winPerA;

    // Avoid divide-by-zero issues
    final winPerHNormalized = total == 0 ? 0 : winPerH / total;
    final drawerPerNormalized = total == 0 ? 0 : drawerPer / total;
    final winPerANormalized = total == 0 ? 0 : winPerA / total;

    return Column(
      children: [
        Stack(
          children: [
            // Full bar background
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
            ),
            // Home team percentage bar
            Positioned(
              left: 0,
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width * winPerANormalized,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: winPerH == winPerA
                      ? Theme.of(context).primaryColor
                      : winPerH < winPerA
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
            // Draw percentage bar
            Positioned(
              left: MediaQuery.of(context).size.width * winPerANormalized,
              right: MediaQuery.of(context).size.width * winPerHNormalized,
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width * drawerPerNormalized,
                color: Colors.grey,
              ),
            ),
            // Away team percentage bar
            Positioned(
              right: 0,
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width * winPerHNormalized,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: winPerH == winPerA
                      ? Theme.of(context).primaryColor
                      : winPerA < winPerH
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Home percentage
              Text(
                "${(winPerHNormalized * 100).toStringAsFixed(1)}%",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              // Draw percentage
              Text(
                "${(drawerPerNormalized * 100).toStringAsFixed(1)}%",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              // Away percentage
              Text(
                "${(winPerANormalized * 100).toStringAsFixed(1)}%",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        )
      ],
    );
  }
}
