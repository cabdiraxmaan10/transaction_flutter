import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? spendingAmount;
  final double? spendingPrecentage;
  ChartBar({this.label, this.spendingAmount, this.spendingPrecentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${spendingAmount!.toStringAsFixed(0)}"),
        Container(
          width: 10,
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.1),
                    color: Color.fromARGB(255, 210, 173, 173),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPrecentage,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
        ),
        Text(label.toString())
      ],
    );
  }
}
