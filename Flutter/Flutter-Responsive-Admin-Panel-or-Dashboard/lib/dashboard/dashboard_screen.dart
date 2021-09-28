import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

import 'component/header.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header()
            ],
          ),
        ),
      ),
    );
  }
}


