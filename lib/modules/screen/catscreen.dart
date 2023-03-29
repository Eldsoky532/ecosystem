import 'package:ecosystem/cubit/home/home_cubit.dart';
import 'package:ecosystem/models/category_model.dart';
import 'package:ecosystem/modules/screen/catproduct/catproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoriesData = BlocProvider.of<HomeCubit>(context).catergorys;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
          child: GridView.builder(
              itemCount: categoriesData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15
              ),
              itemBuilder: (context,index){
                return InkWell(
                  onTap: ()
                  {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => CategoryProduct(catid: HomeCubit.get(context).catergorys[index].id.toString(),)),
                  );

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                    child: Column(
                      children:
                      [
                        Expanded(
                          child: Image.network(categoriesData[index].url!,fit: BoxFit.fill,),
                        ),
                        const SizedBox(height: 10,),
                        Text(categoriesData[index].title!)
                      ],
                    ),
                  ),
                );
              }
          ),
        )
    );
  }
}