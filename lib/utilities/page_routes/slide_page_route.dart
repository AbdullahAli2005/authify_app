import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget _child;

  SlidePageRoute(this._child)
      : super(
            transitionDuration: Duration(milliseconds: 540),
            transitionsBuilder: (BuildContext _context,
                Animation<double> animation,
                Animation<double> secondAnimation,
                Widget child) {
              // Use Tween to define the slide animation
              var slideAnimation = Tween<Offset>(
                begin: Offset(-1, 0),
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
            pageBuilder: (BuildContext _context, animation, secondAnimation) {
              return _child;
            });
}
