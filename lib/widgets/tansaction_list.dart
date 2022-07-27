import 'package:expences_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

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

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            child: Column(
              children: _userTransactions.map((tx) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          vertical: 10, 
                          horizontal: 15
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                            style: BorderStyle.solid
                          ),
                        ),
                        child: Text(
                          "\$${tx.amount}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat("dd/MM/yyyy").format(tx.date),
                            style: TextStyle(
                              color: Colors.black54
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                );
              }).toList(),
            ),
          );
  }
}