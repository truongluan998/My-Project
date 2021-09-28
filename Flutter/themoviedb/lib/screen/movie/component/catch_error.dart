import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatchError extends StatelessWidget {

  final String message;
  final VoidCallback? onTap;

  const CatchError({required this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: InkWell(
            onTap: onTap,
            child: Container(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ));
  }
}