import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit.dart';

class ToDoDetail extends StatefulWidget {
  String id;
  String title;
  String description;
  DateTime dateTime;
  String time;
  bool status;

  ToDoDetail(this.id, this.title, this.description, this.dateTime, this.time,
      this.status);

  @override
  _ToDoDetailState createState() => _ToDoDetailState();
}

class _ToDoDetailState extends State<ToDoDetail> {
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final titleController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void initState() {
    timeController.text = widget.time.substring(10, 15);
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    dateTimeController.text = widget.dateTime.toString().substring(0, 10);
    statusController.text = widget.status ? "Complete" : "Incomplete";
  }

  @override
  Widget build(BuildContext context) {
    void delete() {
      Firestore.instance.collection('todos').doc(widget.id).delete();
      Navigator.of(context).pop();
    }

    void changeStatus() {
      Firestore.instance
          .collection('todos')
          .doc(widget.id)
          .update({"status": !widget.status});
      widget.status = !widget.status;
      statusController.text = widget.status ? "Complete" : "Incomplete";
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  child: Center(
                      child: Text(
                    "Details",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Title',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: TextFormField(
                    readOnly: true,
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    textInputAction: TextInputAction.next,
                    validator: (input) {
                      if (input.length <= 3) {
                        return "Title should have length greater than 3.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      prefixIcon: Icon(
                        Icons.topic,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Description',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: TextFormField(
                    readOnly: true,
                    minLines: 1,
                    //Normal textInputField will be displayed
                    maxLines: 5,
                    enableSuggestions: true,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      prefixIcon: Icon(
                        Icons.description,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      hintText: "Description",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Date',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: TextFormField(
                    readOnly: true,
                    //Normal textInputField will be displayed
                    enableSuggestions: true,
                    controller: dateTimeController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      hintText: "Date",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Time',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: TextFormField(
                    readOnly: true,
                    //Normal textInputField will be displayed
                    enableSuggestions: true,
                    controller: timeController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      hintText: "Time",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Status',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: TextFormField(
                    readOnly: true,
                    //Normal textInputField will be displayed
                    enableSuggestions: true,
                    controller: statusController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(width: 2, color: Colors.grey[200]),
                      ),
                      prefixIcon: Icon(
                        statusController.text != "Complete"
                            ? Icons.star_border
                            : Icons.star_purple500_sharp,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      hintText: "Status",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => UpdateToDo(
                                          widget.id,
                                          widget.title,
                                          widget.description,
                                          widget.dateTime)));
                              Navigator.of(context).pop();
                            }),
                      ),
                      CircleAvatar(
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              delete();
                            }),
                      ),
                      CircleAvatar(
                        child: widget.status
                            ? Icon(Icons.done)
                            : Icon(Icons.cancel),
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
