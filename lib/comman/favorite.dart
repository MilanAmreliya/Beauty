import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/model/apiModel/requestModel/favorite_request_model.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

bool checkFavorite(String id) {
  List favoriteList = PreferenceManager.getFavorite() ?? [];
  if (favoriteList.isEmpty) {
    return false;
  }
  int index = favoriteList.indexWhere((element) => element['id'] == id);
  if (index > -1) {
    return true;
  }
  return false;
}

Future<void> addFavorite({
  String id,
  String title,
  String subTitle,
  String image,
  String price,
  String description,
}) async {
  FavoriteRequestModel model = FavoriteRequestModel();
  model.id = id;
  model.title = title;
  model.subTitle = subTitle;
  model.image = image;
  model.price = price;
  model.description = description;

  List favoriteList = PreferenceManager.getFavorite() ?? [];

  int index = favoriteList.indexWhere((element) => element['id'] == id);
  if (index == -1) {
    favoriteList.add(model.toJson());
    CommanWidget.snackBar(message: 'Add to favorite');
    await PreferenceManager.setFavorite(favoriteList);
  } else {
    favoriteList.removeAt(index);
    CommanWidget.snackBar(message: 'Remove to favorite');
    await PreferenceManager.setFavorite(favoriteList);
  }
}
