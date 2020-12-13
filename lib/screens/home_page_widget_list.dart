import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo/utilities/todo.dart';
import 'create_todo.dart';

Color color = Color(0xffec9489);

List<Widget> home = [
  Container(
      padding: EdgeInsets.all(18),
      height: double.infinity,
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('todos')
            .where("email", isEqualTo: FirebaseAuth.instance.currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitFoldingCube(
                color: Color(0xfff3bcb5),
              ),
            );
          }
          if (snapshot.data.documents.length == 0) {
            return Center(
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
                          "There are no Completed Todo's Present",
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
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => CreateTodo()));
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
            );
          }
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text("All To-Do's", style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),),
                    backgroundColor: color,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        Timestamp timeStamp = snapshot.data.documents[index]["date"];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TodoCard(
                              snapshot.data.documents[index]["title"],
                              snapshot.data.documents[index].id,
                              snapshot.data.documents[index]["status"],
                              snapshot.data.documents[index]["description"],
                              DateTime.fromMicrosecondsSinceEpoch(
                                  timeStamp.microsecondsSinceEpoch),
                              snapshot.data.documents[index]["time_of_completion"],
                              snapshot.data.documents[index]["priority"]),
                        );
                      },
                      itemCount: snapshot.data.documents.length),
                ),
              ],
            ),
          );
        },
      )),
  Container(
      padding: EdgeInsets.all(18),
      height: double.infinity,
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('todos')
            .where("email", isEqualTo: FirebaseAuth.instance.currentUser.email)
            .where("status", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitFoldingCube(
                color: Color(0xfff3bcb5),
              ),
            );
          }
          if (snapshot.data.documents.length == 0) {
            return Center(
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
                          "There are no Completed Todo's Present",
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
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => CreateTodo()));
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
            );
          }
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text("Complete To-Do's", style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),),
                    backgroundColor: color,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        Timestamp timeStamp = snapshot.data.documents[index]["date"];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TodoCard(
                              snapshot.data.documents[index]["title"],
                              snapshot.data.documents[index].id,
                              snapshot.data.documents[index]["status"],
                              snapshot.data.documents[index]["description"],
                              DateTime.fromMicrosecondsSinceEpoch(
                                  timeStamp.microsecondsSinceEpoch),
                              snapshot.data.documents[index]["time_of_completion"],
                              snapshot.data.documents[index]["priority"]),
                        );
                      },
                      itemCount: snapshot.data.documents.length),
                ),
              ],
            ),
          );
        },
      )),
  Container(
      padding: EdgeInsets.all(18),
      height: double.infinity,
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('todos')
            .where("email", isEqualTo: FirebaseAuth.instance.currentUser.email)
            .where("status", isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitFoldingCube(
                color: Color(0xfff3bcb5),
              ),
            );
          }
          if (snapshot.data.documents.length == 0) {
            return Center(
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
                          "There are no In Complete Todo's Present",
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
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => CreateTodo()));
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
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  label: Text("Incomplete To-Do's", style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                  ),),
                  backgroundColor: color,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      Timestamp timeStamp =
                          snapshot.data.documents[index]["date"];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TodoCard(
                            snapshot.data.documents[index]["title"],
                            snapshot.data.documents[index].id,
                            snapshot.data.documents[index]["status"],
                            snapshot.data.documents[index]["description"],
                            DateTime.fromMicrosecondsSinceEpoch(
                                timeStamp.microsecondsSinceEpoch),
                            snapshot.data.documents[index]
                                ["time_of_completion"],
                            snapshot.data.documents[index]["priority"]),
                      );
                    },
                    itemCount: snapshot.data.documents.length),
              ),
            ],
          );
        },
      ))
];
