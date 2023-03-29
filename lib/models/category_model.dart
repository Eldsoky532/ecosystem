class CategoryModel
{

String? id;
String? url;
String? title;

CategoryModel.fromJson({required Map<String,dynamic> data})
{
id = data['id'].toString();
url = data['image'];
title = data['name'];
}


}