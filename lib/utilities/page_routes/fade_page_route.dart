import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  // ignore: unused_field
  final Widget _child;

  FadePageRoute(this._child)
      : super(
            transitionDuration: const Duration(milliseconds: 540),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation secondAnimation,
                Widget child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, animation, secondAnimation) {
              return _child;
            });
}
