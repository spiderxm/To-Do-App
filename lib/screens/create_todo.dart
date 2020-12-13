import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateTodo extends StatefulWidget {
  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  bool load = false;
  String _title, _description, _priority;
  DateTime _dateTime;
  TimeOfDay _time;
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();
  final dateTimeController = TextEditingController();
  final timeController = TextEditingController();
  final priorityController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    timeController.dispose();
    dateTimeController.dispose();
    super.dispose();
  }

  void createToDo() async {
    setState(() {
      load = true;
    });
    bool valid = _formKey.currentState.validate();
    if (valid) {
      try {
        _formKey.currentState.save();
        var data = {
          "email": FirebaseAuth.instance.currentUser.email,
          "title": _title,
          "priority": _priority,
          "date": _dateTime,
          "description": _description,
          "status": false,
          "time": DateTime.now(),
          "time_of_completion": _time.toString()
        };
        print(data);
        await Firestore.instance.collection('todos').add(data);
        Fluttertoast.showToast(
            msg: "To Do Added SuccessFully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.of(context).pop();
      } catch (e) {
        Fluttertoast.showToast(
            msg: "There was some error try again later.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    }
    setState(() {
      load = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create To-Do"),
        backgroundColor: Color(0xffec9489),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34), topRight: Radius.circular(34)),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: TextFormField(
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
                        onSaved: (value) {
                          _title = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[200]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[200]),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: TextFormField(
                        minLines: 1,
                        //Normal textInputField will be displayed
                        maxLines: 5,
                        enableSuggestions: true,
                        keyboardType: TextInputType.multiline,
                        controller: descriptionController,
                        textInputAction: TextInputAction.done,
                        validator: (input) {
                          if (input.length <= 3) {
                            return "Description should have length greater than 3.";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[200]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[200]),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: TextFormField(
                        readOnly: true,
                        //Normal textInputField will be displayed
                        enableSuggestions: true,
                        controller: dateTimeController,
                        textInputAction: TextInputAction.done,
                        validator: (input) {
                          if (_dateTime == null) {
                            return "Please select a Date.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[200]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[200]),
                          ),
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime datetime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100));
                              _dateTime = datetime;
                              dateTimeController.text =
                                  _dateTime.toString().substring(0, 10);
                            },
                            icon: Icon(
                              Icons.date_range_outlined,
                              color: Colors.black,
                            ),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: TextFormField(
                        readOnly: true,
                        //Normal textInputField will be displayed
                        enableSuggestions: true,
                        controller: timeController,
                        textInputAction: TextInputAction.done,
                        validator: (input) {
                          if (_time == null) {
                            return "Please select Time.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[200]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[200]),
                          ),
                          prefixIcon: Icon(
                            Icons.access_time,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: TimeOfDay.now().hour, minute: 0),
                                builder: (BuildContext context, Widget child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child,
                                  );
                                },
                              );
                              print(time);
                              _time = time;
                              int l = _time.minute.toString().length;
                              if (l == 1) {
                                timeController.text = _time.hour.toString() +
                                    ":0" +
                                    _time.minute.toString();
                              } else {
                                timeController.text = _time.hour.toString() +
                                    ":" +
                                    _time.minute.toString();
                              }
                            },
                            icon: Icon(
                              Icons.timeline,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Time",
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
                      'Priority',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: DropdownButtonFormField(
                      onChanged: (value) {
                        _priority = value;
                        priorityController.text = _priority;
                      },
                      items: [
                        DropdownMenuItem(
                            value: "Urgent",
                            child: Row(
                              children: [
                                Icon(Icons.pending_actions),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Urgent")
                              ],
                            )),
                        DropdownMenuItem(
                            value: "Later",
                            child: Row(
                              children: [
                                Icon(Icons.timeline),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Later")
                              ],
                            )),
                        DropdownMenuItem(
                            value: "Future",
                            child: Row(
                              children: [
                                Icon(Icons.hourglass_empty_outlined),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Future")
                              ],
                            )),
                      ],
                      validator: (input) {
                        if (_priority == null) {
                          return "Please select priority";
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
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
                        hintText: "Priority",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      color: Color(0xffec9489),
                      onPressed: () {
                        createToDo();
                      },
                      child: load
                          ? SpinKitCircle(color: Colors.white)
                          : Text('Create To Do',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
