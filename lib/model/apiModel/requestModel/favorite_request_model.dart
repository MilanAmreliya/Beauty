class FavoriteRequestModel {
  String id;
  String title;
  String subTitle;
  String image;
  String price;
  String description;

  FavoriteRequestModel({
    this.subTitle,
    this.id,
    this.title,
    this.image,
    this.description,
    this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title ?? '',
      'subTitle': subTitle ?? '',
      'image': image,
      'price': price ?? "",
      'description': description ?? "",
    };
  }
}
