

class FindShopByFilterReqModel {
  String distance;
  String userId;
  String lati;
  String longi;
  String place;
  String service;

  FindShopByFilterReqModel(
      {this.distance, this.longi, this.lati, this.place, this.service,this.userId});

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'lati': lati,
      'longi': longi,
      'userID':userId
      // 'place': place,
      // 'service': service,
    };
  }
}
