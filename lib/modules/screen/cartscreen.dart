import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/core/constant/urland%20endpoint.dart';
import 'package:ecosystem/cubit/home/home_cubit.dart';
import 'package:ecosystem/cubit/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);

    return  Scaffold(
        body: BlocConsumer<HomeCubit,HomeState>(
            listener:(context,state){},
            builder:(context,state){
              return cubit.carts.isEmpty?Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty,color: AppColor.primaryColor,),
                    SizedBox(height: 10,),
                    Text("No Cart Add",style: TextStyle(
                      color: Colors.grey
                    ),)
                  ],
                ),
              ):Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                child: Column(
                  children:
                  [
                    Expanded(
                        child: cubit.carts.isNotEmpty ?
                        ListView.separated(
                            itemCount: cubit.carts.length,
                            separatorBuilder: (context,index){
                              return SizedBox(height: 12,);
                            },
                            itemBuilder: (context,index){
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(

                                ),
                                child: Card(
                                  elevation: 1,
                                  child: Row(
                                    children:
                                    [
                                      Image.network(cubit.carts[index].image!,height: 100,width: 100,fit: BoxFit.fill,),
                                      SizedBox(width: 12.5),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:
                                          [
                                            Text(cubit.carts[index].name!,style: TextStyle(color: Colors.black45,fontSize: 17,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                            SizedBox(height: 5,),
                                            Row(
                                              children:
                                              [
                                                Text("${cubit.carts[index].price!} \$"),
                                                SizedBox(width: 5,),
                                                if( cubit.carts[index].price != cubit.carts[index].oldPrice)
                                                  Text("${cubit.carts[index].oldPrice!} \$",style: TextStyle(decoration: TextDecoration.lineThrough),),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children:
                                              [
                                                OutlinedButton(
                                                    onPressed: ()
                                                    {
                                                      cubit.addorremove(productID: cubit.carts[index].id.toString());
                                                    },
                                                    child: Icon(
                                                      cubit.favouritesId.contains(cubit.carts[index].id.toString())?Icons.favorite:Icons.favorite_outline ,
                                                      color:  AppColor.primaryColor,
                                                    )
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    cubit.AddorRemovefromCart(productid: cubit.carts[index].id.toString());
                                                  },
                                                  child: Icon(Icons.delete,color: AppColor.primaryColor,),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        ) :
                        Center(child: Text("Loading....."),)
                    ),
                    Container(
                      child: Text("TotalPrice : ${cubit.totalPrice} \$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.black45),),
                    )
                  ],
                ),
              );
            }
        )
    );
  }
}