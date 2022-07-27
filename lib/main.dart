import 'package:flutter/material.dart';
import './widgets/new_transactions.dart';
import './widgets/tansaction_list.dart';
import './widgets/user_transactions.dart';

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

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("FlutterApp"),
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
              UserTransactions(),
            ],
        ),
      ),
    );
  }
}

