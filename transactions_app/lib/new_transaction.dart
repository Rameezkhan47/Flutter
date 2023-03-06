import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget { //converted to stateful widget to remove a bug where as soon as the user 
//types into input field and unfocus, the data gets lost 

  final Function addTx;
  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0){
      return;
    }
    
    widget.addTx(enteredTitle, enteredAmount); //enables us to access the property which is in different class NewTransaction
    Navigator.of(context).pop(); //closes modal upon submission
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.only(bottom: 20),
        child: Container(
          padding: const EdgeInsets.all(10),
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
              OutlinedButton(
                style: TextButton.styleFrom(foregroundColor: Colors.purple),
                onPressed: () {
                  submitData();
                  
                },
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ));
  }
}
