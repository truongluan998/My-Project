import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late final _usersRef;

  @override
  void initState() {
    _usersRef = FirebaseFirestore.instance.collection('users');
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Text('Timeline'),
    );
  }
}
