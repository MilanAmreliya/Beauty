class PromotedShopRequestModel {
  String shopId;
  String startDate;
  String endDate;
  String amount;

  PromotedShopRequestModel(
      {this.shopId, this.endDate, this.startDate, this.amount});

  Map<String, dynamic> toJson() {
    return {
      'shop_id': shopId,
      'start_date': startDate,
      'end_date': endDate,
      'amount': '10'
    };
  }
}
