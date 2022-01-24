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
      body: Column(
        children: [
          TopCard(
            balance: 'R\$5,000',
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text('Transitions'),
              ),
            ),
          ),
          Container(
            height: 25,
            child: Center(
              child: Text('Button'),
            ),
          ),
        ],
      ),
    );
  }
}
