import 'package:flutter/material.dart';


class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTx;
  NewTransaction(this.addTx,{super.key});

    // Hide the keyboard


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
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
              ),
              OutlinedButton(
                style: TextButton.styleFrom(foregroundColor: Colors.purple),
                onPressed: () {
                  addTx(titleController.text,
                  double.parse(amountController.text));
                },
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ));
  }
}
