import 'package:Expenserati/widgets/chart.dart';
import 'package:Expenserati/widgets/new_transaction.dart';
// import 'package:Expenserati/widgets/user_transaction.dart';
import 'package:flutter/material.dart';
import 'package:Expenserati/widgets/transaction_list.dart';

import 'package:Expenserati/models/transaction.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // letterSpacing: 0.5
              ),
              button: TextStyle(color: Colors.white70)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                  ),
                ),
          ),
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(
        id: 't1', title: 'new shoes', amt: 2500.00, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'groceries', amt: 3000.00, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmt, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amt: txAmt,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        _userTransaction,
        _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: _userTransaction.length != 0
            ? Column(
                children: <Widget>[
                  if (isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Show Chart'),
                        Switch(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          },
                        )
                      ],
                    ),
                  if (!isLandscape)
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.3,
                      child: Chart(
                        _recentTransaction,
                      ),
                    ),
                  if (!isLandscape) txListWidget,
                  if (isLandscape)
                    _showChart
                        ? Container(
                            height: (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.3,
                            child: Chart(
                              _recentTransaction,
                            ),
                          )
                        : txListWidget
                ],
              )
            : Container(
                width: double.infinity,
                child: Text(
                  'Add Transaction',
                  textAlign: TextAlign.center,
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
