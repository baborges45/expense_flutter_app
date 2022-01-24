import 'package:flutter/material.dart';

class MyTransactions extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenseOrIcome;

  const MyTransactions({
    Key? key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIcome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[500],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    transactionName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Text(
                (expenseOrIcome == 'expense' ? '-' : '+') + 'R\$' + money,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      (expenseOrIcome == 'expense' ? Colors.red : Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
