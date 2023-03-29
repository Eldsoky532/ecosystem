import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/core/images_asstes/app_assets.dart';
import 'package:ecosystem/core/route/route.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:15),
            ()=>context.go(RouteApp.onboarding));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 150,
            child: Align(
              alignment: Alignment.center,
              child: Image(image: AssetImage(
                  AppImageAsset.logoapp
              ),),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Eco System',
              style:TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
