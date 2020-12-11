import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/screens/create_todo.dart';
import 'package:todo/screens/done-todo\'s.dart';
import 'package:todo/screens/todo\'s.dart';
import 'package:todo/screens/undone-todo\'s.dart';
import 'package:todo/utilities/todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userImageUrl = FirebaseAuth.instance.currentUser.photoURL;

  void fetchTodo() async {
    // ignore: deprecated_member_use
    try {
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection("todos").getDocuments();
      // ignore: deprecated_member_use
      var list = querySnapshot.documents;
      print(list);
    } catch (e) {
      print(e);
    }
  }

  void tryLogout() async {
    FirebaseAuth.instance.signOut();
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      Fluttertoast.showToast(
          msg: "Successfully Logged-Out",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "There is some error.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      print(e);
    }
  }

  Color color = Color(0xffec9489);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }

  final style =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xff1cb177)
          ),
            accountName: Text(FirebaseAuth.instance.currentUser.displayName),
            accountEmail: Text(FirebaseAuth.instance.currentUser.email),
            currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage(FirebaseAuth.instance.currentUser.photoURL))),
        ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => Todos()));
          },
          leading: CircleAvatar(
              child: Icon(
                Icons.work,
                color: Colors.white,
              ),
              backgroundColor: color),
          title: Text(
            "All To-Do",
            style: style,
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => DoneToDos()));
          },
          leading: CircleAvatar(
              child: Icon(
                Icons.radio_button_checked,
                color: Colors.white,
              ),
              backgroundColor: color),
          title: Text(
            "Completed To-Do",
            style: style,
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => UnDoneToDos()));
          },
          leading: CircleAvatar(
            child: Icon(
              Icons.radio_button_unchecked,
              color: Colors.white,
            ),
            backgroundColor: color,
          ),
          title: Text(
            "Uncompleted To-Do",
            style: style,
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => CreateTodo()));
          },
          leading: CircleAvatar(
              child: Icon(
                Icons.topic,
                color: Colors.white,
              ),
              backgroundColor: color),
          title: Text(
            "Create To-Do",
            style: style,
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            tryLogout();
          },
          leading: CircleAvatar(
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              backgroundColor: color),
          title: Text(
            "Logout",
            style: style,
          ),
        ),
        Divider()
      ])),
      appBar: AppBar(
        backgroundColor: color,
        title: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "CheckList",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                tryLogout();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => CreateTodo()));
        },
        backgroundColor: Colors.white70,
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.black),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(18),
          height: double.infinity,
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('todos')
                .where("email",
                    isEqualTo: FirebaseAuth.instance.currentUser.email)
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
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "There are no tasks present.",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            width: double.infinity,
                            height: 50,
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
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
              return ListView.builder(
                  itemBuilder: (ctx, index) {
                    print(snapshot.data.documents[index]["date"]);
                    Timestamp timeStamp =
                        snapshot.data.documents[index]["date"];
                    print(timeStamp.microsecondsSinceEpoch);
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
                      ),
                    );
                  },
                  itemCount: snapshot.data.documents.length);
            },
          )),
    );
  }
}
