import 'dart:async';

import 'package:expense_flutter_app/repository/google_sheets_api.dart';
import 'package:expense_flutter_app/widgets/loading_circle.dart';
import 'package:expense_flutter_app/widgets/my_transactions.dart';
import 'package:expense_flutter_app/widgets/plus_button.dart';
import 'package:expense_flutter_app/widgets/top_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Color(0xFFC4C3C3),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TopCard(
              balance: '5,000',
              income: '500',
              expense: '300',
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GoogleSheetsApi.loading == true
                            ? LoadingCircle()
                            : ListView.builder(
                                itemCount:
                                    GoogleSheetsApi.currentTransactions.length,
                                itemBuilder: (context, index) {
                                  return MyTransactions(
                                    transactionName: GoogleSheetsApi
                                        .currentTransactions[index][0],
                                    money: GoogleSheetsApi
                                        .currentTransactions[index][1],
                                    expenseOrIcome: GoogleSheetsApi
                                        .currentTransactions[index][2],
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PlusButton(),
          ],
        ),
      ),
    );
  }
}
