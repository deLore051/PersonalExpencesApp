import 'package:expences_app/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final List<Transaction> transactions = [
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
    return Scaffold(
      appBar: AppBar(
      title: Text("FlutterApp"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 50,
            child: Card(
              child: Text("Chart"),
              elevation: 5,
              color: Colors.blue
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              children: transactions.map((tx) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          tx.amount.toString()
                          ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(tx.title),
                          Text(tx.date.toString()),
                        ],
                      )
                    ],
                  )
                );
              
              }).toList(),
            ),
          ),
        ],
      )
    );
  }

}

