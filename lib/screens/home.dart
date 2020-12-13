import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/screens/create_todo.dart';
import 'package:todo/screens/done-todo\'s.dart';
import 'package:todo/screens/search.dart';
import 'package:todo/screens/todo\'s.dart';
import 'package:todo/screens/undone-todo\'s.dart';
import '../utilities/home_page_widget_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  Color color = Color(0xffec9489);
  var userImageUrl = FirebaseAuth.instance.currentUser.photoURL;

  void fetchTodo() async {
    try {
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection("todos").getDocuments();
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


  @override
  void initState() {
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
            decoration: BoxDecoration(color: Color(0xff1cb177)),
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
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Search()));
              })
        ],
      ),
      body: home[index],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        color: color,
        animationDuration: Duration(
          milliseconds: 500,
        ),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: color,
        items: [Icon(Icons.list), Icon(Icons.done), Icon(Icons.clear)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => CreateTodo()));
        },
        backgroundColor: color,
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}

