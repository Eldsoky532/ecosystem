import 'dart:convert';

import 'package:ecosystem/core/constant/urland%20endpoint.dart';
import 'package:ecosystem/cubit/signup/sign_up_state.dart';
import 'package:ecosystem/data/local/cachehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit get(context)=>BlocProvider.of(context);
  
  
  void Regist({
  required String name,
    required String email,
    required String phone,
    required String password,
})
  async{
    emit(SignUploading());
    
   try{
     var response=await http.post(Uri.parse(signupurl),

         body: {
           'name':name,
           'email':email,
           'phone':phone,
           'password':password,
           'image':"image"
         }
     );

     if(response.statusCode==200)
     {
       var data=jsonDecode(response.body);
       if(data['status']==true)
       {
         debugPrint("Response is : $data");
         await CacheHelper.saveData(key: "name", value: data['data']['name']);
         await CacheHelper.saveData(key: "phone", value: data['data']['phone']);
         await CacheHelper.saveData(key: "image", value: data['data']['image']);
         await CacheHelper.saveData(key: "email", value: data['data']['email']);
         emit(SignUploaded());
       }else
       {
         debugPrint("Response is : $data");
         emit(SignUperror(message: data['message']));
       }
     }
   }catch(e)
    {
      debugPrint("Error catch is : $e");
      emit(SignUperror(message: e.toString()));
    }
    
    
    
    
  }
  
}
