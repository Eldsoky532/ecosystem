import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/cubit/home/home_cubit.dart';
import 'package:ecosystem/cubit/home/home_state.dart';
import 'package:ecosystem/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  ProductModel model;
   ProductDetails({required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(

      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.primaryColor,
            title: Text("Product Details"),

          ),
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: NetworkImage(model.image!),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${model.name}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          HomeCubit.get(context).addorremove(productID: model.id.toString());
                        },
                        child: Icon(
                          HomeCubit.get(context).favouritesId.contains(model.id.toString())? Icons.favorite:Icons.favorite_outline
                          ,
                          color: AppColor.primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${model.description}",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 13,
                    ),
                  ),
                ],
              ),SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "${model.price}",
                      style: TextStyle(fontSize: 20, color: AppColor.primaryColor),
                    ),
                    Spacer(),
                    MaterialButton(
                      onPressed: () {
                        // add | remove
                        HomeCubit.get(context).AddorRemovefromCart(productid: model.id.toString());

                      },
                      child:HomeCubit.get(context).cartdid.contains(model.id)?Text("Added")
                          : Text("Add Cart"),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: AppColor.primaryColor,
                    )
                  ],
                ),
              )
            ],

          ),
        );
      },
    );
  }
}
