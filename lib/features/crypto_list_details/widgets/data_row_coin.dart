import 'package:flutter/material.dart';

class DataRowCoin extends StatelessWidget {
  const DataRowCoin({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 140,
          child: Text(title),
        ),
        const SizedBox(
          width: 32,
        ),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}
