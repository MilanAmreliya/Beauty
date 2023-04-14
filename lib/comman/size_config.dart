import 'package:get/get.dart';

double getProportionateScreenHeight(double inputHeight) {
  // 812 is the layout height that designer use
  // print(
  //     "HEIGHT ${(inputHeight / 812.0) * Get.height} ${inputHeight} ${Get.height}");
  return (inputHeight / 812.0) * Get.height;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  // 375 is the lay  print("WIDTH ${(inputWidth / 375.0) * Get.width} ${inputWidth} ${Get.width}");out width that designer use
  return (inputWidth / 375.0) * Get.width;
}