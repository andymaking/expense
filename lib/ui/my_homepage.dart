// ignore_for_file: prefer_const_constructors

import 'package:expense/widgets/transaction_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../data/transaction_data.dart';
import '../models/transaction.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              child: Container(
                width: double.maxFinite,
                color: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                alignment: Alignment.center,
                child: const Text(
                  'CARD',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
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
                        return ListDetailTransaction(tx: tx,);
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




