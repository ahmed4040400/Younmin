part of 'sign_up_cubit.dart';

class SignUpState {
  SignUpState({this.visible = false, this.imageFile, this.progress = 0});

  final Uint8List? imageFile;
  final double progress;
  final bool visible;
}
