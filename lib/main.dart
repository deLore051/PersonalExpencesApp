import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import './widgets/new_transactions.dart';
import './widgets/tansaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  /* If we want to only enable portrait mode for our app we will use the following code:
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
      DeviceOrientation.protraitUp,
      DeviceOrientation.portraitDown,
    ) */
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
          ),
        ), 
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
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    /* .where() method is used to run a function on every item in a list and if that function
      returnes true that item is kept in a newly returned list otherwise its not included in the
      newly returned list.  */
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
    
  }

  /* We put underscore in front of the methods, functions or parameters
    name so that we mark it as private. */
  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
      id: Random().nextInt(1000).toString(), 
      title: txTitle, 
      amount: txAmount, 
      date: chosenDate,
    );

    /* We call a setState function to refresh the user interface and
      we can do it here because we are working with statefull widget. */ 
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  // Shows pop up form for adding a new transaction
  void _showAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true, 
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Personal Expences"),
      actions: <Widget>[
        IconButton( 
          icon: Icon(Icons.add),
          onPressed: () => _showAddNewTransaction(context),
        )
      ],
    );
    final transactionListWidget = Container(
      height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction)
    );
    return Scaffold(
      appBar: appBar,
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
            children: <Widget>[
              if(isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                    value: _showChart, 
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
              /* To dynamically calculate the height of our elements, the chart and transaction list we need
                to get the height of the screen for the device with MediaQuery.of(context).size.height, after
                that we need to subract the height of the appBar (which we get with appBar.preferedSize.height)
                and the height of the status bar on top of the screen which is set automatically so our app
                doesnt cover the status bar (we get it with MediaQuery.of(context).padding.top) the result of
                that we multiply with a value from 0 to 1 ( 1 representing the full height of the screen) to
                get the desired height we want to allocate to the widgets shown on screen. */
              if(!isLandscape) Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) * 0.3,
                    child: Chart(_recentTransactions)
                  ),
              if(!isLandscape) transactionListWidget,
              if(isLandscape) _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) * 0.6,
                    child: Chart(_recentTransactions)
                  )
                : transactionListWidget
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
