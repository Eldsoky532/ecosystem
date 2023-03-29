
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState{}

class LoginLoaded extends LoginState{}

class Loginerror extends LoginState{
  String meaasge;

  Loginerror({required this.meaasge});
}