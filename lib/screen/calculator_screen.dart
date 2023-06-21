
import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ChangeNotifier {
  final List<String> _buttonList = [
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
  ];
  String resultValue = "";
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: deviceSize!.height * 0.3,
            child: AutoSizeText(
              resultValue,
            ),
          ),
          SizedBox(
            height: deviceSize!.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonWidget(
                _buttonList[0],
                () {},
              ),
              ButtonWidget(
                _buttonList[1],
                () {},
              ),
              ButtonWidget(
                _buttonList[2],
                () {},
              ),
              ButtonWidget(
                _buttonList[3],
                () {},
                buttonBGColor: Colors.purpleAccent,
              ),
            ],
          ),
          SizedBox(
            height: deviceSize!.height * 0.01,
          ),
          
        ],
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
    return InkWell(
      onTap: callBackFunc,
      child: SizedBox(
        width: deviceSize!.width * 0.25,
        height: deviceSize!.height * 0.1,
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
                18.0,
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
