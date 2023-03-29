import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/modules/screen/profile_details/profile_details.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Padding(
           padding: EdgeInsets.all(15),
         child:  CircleAvatar(
           radius: 60,
           backgroundImage: AssetImage('assets/images/logoapp.png'),
         ),
       ),
        Padding(padding: EdgeInsets.all(10),
          child: Card(
            elevation: 1,
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileDetails()),
                );
              },
              child:Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text("Edit Profile",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      )),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_sharp,color: AppColor.primaryColor,)
                    ],
                  ),
                ),
              )
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(10),
        child: Card(
          elevation: 1,
          child: Container(
            height: 50,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Change Languge",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_sharp,color: AppColor.primaryColor,)
                ],
              ),
            ),
          ),
        ),
        ),
        Padding(padding: EdgeInsets.all(10),
          child: Card(
            elevation: 1,
            child: Container(
              height: 50,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text("Change Mode",style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    )),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp,color: AppColor.primaryColor,)
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(10),
          child: Card(
            elevation: 1,
            child: Container(
              height: 50,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text("Sign out",style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    )),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_sharp,color: AppColor.primaryColor,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
