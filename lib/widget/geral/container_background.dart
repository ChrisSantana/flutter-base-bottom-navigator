import 'package:flutter/material.dart';

class ContainerBackground extends StatelessWidget {
  final Widget child;
  const ContainerBackground({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade300,
            Colors.white,
          ],
          stops: [0, 0.8],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child ?? SizedBox.shrink(),
    );
  }
}
