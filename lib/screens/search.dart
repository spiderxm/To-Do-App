import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/utilities/todocard1.dart';

import 'create_todo.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Widget> todos = [];
  Color color = Color(0xffec9489);
  String title = '';
  final titleController = new TextEditingController();

  void fetchAndSetUI() async {
    try {
      var documents = await Firestore.instance
          .collection('todos')
          .where("email", isEqualTo: FirebaseAuth.instance.currentUser.email)
          .get();
      List<QueryDocumentSnapshot> list = documents.docs;
      List<Widget> todolist = [];
      print(list.length);
      for (int index = 0; index < list.length; index++) {
        String t = list[index]["title"];
        t = t.toLowerCase();
        if (!t.contains(title)) {
          continue;
        }
        Timestamp timeStamp = list[index]["date"];
        todolist.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: TodoCard(
              list[index]["title"],
              list[index].id,
              list[index]["status"],
              list[index]["description"],
              DateTime.fromMicrosecondsSinceEpoch(
                  timeStamp.microsecondsSinceEpoch),
              list[index]["time_of_completion"],
              fetchAndSetUI),
        ));
      }
      if (todolist.length == 0) {
        todolist.add(Center(
          child: Container(
            height: 240,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "There are no To-Do with specified filter",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        await Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => CreateTodo()));
                        fetchAndSetUI();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text('Create To-Do\'s',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      }
      setState(() {
        todos = todolist;
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "There was some error.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAndSetUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: color,
      ),
      body: Container(
        height: double.infinity,
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(18),
            child: TextFormField(
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              controller: titleController,
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                title = value;
              },
              onChanged: (value) {
                title = value.toLowerCase().trim();
                fetchAndSetUI();
              },
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: new BorderSide(width: 2, color: Colors.grey[200]),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: new BorderSide(width: 2, color: Colors.grey[200]),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black.withOpacity(1),
                ),
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(
                  color: Colors.black.withOpacity(1),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ),
          Text("RESULTS", style: TextStyle(color: Colors.black, fontSize: 24)),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Center(child: ListView(children: todos))),
          )
        ]),
      ),
    );
  }
}
