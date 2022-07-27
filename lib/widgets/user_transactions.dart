import 'dart:math';

import './new_transactions.dart';
import './tansaction_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';



class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1', 
      title: "New Shoes", 
      amount: 69.99, 
      date: DateTime.now()
    ),
    Transaction(
      id: 't2', 
      title: "Weekly Groceries", 
      amount: 16.53, 
      date: DateTime.now()
    ),
  ];

  /* We put underscore in front of the methods, functions or parameters
    name so that we mark it as private. */
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTransaction = Transaction(
      id: Random().nextInt(1000).toString(), 
      title: txTitle, 
      amount: txAmount, 
      date: DateTime.now()
    );

    /* We call a setState function to refresh the user interface and
      we can do it here because we are working with statefull widget. */ 
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /* To send just the pointer of a private function that is 
          in a private class we need to type just the name of the
          function without the parentheses. If wee add () at the
          end the function will execute every time its called. */
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}