import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/core/route/route.dart';
import 'package:ecosystem/cubit/login/login_cubit.dart';
import 'package:ecosystem/cubit/login/login_state.dart';
import 'package:ecosystem/modules/widget/buttonauth.dart';
import 'package:ecosystem/modules/widget/logoauth.dart';
import 'package:ecosystem/modules/widget/textfieldauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailconroller = TextEditingController();
  TextEditingController passwordconroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Center(
                    child: Text(
                        "Signin",
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
                          "Please log in with Email and Go to Eco System",
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
                      hinttext: "Enter Your Email",
                      labeltext: "Email",
                      iconData: Icons.email_outlined,
                      isscure: false,
                      controller: emailconroller,
                      valid: (String val) {
                        if(val.isEmpty)
                          {
                            return "Enter your Email";
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
                      controller: passwordconroller,
                      isscure: true,
                      valid: (String val) {
                        if(val.isEmpty)
                        {
                          return "Enter your Password";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButtomAuth(text: "Sign in", onPressed: () {
                      if(formkey.currentState!.validate())
                        {
                          LoginCubit.get(context).login(
                              email: emailconroller.text,
                              password: passwordconroller.text
                          );
                        }
                    }),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dont have an account ? "),
                        InkWell(
                          onTap: ()=>context.go(RouteApp.signup),
                          child: Text("Sign up",
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
        listener: (context,state){
          if(state is LoginLoading)
          {
            Center(child: CircularProgressIndicator(
              backgroundColor: AppColor.primaryColor,
            ),);
          }
          if(state is LoginLoaded)
          {
            Fluttertoast.showToast(
                msg: "Sign in is Sucess ",
                textColor: Colors.white,
                backgroundColor: AppColor.primaryColor,
                gravity:ToastGravity.SNACKBAR
            );
            context.go(RouteApp.home);
          }
          if(state is Loginerror)
          {
            Fluttertoast.showToast(
                msg: "Sign in is Failed : ${state.meaasge.toString()} ",
                textColor: Colors.white,
                backgroundColor: AppColor.primaryColor,
                gravity:ToastGravity.CENTER
            );
          }
        }
    );
  }
}