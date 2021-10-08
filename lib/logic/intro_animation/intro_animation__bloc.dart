import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'intro_animation__event.dart';
part 'intro_animation__state.dart';

class IntroAnimationBloc
    extends Bloc<IntroAnimationEvent, IntroAnimationState> {
  IntroAnimationBloc() : super(IntroAnimationState(animateIn: false));

  @override
  Stream<IntroAnimationState> mapEventToState(
    IntroAnimationEvent event,
  ) async* {
    print(event.widgetsPositions);
    // ignore: void_checks
    event.widgetsPositions.forEach((key, position) async* {
      print(position);
      print("===========");
      if (position <= 0) {
        yield IntroAnimationState(animateIn: true, key: key);
      }
    });
  }
}
