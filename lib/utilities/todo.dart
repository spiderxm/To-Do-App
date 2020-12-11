import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/screens/Todo-detail.dart';
import 'package:todo/screens/edit.dart';

class TodoCard extends StatefulWidget {
  String title;
  String id;
  bool status = false;
  String description;
  DateTime dateTime;
  String time;

  TodoCard(this.title, this.id, this.status, this.description, this.dateTime,
      this.time);

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
            color: widget.status ? Color(0xffBCED91) : Color(0xfff3bcb5),
            padding: EdgeInsets.all(10),
            child: ListTile(
              tileColor: widget.status ? Color(0xffBCED91) : Color(0xfff3bcb5),
              title: Text(widget.title),
              subtitle: Text(widget.dateTime.toString().substring(0, 10), style: TextStyle(color: Colors.black54, fontSize: 14),),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ToDoDetail(
                            widget.id,
                            widget.title,
                            widget.description,
                            widget.dateTime,
                            widget.time,
                            widget.status)));
                  });
                },
                icon: Icon(Icons.info_outlined, size: 30,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
