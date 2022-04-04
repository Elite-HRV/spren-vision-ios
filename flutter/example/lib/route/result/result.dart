import 'package:flutter/material.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';
import 'package:spren_flutter_example/widgets/powered_by.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RouteResult extends HookWidget {
  bool error;
  double hr;
  double hrvScore;

  RouteResult(this.error, this.hr, this.hrvScore, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return () {};
    }, []);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 100, 16, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Text(
              error ? 'Sorry...' : 'Congrats!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: AdaptiveTextSize.instance
                      .getadaptiveTextSize(context, 16)),
            ),
            Text(
                error
                    ? "We couldn't process the results for this reading, please try again."
                    : "You just completed your heart rate variability (HRV) reading",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: AdaptiveTextSize.instance
                        .getadaptiveTextSize(context, 10)))
          ]),
          error
              ? const Spacer()
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      Text(hrvScore.round().toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff1A233D),
                              fontSize: AdaptiveTextSize.instance
                                  .getadaptiveTextSize(context, 25))),
                      Text(
                        'HRV Score',
                        style: TextStyle(
                            color: const Color(0xff1A233D),
                            fontSize: AdaptiveTextSize.instance
                                .getadaptiveTextSize(context, 12)),
                      )
                    ],
                  ),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      Text(hr.round().toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff1A233D),
                              fontSize: AdaptiveTextSize.instance
                                  .getadaptiveTextSize(context, 25))),
                      Text(
                        'Heart Rate',
                        style: TextStyle(
                            color: const Color(0xff1A233D),
                            fontSize: AdaptiveTextSize.instance
                                .getadaptiveTextSize(context, 12)),
                      )
                    ],
                  ),
                ]),
          Padding(
              padding: const EdgeInsets.only(bottom: 50,),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  padding: const EdgeInsets.all(15),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveTextSize.instance
                          .getadaptiveTextSize(context, 13)),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                },
                child: const Text('Restart'),
              )),
          const PoweredBy()
        ],
      ),
    ));
  }
}
