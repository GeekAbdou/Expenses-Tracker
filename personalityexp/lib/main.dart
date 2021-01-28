import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  // ignore: deprecated_member_use
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
bool showchart = false ;
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
}
  @override
  Widget build(BuildContext context) {
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text(
       'Personal Expenses',
      ),
      actions: <Widget>[
       IconButton(
         icon: Icon(Icons.add),
    onPressed: () => _startAddNewTransaction(context),
        ),
        ],
    );
    final mediaQuery = MediaQuery.of(context);
    final chartWidget = Container(
        height: (mediaQuery.size.height - appbar.preferredSize.height - mediaQuery.padding.top) *.3,
        child: Chart(_recentTransactions)
    );
    final chartWidgetLandscape = Container(
        height: (mediaQuery.size.height - appbar.preferredSize.height - mediaQuery.padding.top),
        child: Chart(_recentTransactions)
    );
    final txWidget = Container(
        height: (mediaQuery.size.height - appbar.preferredSize.height - mediaQuery.padding.top) *.7,
        child: TransactionList(_userTransactions,deleteTransaction)
    );
    final txWidgetLandscape = Container(
        height: (mediaQuery.size.height - appbar.preferredSize.height - mediaQuery.padding.top),
        child: TransactionList(_userTransactions,deleteTransaction)
    );
    final LandscapeSwichBtn = Row (
      children: [
        Text ('Show Chart'),
        Switch(
          value: showchart ,
          onChanged: (val){
            setState(() {
              showchart = val;
            });
          },
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            if(isLandscape ) LandscapeSwichBtn,
            if (showchart && isLandscape ) chartWidgetLandscape,
            if (!showchart && isLandscape ) txWidgetLandscape,
            if(!isLandscape) chartWidget,
            if(!isLandscape) txWidget,
          ],

        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
