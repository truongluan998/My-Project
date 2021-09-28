import 'package:flutter/material.dart';

class TitleTicket extends StatelessWidget {
  const TitleTicket({
    Key? key, required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
