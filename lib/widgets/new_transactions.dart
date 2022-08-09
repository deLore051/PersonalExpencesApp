import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if(_titleController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    /* Widget method is a special property that gives us access to the class of our widget
      and its methods and properties */
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
    
    /* Used to close the pop-up form after we add the transaction. Context property is also
      a special property that gives us access to the content related to our widget. */
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    /* showDatePicker is a widget that returns a Future. Futures are classes that allow us to create
      objects which will give us a value in the future ( for example we use a future for http requests
      where you need to wait for the response to come back from the server ). Here we wait for the
      user to pick a date (value) so showDatePicker immediately when we call it returnes a future
      but it cant immediately give us the date the user picked, because we just opened the picker we
      dont know when the user will pick a date and click OK, so we get back the future that will
      trigger once the user picks the date. Then() method allows us to trigger a function once the
      user chose the date.
        */
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2022), 
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
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
                    controller: _titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Amount"
                    ),
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    /* The on submitted takes a Function with a string value as a paameter so
                      we eather have to add a String parameter in submitData or in our case
                      make an annonymous function and put an _ as a parameter because we wont
                      use this parameter someware else, so we dont care how its called. */
                    onSubmitted: (_) => _submitData(),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                          _selectedDate == null 
                          ? "No date chosen!" 
                          : "Picked date: ${DateFormat("dd/MM/yyyy").format(_selectedDate!)}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: _presentDatePicker, 
                          child: Text(
                            "Chose date",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor
                      ),
                    ),
                    child: Text(
                      "Add Transaction",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _submitData, 
                  ),
                ],
              ),
            ),
          );
  }
}