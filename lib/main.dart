import 'package:flutter/material.dart';
import '../widgets/charts.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './model/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _usertransactioin = [
    // Transaction(
    //     id: DateTime.now().toString(),
    //     title: 'shoes',
    //     amount: 2000.34,
    //     dateTime: DateTime.now())
  ];
  List<Transaction> get _recentTransaction {
    return _usertransactioin.where((tx) {
      return tx.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime date) {
    final addNew = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        dateTime: date);
    setState(() {
      _usertransactioin.add(addNew);
    });

    Navigator.pop(context);
  }

  void startAddingNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (btnx) {
          return NewTransaction(addTransactionData: addNewTransaction);
        });
  }

  void delete(String id) {
    setState(() {
      _usertransactioin.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddingNewTransaction(context),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Transaction App',
        ),
        actions: [
          IconButton(
              onPressed: () => startAddingNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Chart(recentTransaction: _recentTransaction),
          TransactionLlist(
            transactionList: _usertransactioin,
            deleteTransaction: delete,
          ),
        ]),
      ),
    );
  }
}
