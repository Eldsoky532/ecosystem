import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/cubit/home/home_cubit.dart';
import 'package:ecosystem/cubit/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context,state)
      {

      },
      builder: (context,state){
        return Scaffold(
            body:cubit.fav.isEmpty?Center(child: Icon(
              Icons.hourglass_empty,color: AppColor.primaryColor,
            ),): Padding(
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12.5),
              child: Column(
                children:
                [

                  SizedBox(height: 5,),
                  Expanded(
                    child: ListView.builder(
                        itemCount: HomeCubit.get(context).filteredProducts.isEmpty?cubit.fav.length:HomeCubit.get(context).filteredProducts.length,
                        itemBuilder: (context,index)
                        {
                          return Card(
                            elevation: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),

                              ),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 12.5),
                              child: Row(
                                children:
                                [
                                  Image.network(
                                    cubit.fav[index].image!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(width: 15,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:
                                      [
                                        Text(cubit.fav[index].name!,maxLines: 1,style: TextStyle(fontSize: 16.5,fontWeight: FontWeight.bold,color: Colors.black45,overflow: TextOverflow.ellipsis),),
                                        SizedBox(height: 7,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:
                                          [
                                            Text("${cubit.fav[index].price!} \$"),
                                            SizedBox(width: 5,),
                                            Text("${cubit.fav[index].oldPrice!} \$",style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        MaterialButton(
                                          onPressed: ()
                                          {
                                            // add | remove
                                            cubit.addorremove(productID: cubit.fav[index].id.toString());
                                          },
                                          child: Text("Remove"),
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          color: AppColor.primaryColor,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              ),
            )
        );
      },
    );
  }
}
