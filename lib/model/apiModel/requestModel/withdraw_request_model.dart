class WithdrawReqModel {
  String shopId;
  String ammount;
  String accountName;
  String bsbNumber;
  String accountNumber;

  WithdrawReqModel(
      {this.shopId,
      this.ammount,
      this.accountName,
      this.bsbNumber,
      this.accountNumber});

 Map<String, dynamic> toJson() {
    return {
      'shop_id': shopId,
      'ammount': ammount,
      'artist_account_name': accountName,
      'artist_bsb_number': bsbNumber,
      'artist_account_number': accountNumber,
    };
  }
}
