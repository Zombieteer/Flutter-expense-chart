import 'package:flutter/material.dart';
import 'package:Expenserati/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child:
                      Text('\₹ ${transaction[index].amt.toStringAsFixed(2)}'),
                ),
              ),
            ),
            title: Text(
              transaction[index].title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transaction[index].date),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () => deleteTx(transaction[index].id),
            ),
          ),
        );

        // return Card(
        //   child: Row(
        //     children: <Widget>[
        //       Container(
        //         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: Theme.of(context).primaryColor,
        //           ),
        //         ),
        //         padding: EdgeInsets.all(10),
        //         child: Text(
        //           '\₹ ${transaction[index].amt.toStringAsFixed(2)}',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             color: Theme.of(context).primaryColor,
        //           ),
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(
        //             transaction[index].title,
        //             style: Theme.of(context).textTheme.headline6,
        //           ),
        //           Text(
        //             DateFormat.yMMMd().format(transaction[index].date),
        //             style: TextStyle(
        //               color: Colors.grey,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // );
      },
      itemCount: transaction.length,
    );
  }
}
