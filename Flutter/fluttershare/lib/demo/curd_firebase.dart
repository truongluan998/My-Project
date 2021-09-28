import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimelineDemo extends StatefulWidget {
  @override
  _TimelineDemoState createState() => _TimelineDemoState();
}

class _TimelineDemoState extends State<TimelineDemo> {
  // List<dynamic> users = [];
  //
  late final _usersRef;

  @override
  void initState() {
    _usersRef = FirebaseFirestore.instance.collection('users');
    // getUser();
    // getUserById();
    // createUser();
    // updateUser();
    deleteUser();
    super.initState();
  }

  Future<void> createUser() async {
    await _usersRef
        .add({'username': 'Jeff', 'postsCount': 0, 'isAdmin': false});
  }

  Future<void> updateUser() async {
    final doc = await _usersRef.doc('GgAcT4hfY2mNTZz7qW0F').get();
    if (doc.exists) {
      doc.reference.update(
        {'username': 'Luan', 'postsCount': 1, 'isAdmin': true},
      );
    }
  }

  Future<void> deleteUser() async {
    final doc = await _usersRef.doc('GgAcT4hfY2mNTZz7qW0F').get();
    if(doc.exitst) {
      doc.reference.delete();
    }
  }

  //
  // Future<void> getUser() async {
  //   final QuerySnapshot snapshot = await usersRef
  //       // .where('postsCount', isGreaterThan: 3)
  //       // // .where('username', isEqualTo: 'Fred')
  //       // // .orderBy('postsCount', descending: true)
  //       // .limit(1)
  //       .get();
  //
  //   setState(() {
  //     users = snapshot.docs;
  //   });
  // snapshot.docs.forEach(
  //   (doc) {
  //     print(doc.data());
  //     print(doc.id);
  //     print(doc.exists);
  //   },
  // );
  // }

  // void getUserById() async {
  //   final String id = 'lseOO8TEFe3dUtuzRGjK';
  //   final DocumentSnapshot doc = await usersRef.doc(id).get();
  //   print(doc.data());
  //   print(doc.id);
  //   print(doc.exists);
  // }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        //FutureBuilder
        // future: _usersRef.get(),
        stream: _usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children = snapshot.data!.docs
              .map((user) => Text(user['username']))
              .toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
