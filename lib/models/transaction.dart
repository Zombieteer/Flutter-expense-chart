import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String title;
  final double amt;
  final DateTime date;

  Transaction({
    @required this.amt,
    @required this.date,
    @required this.id,
    @required this.title,
  });
}
