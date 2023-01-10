import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double spendingPctOfAmount;
  const ChartBar({Key? key, required this.label, required this.amount, required this.spendingPctOfAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            '\$${amount.toStringAsFixed(0)}',),
        ),
       const  SizedBox(height: 4,),
        Expanded(
          child: Container( width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
                FractionallySizedBox(heightFactor: spendingPctOfAmount,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
                )
              ],
            ),
          ),
        ),
        const  SizedBox(height: 4,),
        Text(
          label,),
      ],
    );
  }
}
