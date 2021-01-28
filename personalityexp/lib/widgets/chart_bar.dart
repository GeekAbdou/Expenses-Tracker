import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder (builder: (ctx,constrains) {
      return Column(
        children: <Widget>[
          Column(
            children: [
              Container(
                height : constrains.maxHeight *.15,
                child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: constrains.maxHeight *.07,
          ),
          Container(
            height: constrains.maxHeight *.55,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constrains.maxHeight *.1,
          ),
          Container(
            height: constrains.maxHeight *.1,
            child: FittedBox(
                child: Text(label)
            ),
          ),
        ],
      );
    },);
  }
}
