
abstract class HomeState {}

class HomeInitial extends HomeState {}


class GetUserDataSuccessState extends HomeState{}
class GetUserDataLoadingState extends HomeState{}
class FailedToGetUserDataState extends HomeState{
  String error;
  FailedToGetUserDataState({required this.error});
}

class ChangBootomNavBar extends HomeState{}
class GetBannersLoadingState extends HomeState{}
class GetBannersSuccessState extends HomeState{}
class FailedToGetBannersState extends HomeState{}

class GetCategoryLoadingState extends HomeState{}
class GetCategoryLoadedState extends HomeState{}
class GetCategoryerrorState extends HomeState{}

class GetProductLoadingState extends HomeState{}
class GetProductLoadedState extends HomeState{}
class GetProducterrorState extends HomeState{}

class GetFilterdsucess extends HomeState{}


class GetFavLoadingState extends HomeState{}
class GetFavLoadedState extends HomeState{}
class GetFaverrorState extends HomeState{}

class GetCatDetailsLoadingState extends HomeState{}
class GetCatDetailsLoadedState extends HomeState{}
class GetCatDetailserrorState extends HomeState{}


class GetCartProductLoadingState extends HomeState{}
class GetCartProductLoadedState extends HomeState{}
class GetCartProducterrorState extends HomeState{}




class AddOrRemoveItemFromFavoritesLoadingState extends HomeState{}
class AddOrRemoveItemFromFavoritesSuccessState extends HomeState{}
class AddOrRemoveItemFromFavoriteserrorState extends HomeState{}


class AddOrRemoveItemFromCartLoadingState extends HomeState{}
class AddOrRemoveItemFromCartSuccessState extends HomeState{}
class AddOrRemoveItemFromCarterrorState extends HomeState{}