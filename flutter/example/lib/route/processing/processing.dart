import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spren_flutter_example/route/processing/progress_bar.dart';
import 'package:spren_flutter_example/route/processing/progress_text_helper.dart';
import 'package:spren_flutter_example/route/result/result.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';
import 'package:spren_flutter_example/widgets/close_button.dart';
import 'package:spren_flutter_example/widgets/powered_by.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RouteProcessing extends HookWidget {
  String readingData;

  RouteProcessing(this.readingData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = useState(30);
    String SPREN_API_URL = dotenv.env['SPREN_API_URL']!;
    String X_API_KEY = dotenv.env['X_API_KEY']!;
    Map<String, String>? headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-API-KEY': X_API_KEY,
    };

    Future<http.Response> post() {
      return http.post(
        Uri.parse(SPREN_API_URL + '/submit/sdkData'),
        headers: headers,
        body: jsonEncode(<String, String>{
          'user': 'd159d47f-7441-44fa-af41-50d7496b201c',
          'readingData': readingData
        }),
      );
    }

    Future<http.Response> get(String guid) {
      return http.get(
        Uri.parse(SPREN_API_URL + '/results/' + guid),
        headers: headers,
      );
    }

    void errorNavigate() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => RouteResult(true, 0, 0))
      );
    }

    void successNavigate(double hr, double hrvScore) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RouteResult(false, hr, hrvScore)),
      );
    }

    Future<void> process(String guid) async {
      try {
        http.Response response = await get(guid);
        Map decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        String status = decodedResponse['biomarkers']['hr']['status'];
        if (status == 'complete') {
          progress.value = 100;
          await Future.delayed(const Duration(seconds: 1));
          double hr = decodedResponse['biomarkers']['hr']['value'];
          double hrvScore = decodedResponse['biomarkers']['hrvScore']['value'];
          successNavigate(hr, hrvScore);
        } else if (status == 'pending') {
          progress.value = min(80, progress.value + 15);
          await Future.delayed(const Duration(seconds: 2));
          process(guid);
        } else if (status == 'error') {
          throw 'biomarkers hr status error';
        } else {
          throw 'biomarkers hr status no reponse';
        }
      } catch (e) {
        print(e);
        errorNavigate();
      }
    }

    Future<void> onInit() async {
      try {
        http.Response response = await post();
        Map decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        progress.value = 60;
        String? guid = decodedResponse['guid'];
        if (guid == null) {
          throw 'Guid is null';
        }
        process(guid);
      } catch (e) {
        print(e);
        errorNavigate();
      }
    }

    useEffect(() {
      Wakelock.enable();
      onInit();
      return () {
        Wakelock.disable();
      };
    }, []);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
                alignment: Alignment.centerRight,
                child: CloseBtn(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                    })),
            Column(children: [
              const SizedBox(height: 15),
              Text(
                'Calculating your results',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff1A233D),
                    fontSize: AdaptiveTextSize.instance
                        .getadaptiveTextSize(context, 16)),
              ),
              Text(getProcessingProgressText(progress.value),
                  style: TextStyle(
                      color: const Color(0xff1A233D),
                      fontSize: AdaptiveTextSize.instance
                          .getadaptiveTextSize(context, 10)))
            ])
          ]),
          ProgressBar(progress: progress.value.toDouble()),
          const PoweredBy()
        ],
      ),
    ));
  }
}
