import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecosystem/core/constant/urland%20endpoint.dart';
import 'package:ecosystem/cubit/home/home_state.dart';
import 'package:ecosystem/data/local/cachehelper.dart';
import 'package:ecosystem/models/banner_model.dart';
import 'package:ecosystem/models/category_model.dart';
import 'package:ecosystem/models/product_model.dart';
import 'package:ecosystem/models/usermodel.dart';
import 'package:ecosystem/modules/screen/cartscreen.dart';
import 'package:ecosystem/modules/screen/catscreen.dart';
import 'package:ecosystem/modules/screen/favscreen.dart';
import 'package:ecosystem/modules/screen/home.dart';
import 'package:ecosystem/modules/screen/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavScreen(),
    CartScreen(),

  ];


  void chaneBottom(int index) {
    currentindex = index;
    emit(ChangBootomNavBar());
  }

  UserModel? userModel;
  void getUserData() async {
    emit(GetUserDataLoadingState());
    var response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/profile"),
        headers:
        {
          'Authorization' : CacheHelper.getData(key: "token"),
          "lang" : "en"
        }
    );
    var responseData = jsonDecode(response.body);
    if( responseData['status'] == true )
    {
      userModel = UserModel.fromJson(data: responseData['data']);
      print("response is : $responseData");
      emit(GetUserDataSuccessState());
    }
    else
    {
      print("response is : $responseData");
      emit(FailedToGetUserDataState(error: responseData['message']));
    }
  }

  List<BannerModel> banners = [];

  void gettBanners() async {
    emit(GetBannersLoadingState());
    try {
      var response = await http.get(
        Uri.parse(bannerurl),
      );
      final responsebody = jsonDecode(response.body);
      if (responsebody['status'] == true) {
        for (var item in responsebody['data']) {
          banners.add(BannerModel.fromJson(data: item));
        }
        emit(GetBannersSuccessState());
      } else {
        emit(FailedToGetBannersState());
      }
    } catch (e) {
      emit(FailedToGetBannersState());
    }
  }

  List<CategoryModel> catergorys = [];

  void getcategory() async {
    emit(GetCategoryLoadingState());
    try {
      var response =
          await http.get(Uri.parse(categoryurl), headers: {'lang': "en"});

      final responsedata = jsonDecode(response.body);
      if (responsedata['status'] == true) {
        for (var item in responsedata['data']['data']) {
          catergorys.add(CategoryModel.fromJson(data: item));
        }

        emit(GetCategoryLoadedState());
      } else {
        emit(GetCategoryerrorState());
      }
    } catch (e) {
      emit(GetCategoryerrorState());
    }
  }

  List<ProductModel> products = [];

  void getProduct() async {
    emit(GetProductLoadingState());
    try {
      var response = await http.get(Uri.parse(homeurl), headers: {
        'lang': "en",
        'Authorization': CacheHelper.getData(key: "token"),
      });
      var responsedata = jsonDecode(response.body);
      if (responsedata['status'] == true) {
        for (var item in responsedata['data']['products']) {
          products.add(ProductModel.fromJson(data: item));
        }
        emit(GetCategoryLoadedState());
      } else {
        emit(GetCategoryerrorState());
      }
    } catch (e) {
      emit(GetCategoryerrorState());
    }
  }

  List<ProductModel> filteredProducts = [];

  void filterProducts({required String input}) {
    filteredProducts = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(GetFilterdsucess());
  }

  List<ProductModel> fav = [];
  Set<String> favouritesId = {};

  Future<void> getfav() async {
    fav.clear();
    emit(GetFavLoadingState());
    try {
      var response = await http.get(Uri.parse(favurl), headers: {
        'lang': 'en',
        'Authorization': CacheHelper.getData(key: "token"),
      });

      var responsedata = jsonDecode(response.body);
      if (responsedata['status'] == true) {
        for (var item in responsedata['data']['data']) {
          fav.add(ProductModel.fromJson(data: item['product']));
          favouritesId.add(item['product']['id'].toString());
        }
        emit(GetFavLoadedState());
      } else {
        emit(GetFaverrorState());
      }
    } catch (e) {
      emit(GetFaverrorState());
    }
  }

  void addorremove({required String productID}) async {
    emit(AddOrRemoveItemFromFavoritesLoadingState());
    try {
      var response = await http.post(Uri.parse(favurl), headers: {
        'lang': 'en',
        'Authorization': CacheHelper.getData(key: "token"),
      }, body: {
        "product_id": productID
      });
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        if (favouritesId.contains(productID) == true) {
          // delete
          favouritesId.remove(productID);
        } else {
          // add
          favouritesId.add(productID);
        }
        await getfav();
        emit(AddOrRemoveItemFromFavoritesSuccessState());
      }
    } catch (e) {
      emit(AddOrRemoveItemFromFavoriteserrorState());
    }
  }

  List<ProductModel> catergoryproduct = [];

  Future<void> getcategoryproduct({required String catid}) async {
    catergoryproduct.clear();
    emit(GetCatDetailsLoadingState());
    try {
      var response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/categories/${catid}"),
        headers: {
          'lang': "en",
          'Authorization': CacheHelper.getData(key: "token"),
        },
      );

      final responsedata = jsonDecode(response.body);
      if (responsedata['status'] == true) {
        for (var item in responsedata['data']['data']) {
          catergoryproduct.add(ProductModel.fromJson(data: item));
        }

        emit(GetCatDetailsLoadedState());
      } else {
        emit(GetCatDetailserrorState());
      }
    } catch (e) {
      print("error : ${e.toString()}");
      emit(GetCatDetailserrorState());
    }
  }

  List<ProductModel> carts = [];
  int totalPrice = 0;
  Set<String> cartdid = {};

  Future<void> getcaerts() async {
    carts.clear();
    emit(GetCartProductLoadingState());
    try {
      var response = await http
          .get(Uri.parse("https://student.valuxapps.com/api/carts"), headers: {
        "Authorization": CacheHelper.getData(key: "token"),
        "lang": "en"
      });
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        // success
        for (var item in responseBody['data']['cart_items']) {

          carts.add(ProductModel.fromJson(data: item['product']));
          cartdid.add(item['product']['id'].toString());
        }
        totalPrice = responseBody['data']['total'];
        debugPrint("Carts length is : ${carts.length}");
        emit(GetCartProductLoadedState());
      } else {
        // failed
        emit(GetCartProducterrorState());
      }
    } catch (e) {
      print("Eorrer 1 :${e.toString()}");
      emit(GetCartProductLoadedState());
    }
  }

  void AddorRemovefromCart({required String productid}) async {
    emit(AddOrRemoveItemFromCartLoadingState());
    try {
      var responde = await http.post(Uri.parse("https://student.valuxapps.com/api/carts"),
          headers: {
            "Authorization": CacheHelper.getData(key: "token"),
            "lang": "en"
          },
          body: {
            "product_id": productid
          });
      var responsedata=jsonDecode(responde.body);
      if(responsedata['status']==true)
        {
          cartdid.contains(productid)==true?
              cartdid.remove(productid)
              :cartdid.add(productid);

          await getcaerts();
          emit(AddOrRemoveItemFromCartSuccessState());
        }else
          {
            emit(AddOrRemoveItemFromCarterrorState());

          }
    } catch (e) {
      print("Error : ${e.toString()}");
      emit(AddOrRemoveItemFromCarterrorState());
    }
  }
}
