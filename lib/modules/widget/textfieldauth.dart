import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  String? hinttext;
  String? labeltext;
  IconData? iconData;
  TextEditingController? controller;
  Function valid;
  bool isscure=false;
  CustomeTextField({required this.hinttext,required this.labeltext,required this.iconData,required this.controller,required this.valid,required this.isscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value){
        return valid(value);
      },
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle:TextStyle(fontSize: 14) ,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        label: Container(margin: EdgeInsets.symmetric(horizontal: 9),child: Text("$labeltext",style: TextStyle(
          color: AppColor.primaryColor
        ),)),
        suffixIcon: Icon(iconData,color: AppColor.primaryColor,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      obscureText: isscure,
    );
  }
}