import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit.dart';

class ToDoDetail extends StatelessWidget {
  String id;
  String title;
  String description;
  DateTime dateTime;
  String time;


  ToDoDetail(this.id, this.title, this.description, this.dateTime, this.time);

  @override
  Widget build(BuildContext context) {
    void delete() {
      Firestore.instance.collection('todos').doc(id).delete();
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffec9489),
        title: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text("Completed To-Do's"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => UpdateToDo(
                                      id, title, description, dateTime)));
                            }),
                      ),
                      CircleAvatar(
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              delete();
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
