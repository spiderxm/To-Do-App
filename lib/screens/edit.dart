import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateToDo extends StatefulWidget {
  String id;
  String title;
  String description;
  DateTime endDate;
  String time;
  String priority;

  UpdateToDo(this.id, this.title, this.description, this.endDate, this.time,
      this.priority);

  @override
  _UpdateToDoState createState() => _UpdateToDoState();
}

class _UpdateToDoState extends State<UpdateToDo> {
  String _title, _description, _priority;
  DateTime _dateTime;
  TimeOfDay _timeOfDay;

  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();
  final dateTimeController = TextEditingController();
  final timeController = TextEditingController();
  final priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _priority = widget.priority;
    priorityController.text = _priority;
    _description = widget.description;
    descriptionController.text = widget.description;
    titleController.text = widget.title;
    _dateTime = widget.endDate;
    dateTimeController.text = widget.endDate.toString().substring(0, 10);
    timeController.text = widget.time.substring(10, 15);
    _timeOfDay = TimeOfDay(
        hour: int.parse(widget.time.substring(10, 12).toString()),
        minute: int.parse(widget.time.substring(13, 15).toString()));
  }

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    dateTimeController.dispose();
    timeController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  void updateToDo() async {
    bool valid = _formKey.currentState.validate();
    if (!valid) return;
    try {
      _formKey.currentState.save();
      await Firestore.instance.collection('todos').doc(widget.id).update({
        "title": _title,
        "description": _description,
        "priority": _priority,
        "date": _dateTime,
        "time_of_completion": _timeOfDay.toString()
      });
      Fluttertoast.showToast(
          msg: "To Do Updated SuccessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.of(context).pop();
    } catch (e) {
      Fluttertoast.showToast(
          msg: "There is some error",
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit To-Do"),
        backgroundColor: Color(0xffec9489),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34), topRight: Radius.circular(34)),
            ),
            child: Form(
              key: _formKey,
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
                            return "Title should have length >= 3";
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
                            return "Description should have length >= 0";
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
                            return "Date should be selected";
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
                          if (_timeOfDay == null) {
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
                              _timeOfDay = time;
                              int l = _timeOfDay.minute.toString().length;
                              if (l == 1) {
                                timeController.text =
                                    _timeOfDay.hour.toString() +
                                        ":0" +
                                        _timeOfDay.minute.toString();
                              } else {
                                timeController.text =
                                    _timeOfDay.hour.toString() +
                                        ":" +
                                        _timeOfDay.minute.toString();
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
                      value: _priority,
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
                        updateToDo();
                      },
                      child: Text('Update To Do',
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
