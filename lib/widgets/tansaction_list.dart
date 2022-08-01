import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            height: 300,
            /* There are two types of ListView(children: []), one where we pass the
              lists children as an argument, and a ListView.builder(). The main difference
              between the two is that ListView(children: []) renders all the children of
              the list even those that are invisible at the moment, but the ListView.builder()
              renders only the children we can see on the screen and maybe a few more for
              buffering purposes which is of great help when we are working with large
              lists or lists for which we dont know the number of elements. */
            child: transactions.isEmpty ? Column(
              children: [
                Text(
                  "No transactions added yet!!!",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                  ),
                ),
              ],
            ) : ListView.builder(
              itemBuilder: (buildContext, index) {
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
                            color: Theme.of(context).primaryColor,
                            width: 2,
                            style: BorderStyle.solid
                          ),
                        ),
                        child: Text(
                          "\$${transactions[index].amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            DateFormat("dd/MM/yyyy").format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.black54
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                );
              },
              itemCount: transactions.length,
            ),
          );
  }
}