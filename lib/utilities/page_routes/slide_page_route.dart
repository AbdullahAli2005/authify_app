import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  // ignore: unused_field
  final Widget _child;

  SlidePageRoute(this._child)
      : super(
            transitionDuration: const Duration(milliseconds: 540),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondAnimation,
                Widget child) {
              // Use Tween to define the slide animation
              var slideAnimation = Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut, // Use a curve for smoother transitions
              ));

              return SlideTransition(
                position: slideAnimation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, animation, secondAnimation) {
              return _child;
            });
}
