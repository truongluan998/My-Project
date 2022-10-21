import 'package:flutter/material.dart';
import '../../theme/netflix_clone_color.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const CircularProgressIndicator(color: NetflixCloneColor.redColor);
}
