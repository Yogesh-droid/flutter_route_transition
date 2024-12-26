library route_transition;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TransitionType { fade, scale, slide, rotation, none }

class RouteTransition {
  Page<dynamic> getTransition(
      {required Widget child,
      Duration? duration,
      TransitionType? animationType}) {
    return CustomTransitionPage(
        child: child,
        transitionDuration: duration ?? const Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          switch (animationType) {
            /**
               * this is for sliding animation for a page to enter in stack
               * 
               * you can change offset to set enter position accordingly
               */
            case TransitionType.slide:
              return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeIn)),
                  ),
                  child: child);

            /**
                 * this is fade animation
                 */
            case TransitionType.fade:
              return FadeTransition(opacity: animation, child: child);

            /**
               * this is scale transtion
               */

            case TransitionType.scale:
              return ScaleTransition(scale: animation, child: child);

            /**
                 * this is rotation transition
                 * 
                 */

            case TransitionType.rotation:
              return RotationTransition(
                turns: animation,
                child: child,
              );

            default:
              return child;
          }
        });
  }
}
