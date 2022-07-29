import 'package:flutter/material.dart';


class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    /* Widget method is a special property that gives us access to the class of our widget
      and its methods and properties */
    widget.addTransaction(enteredTitle, enteredAmount);
    
    /* Used to close the pop-up form after we add the transaction. Context property is also
      a special property that gives us access to the content related to our widget. */
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Title"
                    ),
                    controller: titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Amount"
                    ),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    /* The on submitted takes a Function with a string value as a paameter so
                      we eather have to add a String parameter in submitData or in our case
                      make an annonymous function and put an _ as a parameter because we wont
                      use this parameter someware else, so we dont care how its called. */
                    onSubmitted: (_) => submitData(),
                  ),
                  TextButton(
                    child: Text("Add Transaction"),
                    onPressed: submitData, 
                  ),
                ],
              ),
            ),
          );
  }
}