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
  @override
  Widget build(BuildContext context) {
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
                      MyTransactions(
                        transactionName: 'Teaching',
                        money: '300',
                        expenseOrIcome: 'icome',
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
