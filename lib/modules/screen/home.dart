import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/core/images_asstes/app_assets.dart';
import 'package:ecosystem/cubit/home/home_cubit.dart';
import 'package:ecosystem/cubit/home/home_state.dart';
import 'package:ecosystem/models/product_model.dart';
import 'package:ecosystem/modules/screen/catproduct/catproduct.dart';
import 'package:ecosystem/modules/screen/prodetails/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final contoller = PageController();
  static final controller=TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  onChanged: (input)
                  {
                    HomeCubit.get(context).filterProducts(input: input);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black12,
                      size: 17,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 13, color: Colors.black12),
                    suffixIcon: const Icon(Icons.clear,
                        color: Colors.black12, size: 17),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              HomeCubit.get(context).banners.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: PageView.builder(
                            controller: contoller,
                            physics: const BouncingScrollPhysics(),
                            itemCount: HomeCubit.get(context).banners.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                HomeCubit.get(context).banners[index].url!,
                                fit: BoxFit.fill,
                              );
                            }),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 20),
                    ),

                  ],
                ),
              ),
              HomeCubit.get(context).catergorys.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 100,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 15,
                              );
                            },
                            itemCount: HomeCubit.get(context).catergorys.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryProduct(catid: HomeCubit.get(context).catergorys[index].id.toString(),)),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColor.primaryColor,
                                  backgroundImage: NetworkImage(
                                      HomeCubit.get(context)
                                          .catergorys[index]
                                          .url!),
                                ),
                              );
                            }),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Product",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              HomeCubit.get(context).products == null
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    )
                  :  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                    itemCount: HomeCubit.get(context).filteredProducts.isEmpty?HomeCubit.get(context).products.length
                        :HomeCubit.get(context).filteredProducts.length ,
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
                        onTap: ()
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(model: cubit.products[index] )),
                          );
                        },
                        child: _productItem(
                            model:HomeCubit.get(context).filteredProducts.isEmpty?
                            HomeCubit.get(context).products[index]:HomeCubit.get(context).filteredProducts[index],
                            cubit: HomeCubit.get(context)
                        ),
                      );
                    }
              ),
                  )
            ],
          );
        },
        listener: (context, state) {});
  }


  Widget _productItem({required ProductModel model, required HomeCubit cubit}) {
    return InkWell(

      child: Card(
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
      ),
    );
  }
}
