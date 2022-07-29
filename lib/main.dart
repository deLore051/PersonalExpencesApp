import 'dart:math';

import 'package:flutter/material.dart';
import './widgets/new_transactions.dart';
import './widgets/tansaction_list.dart';
import './models/transaction.dart';

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
        primarySwatch: Colors.purple,
        fontFamily: "Quicksand",
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleSmall: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )
        ) 
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  // Shows pop up form for adding a new transaction
  void _showAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx, 
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expences"),
        actions: <Widget>[
          IconButton( 
            icon: Icon(Icons.add),
            onPressed: () => _showAddNewTransaction(context),
          )
        ],
      ),
      /* SingleChildScrollView makes our element srollable, in our
        case we had to add it on the body level so it takes the
        whole area that body takes as scrollable. It wouldnt work
        if we added it only at UserTransactions(), Column ... level
        because it wouldnt be able to identify the container height
        in which it should scroll.
          But there is an option to add the scroll view only to our
        list. To do so we would need to wrap the Column in a Container
        and clearly define the Containers heigt and after that we would
        add SingleChildScrollView at the child level of the Container to
        make it scrollable, but we will stil get the error view on the
        simulator when our keyboard pops up because the view bellow it
        will not where to move. */
      body: SingleChildScrollView(
        child: Column(
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
              TransactionList(_userTransactions),
            ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddNewTransaction(context),
      ),
    );
  }
}

