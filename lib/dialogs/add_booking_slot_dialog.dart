import 'package:flutter/material.dart';
import 'package:get/get.dart';
var list = ['11 AM', "1 PM", "3 PM", "7 PM", "9 PM"];

Future<void> bookingSlotDialog()async{

  return  Get.dialog(Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                   Get.back();
                  },
                  child: Container(
                    height: Get.height * 0.07,
                    width: Get.width * 0.07,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                        Border.all(color: Colors.black, width: 1)),
                    child: Icon(
                      Icons.clear,
                      size: Get.height * 0.02,
                    ),
                  ),
                ),
              ],
            ),
          ),
          dateAndTimeContainers(),
          SizedBox(
            height: Get.height * 0.03,
          ),
          timeGridView(),
          addButton()
        ],
      ),
    ),
  ));
}

Column timeGridView() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nov 17',
                style: TextStyle(
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins"),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
        child: SizedBox(
          height: Get.width * 0.25,
          child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: Get.width * 0.02,
              childAspectRatio: 1.5,
              children: List.generate(list.length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.01,
                  ),
                  child: Container(
                    // height: Get.height * 0.01,
                    width: Get.width * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Center(
                        child: Text(
                          list[index],
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: Get.height * 0.016,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                        )),
                  ),
                );
              })),
        ),
      ),
    ],
  );
}

Padding dateAndTimeContainers() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: Get.height * 0.05,
          width: Get.height * 0.12,
          // onPressed: () => _selectDate(context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1)),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Date',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.016),
              ),
              Icon(
                Icons.calendar_today_outlined,
                size: Get.height * 0.02,
              )
            ],
          ),
        ),
        Container(
          height: Get.height * 0.05,
          width: Get.height * 0.12,
          // onPressed: () => _selectDate(context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1)),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Time',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.016),
              ),
              Icon(
                Icons.access_time,
                size: Get.height * 0.02,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Padding addButton() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
    child: InkWell(
      onTap: () {
       Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [
                Color(0xFF3E5AEF),
                Color(0xFF6C0BB9),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        height: Get.height * 0.04,
        width: Get.width * 0.4,
        child: Center(
          child: Text(
            'Add',
            style: TextStyle(
              color: Colors.white,
              fontSize: Get.height * 0.016,
              fontWeight: FontWeight.w700,
              fontFamily: "Poppins",
            ),
          ),
        ),
      ),
    ),
  );
}
