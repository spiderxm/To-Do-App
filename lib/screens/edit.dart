import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateToDo extends StatefulWidget {
  String id;
  String title;
  String description;
  DateTime endDate;

  UpdateToDo(this.id, this.title, this.description, this.endDate);

  @override
  _UpdateToDoState createState() => _UpdateToDoState();
}

class _UpdateToDoState extends State<UpdateToDo> {
  String _title, _description;
  DateTime _dateTime;
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();
  final dateTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _description = widget.description;
    descriptionController.text = widget.description;
    titleController.text = widget.title;
    _dateTime = widget.endDate;
    dateTimeController.text = widget.endDate.toString().substring(0, 10);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    dateTimeController.dispose();
    super.dispose();
  }

  void updateToDo() async {
    bool valid = _formKey.currentState.validate();
    if (!valid) return;
    try {
      _formKey.currentState.save();
      await Firestore.instance.collection('todos').doc(widget.id).update(
          {"title": _title, "description": _description, "date": _dateTime});
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
    );
  }
}
