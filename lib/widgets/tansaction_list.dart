import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
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
              shrinkWrap: true,
              itemBuilder: (buildContext, index) {
                return Card(
                  color: Colors.grey.shade50,
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8, 
                    horizontal: 5
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text("\$${transactions[index].amount}")
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(DateFormat("dd/MM/yyyy").format(transactions[index].date)),
                    trailing: IconButton(
                      onPressed: () {
                        return deleteTransaction(transactions[index].id);
                      }, 
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
          );
  }
}