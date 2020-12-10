import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/screens/edit.dart';

class TodoCard extends StatefulWidget {
  String title;
  String id;
  bool status = false;
  String description;
  DateTime dateTime;

  TodoCard(this.title, this.id, this.status, this.description, this.dateTime);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool expanded = false;

  void delete() {
    Firestore.instance.collection('todos').doc(widget.id).delete();
  }

  void update() {}

  void makeItDone() {
    try {
      Firestore.instance
          .collection('todos')
          .doc(widget.id)
          .update({"status": true});
      Fluttertoast.showToast(
          msg: "To-Do marked as done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "There was some error.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  void makeItUnDone() {
    try {
      Firestore.instance
          .collection('todos')
          .doc(widget.id)
          .update({"status": false});
      Fluttertoast.showToast(
          msg: "To-Do marked as undone",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "There was some error.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          Container(
            height: 60,
            child: ListTile(
              tileColor: widget.status ? Color(0xff80D475) : Color(0xfff3bcb5),
              title: Text(widget.title),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                icon: expanded
                    ? Icon(Icons.expand_less)
                    : Icon(Icons.expand_more),
              ),
            ),
          ),
          if (expanded)
            Container(
              color: widget.status ? Color(0xff80D475) : Color(0xfff3bcb5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => UpdateToDo(
                                widget.id,
                                widget.title,
                                widget.description,
                                widget.dateTime)));
                      }),
                  widget.status
                      ? IconButton(
                          icon: Icon(Icons.undo_outlined),
                          onPressed: () {
                            makeItUnDone();
                          })
                      : IconButton(
                          icon: Icon(Icons.done_outline),
                          onPressed: () {
                            makeItDone();
                          }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        delete();
                      })
                ],
              ),
            )
        ],
      ),
    );
  }
}
