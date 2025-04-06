import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;

            // Slide animation with custom curve
            var slideAnimation = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: curve))
                .animate(animation);

            // Fade animation with slight delay
            var fadeAnimation = Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeIn))
                .animate(CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
                ));

            // Scale animation with custom curve
            var scaleAnimation = Tween(begin: 0.98, end: 1.0)
                .chain(CurveTween(curve: Curves.easeOut))
                .animate(CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
                ));

            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: child,
                ),
              ),
            );
          },
        );
}
