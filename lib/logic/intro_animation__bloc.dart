import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'intro_animation__event.dart';
part 'intro_animation__state.dart';

class IntroAnimationBloc
    extends Bloc<IntroAnimationEvent, IntroAnimationState> {
  IntroAnimationBloc() : super(IntroAnimationInitial());

  @override
  Stream<IntroAnimationState> mapEventToState(
    IntroAnimationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
