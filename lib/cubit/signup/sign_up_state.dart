


abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUploaded extends SignUpState {}

class SignUploading extends SignUpState {}

class SignUperror extends SignUpState {
  String message;

  SignUperror({required this.message});
}

