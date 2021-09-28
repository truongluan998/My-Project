import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.menu, color: Colors.white,),
        Spacer(),
        Icon(Icons.notifications, color: Colors.white,)
      ],
    );
  }
}
