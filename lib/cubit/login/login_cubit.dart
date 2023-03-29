import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecosystem/core/constant/urland%20endpoint.dart';
import 'package:ecosystem/cubit/login/login_state.dart';
import 'package:ecosystem/data/local/cachehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login({required String email, required String password}) async {
    try {
      var response = await http.post(Uri.parse(logurl),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("Response is : $data");
          await CacheHelper.saveData(key: "token", value: data['data']['token']);

          emit(LoginLoaded());
        } else {
          debugPrint("Response is : $data");
          emit(Loginerror(meaasge: data['message']));
        }
      }
    } catch (e) {
      debugPrint("Error Catch is : $e");
      emit(Loginerror(meaasge: e.toString()));
    }
  }
}
