// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/transaction.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

Transaction? transaction;

final titleController = TextEditingController();
final amountController = TextEditingController();

String amount="";

class _AddTransactionState extends State<AddTransaction> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () {
          titleController.clear();
          amountController.clear();
          Navigator.of(context).pop(transaction);
        },),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "title",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    contentPadding: EdgeInsets.only(
                        top: 15, bottom: 15, right: 0, left: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                keyboardType: TextInputType.name,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: amountController,
                decoration: InputDecoration(
                  hintText: "Amount",
                  hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding:
                  EdgeInsets.only(top: 15, bottom: 15, right: 0, left: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10)),
                child: const Text("Add Transaction",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  if(titleController.text.isEmpty){

                  }else if(amountController.text.isEmpty){

                  }else{
                    transaction = Transaction(
                        id: "${DateTime.now()}",
                        title: titleController.text,
                        amount: double.parse(amountController.text),
                        date: DateTime.now());
                    titleController.clear();
                    amountController.clear();
                    Navigator.of(context).pop(transaction);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
