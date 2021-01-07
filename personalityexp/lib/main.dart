import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return(MaterialApp(
      title: 'PersExp',
      home: HomePage(),
    ));
  }
}

class HomePage extends StatelessWidget{
  final List<Transcation> transcations =[
    Transcation(
        id:'t1' ,
        title: 'books',
        amount: 52.2,
        date: DateTime.now(),
    ),
    Transcation(
      id:'t2' ,
      title: 'shopping',
      amount: 78.24,
     date: DateTime.now(),
      ),
  ];

  String titleInput;
  String amountInput;

  @override
  Widget build(BuildContext context) {
    return(Scaffold(
      appBar: AppBar(
        title: Text('Personality Expensis'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
        [
           Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child : Column(
                crossAxisAlignment : CrossAxisAlignment.end,
                children: [
                  TextField(
                    onChanged : (val){
                      titleInput = val;
                      },
                    decoration: InputDecoration(
                        labelText: 'Title',
                    ),
                  ),
                  TextField(
                    onChanged : (val){
                      amountInput = val;
                    },
                    decoration: InputDecoration(
                        labelText: 'Amount'),
                  ),
                  FlatButton(child:
                    Text('Add Transaction'),
                    onPressed: (){},
                    color: Colors.purple,
                  ),
                ],
              ),
            ),

          ),
          Column(
            children: transcations.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin : EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '\$' + tx.amount.toString(),
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
                            fontWeight: FontWeight.bold,
                            fontSize: 18 ,
                          ),
                        ),
                        Text(
                            DateFormat.yMMMd().format(tx.date),
                            style:
                            TextStyle(
                              color: Colors.grey,
                            ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ]
      ),
      )
    );
  }
}
