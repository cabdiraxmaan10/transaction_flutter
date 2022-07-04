import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionLlist extends StatelessWidget {
  List<Transaction>? transactionList;
  final Function? deleteTransaction;
  TransactionLlist(
      {required this.transactionList, required this.deleteTransaction});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactionList!.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Transaction  is empty',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  'assets/images/delete.png',
                  fit: BoxFit.cover,
                )
              ],
            )
          : ListView.builder(
              itemCount: transactionList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              margin: EdgeInsets.all(
                                10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.purple,
                                  )),
                              child: FittedBox(
                                child: Text(
                                  "\$ ${transactionList![index].amount}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionList![index].title.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  DateFormat.yMEd().format(
                                      transactionList![index].dateTime!),
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () =>
                                deleteTransaction!(transactionList![index].id),
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                              color: Theme.of(context).errorColor,
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
