import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/provider/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_screen.dart';

class CalculatorHistory extends StatefulWidget {
  const CalculatorHistory({super.key});

  @override
  State<CalculatorHistory> createState() => _CalculatorHistoryState();
}

class _CalculatorHistoryState extends State<CalculatorHistory> {
  @override
  Widget build(BuildContext context) {
    final resultList =
        Provider.of<HistoryProvider>(context, listen: false).getDataHistory;
    return Scaffold(
      body: Consumer<HistoryProvider>(
        builder: (_, resultHistoryList, child) {
          return Center(
            child: ListView.builder(
              itemBuilder: (context, index) => AutoSizeText(
                resultList[index],
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
          );
        },
      ),
    );
  }
}
