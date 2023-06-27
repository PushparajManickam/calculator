import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/main.dart';
import 'package:calculator/provider/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

import 'history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ChangeNotifier {
  final Widget _commonSizedBox = SizedBox(
    height: deviceSize!.height * 0.05,
  );
  final List<String> _buttonList = [
    "C",
    "(",
    ")",
    "%",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "+/-",
    "0",
    ".",
    "=",
  ];
  
  ValueNotifier<String> _resultValueNotifier = ValueNotifier<String>("");
  //Math expression
  Parser _parse = Parser();
  ContextModel _contextModel = ContextModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalculatorHistory(),
                    ),
                  ),
                  icon: Icon(
                    Icons.history,
                  ),
                ),
              ],
            ),
            _commonSizedBox,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder(
                    valueListenable: _resultValueNotifier,
                    builder: (context, value, child) => AutoSizeText(
                      value,
                      textAlign: TextAlign.end,
                      style: MyStyle.myTextStyle(
                        Colors.black,
                        deviceSize!.width * 0.2,
                        FontWeight.w700,
                        1.0,
                        2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _commonSizedBox,
            Wrap(
              runSpacing: 6,
              children: _buttonList
                  .map(
                    (value) => ButtonWidget(
                      value,
                      () {
                        switch (value) {
                          case "C":
                            _resultValueNotifier.value = "";
                            break;
                          case "=":
                            String _queryQuestion = _resultValueNotifier.value;
                            Expression _expression =
                                _parse.parse(_resultValueNotifier.value);
                            _resultValueNotifier.value = (
                              _expression.evaluate(
                                EvaluationType.REAL,
                                _contextModel,
                              ),
                            ).toString();
                            List _tempList = [
                              _queryQuestion,
                              _resultValueNotifier.value,
                            ];
                            Provider.of<HistoryProvider>(context, listen: false).setDataHistory = _tempList;

                            break;
                          default:
                            _resultValueNotifier.value =
                                _resultValueNotifier.value + value;
                            break;
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
            _commonSizedBox,
          ],
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String? buttonName;

  final VoidCallback? callBackFunc;
  final Color? buttonBGColor;
  const ButtonWidget(
    this.buttonName,
    this.callBackFunc, {
    super.key,
    this.buttonBGColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceSize!.width * 0.25,
      height: deviceSize!.height * 0.1,
      child: InkWell(
        onTap: callBackFunc,
        child: CircleAvatar(
          backgroundColor: (buttonBGColor != null) ? buttonBGColor : null,
          child: Container(
            margin: const EdgeInsets.all(
              4,
            ),
            child: AutoSizeText(
              buttonName!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              minFontSize: 18,
              style: MyStyle.myTextStyle(
                Colors.black,
                24.0,
                FontWeight.w700,
                1.0,
                2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//Utils
class MyStyle {
  static TextStyle myTextStyle(
    Color fontColor,
    double fontSize,
    FontWeight fontWeight,
    double letterSpacing,
    double wordSpacing,
  ) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: fontColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,

      ///GlobalValue
      decorationStyle: TextDecorationStyle.dashed,
      locale: const Locale('EN'),
    );
  }
}
