// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  //converted to stateful widget to remove a bug where as soon as the user
//types into input field and unfocus, the data gets lost

  final Function addTx;
  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    // ignore: no_leading_underscores_for_local_identifiers
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount,
        _selectedDate); //enables us to access the property which is in different class NewTransaction
    Navigator.of(context).pop(); //closes modal upon submission
  }
void _datePicker() {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(2022),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (dateTime) {
              setState(() {
                _selectedDate = dateTime;
              });
            },
          ),
        );
      },
    );
  } else {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  onSubmitted: (_) => submitData(),
                ),
                SizedBox(
                  height: 70,
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                    AdaptiveFlatButton('Choose Date', _datePicker)

                  ]),
                ),
                OutlinedButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.purple),
                  onPressed: () {
                    submitData();
                  },
                  child: const Text('Add Transaction'),
                ),
              ],
            ),
          )),
    );
  }
}
