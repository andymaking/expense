// ignore_for_file: prefer_const_constructors

import 'package:expense/widgets/transaction_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../data/transaction_data.dart';
import '../models/transaction.dart';
import '../widgets/chart.dart';
import '../widgets/no_transaction.dart';
import 'add_transaction.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          automaticallyImplyLeading: false,
        ),
        child: BodyHome(size: size));
  }
}

class BodyHome extends StatefulWidget {
  const BodyHome({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return  tx.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Chart(recentTransaction: _recentTransactions,),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: transactions.isEmpty?const NoTransaction():ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (_,index){
                        final tx = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: FittedBox(
                                child: Text(
                                  '\$${tx.amount}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.purple),
                                ),
                              ),
                            ),
                            title: Text(
                              tx.title.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(DateFormat.yMMMd().format(tx.date!)),
                            trailing: IconButton(
                              onPressed: ()async{
                                showCupertinoModalBottomSheet<Widget>(
                                    context: context,
                                    bounce: true,
                                    expand: false,
                                    builder: (BuildContext context) => DeleteModal(confirm: (){
                                      Navigator.of(context).pop();
                                      transactions.removeAt(index);
                                    },)).whenComplete((){
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.delete, color: Colors.red,),
                            ),
                            ),
                        )
                          // ListDetailTransaction(tx: tx,)
                        ;
                      }
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: widget.size.width,
                    child: OutlinedButton(
                        onPressed: () async {
                          Transaction? trans = await showCupertinoModalBottomSheet(
                            expand: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>AddTransaction(),
                          );
                          if(trans==null){
                            print("-----$trans");
                          }else{
                            setState(() {
                              transactions.add(trans);
                            });
                          }
                        }, child: Text("Add transaction")
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteModal extends StatelessWidget {
  final VoidCallback confirm;
  const DeleteModal({Key? key, required this.confirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Material(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const  [
                  Text(
                    'Delete',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black),
                  ),
                  Text(
                    'Are you sure you want to delete',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
                child: InkWell(
                  onTap: confirm,
                  child: SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Center(
                      child:  Text(
                        'Confirm',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                )
            ),
            Divider(),
            Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child:  Center(
                      child: Text(
                        'Cancel',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red),
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}






