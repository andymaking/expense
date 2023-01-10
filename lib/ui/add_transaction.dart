// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
DateTime? selectedDate;

class _AddTransactionState extends State<AddTransaction> {

  @override
  void dispose() {
    selectedDate = null;
    super.dispose();
  }

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
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: selectedDate==null?"Select A Date":DateFormat.yMMMd().format(selectedDate!),
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
                readOnly: true,
                onTap: (){
                  showCupertinoModalBottomSheet<Widget>(
                      context: context,
                      bounce: true,
                      expand: false,
                      builder: (BuildContext context) => DatePicks()).whenComplete(() {
                        setState(() {

                        });
                  });
                },
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
                        date: selectedDate ?? DateTime.now());
                    titleController.clear();
                    amountController.clear();
                    selectedDate = null;
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

  void picDate(){
      CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        use24hFormat: true,
        // This is called when the user changes the date.
        onDateTimeChanged: (DateTime newDate) {
          setState(() => selectedDate = newDate);
        },
      );
  }

}


class DatePicks extends StatefulWidget {
  const DatePicks({Key? key}) : super(key: key);

  @override
  State<DatePicks> createState() => _DatePicksState();
}

class _DatePicksState extends State<DatePicks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Material(
        child:  CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          maximumDate: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          use24hFormat: true,
          // This is called when the user changes the date.
          onDateTimeChanged: (DateTime newDate) {
            setState(() {
              selectedDate = newDate;
            });
          },
        ),
      ),
    );
  }
}
