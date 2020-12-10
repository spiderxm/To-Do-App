import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/screens/create_todo.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userImageUrl),
            ),
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
              onPressed: () async {
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
                  print(e);
                }
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
              return ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TodoCard(
                          snapshot.data.documents[index]["title"],
                          snapshot.data.documents[index].id,
                          snapshot.data.documents[index]["status"]),
                    );
                  },
                  itemCount: snapshot.data.documents.length);
            },
          )),
    );
  }
}
