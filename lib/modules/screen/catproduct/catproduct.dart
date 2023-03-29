import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/cubit/home/home_cubit.dart';
import 'package:ecosystem/cubit/home/home_state.dart';
import 'package:ecosystem/models/product_model.dart';
import 'package:ecosystem/modules/screen/prodetails/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProduct extends StatelessWidget {
  String catid;

   CategoryProduct({required this.catid});

  @override
  Widget build(BuildContext context) {
    var cubit=HomeCubit.get(context);

    cubit.getcategoryproduct(catid: catid);

    return BlocConsumer<HomeCubit,HomeState>(
        builder: (context,state){
         return Scaffold(
           appBar: AppBar(
             backgroundColor: AppColor.primaryColor,
             title: Text("Category Product"),

           ),
           body:cubit.catergoryproduct.isEmpty?Center(child: CircularProgressIndicator(
             color: AppColor.primaryColor,
           ),): ListView(
             shrinkWrap: true,
             children: [
               GridView.builder(
                   itemCount: HomeCubit.get(context).catergoryproduct.length,

                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       mainAxisSpacing: 12,
                       crossAxisSpacing: 15,
                       childAspectRatio: 0.7
                   ),
                   itemBuilder: (context,index)
                   {
                     return InkWell(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => ProductDetails(model:cubit.catergoryproduct[index])),
                         );
                       },
                       child: _productItem(
                           model:cubit.catergoryproduct[index],
                           cubit: cubit
                       ),
                     );
                   }
               ),
             ],
           ),
         );
        },
        listener:(context,state){

        }
    );
  }
  Widget _productItem({required ProductModel model, required HomeCubit cubit}) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),

        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                model.image!,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${model.price!} \$",
                            style: TextStyle(fontSize: 13,color: AppColor.primaryColor),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${model.oldPrice!} \$",
                          style: TextStyle(
                              color: AppColor.grey,
                              fontSize: 12.5,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    cubit.favouritesId.contains(model.id.toString())? Icons.favorite:Icons.favorite_outline,
                    size: 20,
                    color:AppColor.primaryColor,
                  ),
                  onTap: () {
                    cubit.addorremove(productID: model.id.toString());
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
