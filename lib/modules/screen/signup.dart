import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/core/route/route.dart';
import 'package:ecosystem/core/route/routes.dart';
import 'package:ecosystem/cubit/signup/sign_up_cubit.dart';
import 'package:ecosystem/cubit/signup/sign_up_state.dart';
import 'package:ecosystem/modules/widget/buttonauth.dart';
import 'package:ecosystem/modules/widget/logoauth.dart';
import 'package:ecosystem/modules/widget/textfieldauth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController emailconroller = TextEditingController();
  TextEditingController passwordconroller = TextEditingController();
  TextEditingController usernameconroller = TextEditingController();
  TextEditingController phoneconroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit,SignUpState>(
        listener: (context,state){
          if(state is SignUploading)
            {
               Center(child: CircularProgressIndicator(
                backgroundColor: AppColor.primaryColor,
              ),);
            }
          if(state is SignUploaded)
            {
              Fluttertoast.showToast(
                  msg: "Sign up is Sucess ",
                textColor: Colors.white,
                backgroundColor: AppColor.primaryColor,
                  gravity:ToastGravity.SNACKBAR
              );
              context.go(RouteApp.login);
            }
          if(state is SignUperror)
          {
            Fluttertoast.showToast(
                msg: "Sign up is Failed : ${state.message.toString()} ",
                textColor: Colors.white,
                backgroundColor: AppColor.primaryColor,
                gravity:ToastGravity.CENTER
            );
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Center(
                    child: Text(

                        "Signup",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey
                        )
                    ))),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                  key: formkey,
                  child: ListView(children: [
                    LogoAuth(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          "Please Create Email and Go to Eco System",
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),
                        )),
                    SizedBox(
                      height: 25,
                    ),
                    CustomeTextField(
                      hinttext: "Enter Your User Name",
                      labeltext: "User Name",
                      iconData: Icons.supervised_user_circle_sharp,
                      isscure: false,
                      controller: usernameconroller,
                      valid: (String val) {
                       if(val.isEmpty )
                         {
                          return 'Please Enter UserName';
                         }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomeTextField(
                      hinttext: "Enter Your Email",
                      labeltext: "Email",
                      iconData: Icons.email_outlined,
                      isscure: false,
                      controller: emailconroller,
                      valid: (String val) {
                        if(val.isEmpty )
                        {
                          return 'Please Enter Email';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomeTextField(
                      hinttext: "Enter Your Phone",
                      labeltext: "Phone",
                      iconData: Icons.phone,
                      isscure: false,
                      controller: phoneconroller,
                      valid: (String val) {
                        if(val.isEmpty )
                        {
                          return 'Please Enter Phone';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomeTextField(
                      hinttext: "Enter Your password",
                      labeltext: "password",
                      iconData: Icons.lock,
                      isscure: true,
                      controller: passwordconroller,
                      valid: (String val) {
                        if(val.isEmpty )
                        {
                          return 'Please Enter Password';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButtomAuth(text: "Signup", onPressed: () {
                      if(formkey.currentState!.validate())
                        {
                          SignUpCubit.get(context).Regist(
                              name: usernameconroller.text,
                              email: emailconroller.text,
                              phone: phoneconroller.text,
                              password: passwordconroller.text
                          );
                        }
                    }),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" have an account ? "),
                        InkWell(
                          onTap: ()=>context.go(RouteApp.login),
                          child: Text("Log In",
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ])),
            ),
          );
        },
    );
  }
}
