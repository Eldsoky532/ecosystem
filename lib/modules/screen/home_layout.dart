import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/core/images_asstes/app_assets.dart';
import 'package:ecosystem/cubit/home/home_cubit.dart';
import 'package:ecosystem/cubit/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primaryColor,
              elevation: 0,
              centerTitle: true,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    child: Image(
                      image: AssetImage(AppImageAsset.logoapp),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text("Eco System",style: TextStyle(

                  ),)
                ],
              ),
            ),
            body: HomeCubit.get(context).screens[HomeCubit.get(context).currentindex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:HomeCubit.get(context).currentindex ,
              selectedItemColor: AppColor.primaryColor,
              unselectedItemColor: AppColor.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (int index)
              {
              HomeCubit.get(context).chaneBottom(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: "home"),
                BottomNavigationBarItem(icon: Icon(Icons.category), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outlined), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.card_travel_sharp), label: ""),

              ],
            ),
          );
        },
        listener: (context,state){}
    );
  }
}
