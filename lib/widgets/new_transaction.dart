import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function? addTransactionData;
  NewTransaction({required this.addTransactionData});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();
  var dateChoosen;
  void chooseDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        dateChoosen = value;
        ;
      });
    });
  }

  void summitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    if (title.isEmpty || amount < 0 || dateChoosen == null) {
      return;
    }

    widget.addTransactionData!(title, amount, dateChoosen);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              onSubmitted: (_) => summitData(),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (_) => summitData(),
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            Row(
              children: [
                Text(dateChoosen == null
                    ? 'No Date Chosen'
                    : DateFormat.yMd().format(dateChoosen)),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: chooseDate,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(color: Colors.purple, fontSize: 18),
                    ))
              ],
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.purple,
                padding: EdgeInsets.all(10),
                onPressed: summitData,
                child: Text(
                  'Add Transaction ',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
