part of 'intro_animation__bloc.dart';

class IntroAnimationEvent {
  IntroAnimationEvent({
    this.scrollPosition = 0,
    required this.widgetsPositions,
  });

  double scrollPosition;
  Map<GlobalKey, double> widgetsPositions;
}
