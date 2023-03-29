import 'package:ecosystem/core/route/route.dart';
import 'package:ecosystem/core/route/routes.dart';
import 'package:ecosystem/cubit/home/home_cubit.dart';
import 'package:ecosystem/cubit/login/login_cubit.dart';
import 'package:ecosystem/cubit/signup/sign_up_cubit.dart';
import 'package:ecosystem/data/local/cachehelper.dart';
import 'package:ecosystem/modules/screen/splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(create:(context)=>SignUpCubit()),
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>HomeCubit()..gettBanners()..getcategory()..getProduct()..getfav()..getcaerts())
      ],child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
       debugShowCheckedModeBanner: false,
       routerConfig:AppRouter.router,
      ),
    );
  }
}


