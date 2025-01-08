
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StandingLabels extends StatelessWidget {
  const StandingLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 5.0, bottom: 15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child:  Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width *
                  0.42,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "المركز",
                    style: TextStyle(
                        fontFamily:
                        'Vazirmatn',
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width *
                  0.29,
              child: Padding(
                padding:
                const EdgeInsets.only(
                    left: 3, right: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "ل".tr,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                        child: Text(
                          "ف".tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    SizedBox(
                      width: 26,
                    ),
                    Expanded(
                        child: Text(
                          "ت".tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    SizedBox(
                      width: 22,
                    ),
                    Expanded(
                        child: Text(
                          "خ".tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width *
                  0.19,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "-/+",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "ن".tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
