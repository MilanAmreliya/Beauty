import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/small_profile_header.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        'Transaction History',
        leadingOnTap: () {
          Get.back();
        },
      ),
      backgroundColor: cDarkBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 15,
            ),
            smallProfileHeader(
                name: PreferenceManager.getUserName() ?? "",
                subName: PreferenceManager.getCustomerRole() ?? "",
                imageUrl: PreferenceManager.getCustomerPImg(),
                showPopup: false),
            SizedBox(
              height: 15,
            ),
            centerBody()
          ],
        ),
      ),
    );
  }

  Expanded centerBody() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(35),
            )),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            TabBar(
              indicatorColor: Colors.black,
              controller: _tabController,
              tabs: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Payment",
                      style: TextStyle(
                          color: Colors.black, fontSize: Get.height * 0.02)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Withdraw",
                      style: TextStyle(
                          color: Colors.black, fontSize: Get.height * 0.02)),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  paymentTabBarView(),
                  withdrawTabBarView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView withdrawTabBarView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
            children: List.generate(
                5,
                (index) => Column(
                      children: [
                        Container(
                          height: Get.height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: Get.height * 0.04,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    "https://cdn.imgbin.com/14/5/18/imgbin-automated-teller-machine-money-cash-atm-card-credit-card-credit-card-XD6tgfepGhnTK3PZKcBwbBLhC.jpg",
                                  ),
                                ),
                                SizedBox(
                                  width: Get.height * 0.01,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Withdraw From Premvati saloon",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.02,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text("19 jun,10:49 PM"),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text("\$5000"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        index == 4
                            ? SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Divider(
                                  thickness: 2,
                                ),
                              )
                      ],
                    ))),
      ),
    );
  }

  SingleChildScrollView paymentTabBarView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
            children: List.generate(
                5,
                (index) => Column(
                      children: [
                        Container(
                          height: Get.height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: Get.height * 0.04,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    "https://uploads-ssl.webflow.com/55805c1704ba70184ee0bc0a/57571a4061112bf3445b07b2_multiple%20user%20payment%20gateway.png",
                                  ),
                                ),
                                SizedBox(
                                  width: Get.height * 0.01,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Paid to Aone beauty saloon",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.02,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text("19 jun,10:49 PM"),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text("\$1000"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        index == 4
                            ? SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Divider(
                                  thickness: 1.5,
                                ),
                              )
                      ],
                    ))),
      ),
    );
  }
}
