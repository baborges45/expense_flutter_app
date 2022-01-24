import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  final String balance;
  const TopCard({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        color: Color(0xFFEEEEEE),
        child: Center(
          child: Column(
            children: [
              Text(
                'B A L A N C E',
                style: TextStyle(
                  color: Color(0xFF838383),
                  fontSize: 16,
                ),
              ),
              Text(
                balance,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
