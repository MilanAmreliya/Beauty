import 'dart:ui';

import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/small_profile_header.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/text_style.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/chat__viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:beuty_app/model/apiModel/responseModel/shop_sales_response_model.dart';

Container sliderUpPanelBody({String title}) {
  return Container(
    color: cDarkBlue,
    child: Column(
      children: [
        GetBuilder<ArtistProfileViewModel>(
          builder: (controller) {
            if (controller.artistProfileApiResponse.status == Status.COMPLETE) {
              ArtistProfileDetailResponse response =
                  controller.artistProfileApiResponse.data;
              return smallProfileHeader(
                  name: response.data.username ?? '',
                  subName: response.data.role ?? "",
                  imageUrl: response.data.image,
                  offset: 0.0);
            }
            if (controller.artistProfileApiResponse.status == Status.ERROR) {
              return Center(
                child: Text('Server Error'),
              );
            }
            return loadingIndicator();
          },
        ),
        Expanded(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: cWhite),
            child: GetBuilder<ChatViewModel>(
              builder: (controller) {
                if (controller.shopSalesApiResponse.status == Status.LOADING) {
                  return Center(
                    child: circularIndicator(),
                  );
                }
                if (controller.shopSalesApiResponse.status == Status.ERROR) {
                  return Center(child: Text("Server Error"));
                }

                ShopSalesResponse response =
                    controller.shopSalesApiResponse.data;
                if (response.data.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(response.message ?? 'N/A'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'No sale shop data available',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  );
                }
                response.data
                    .sort((a, b) => a.createdAt.compareTo(b.createdAt));
                int totalBalance = response.data.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + element.salePrice);
                int totalServices = response.data.length;
                List<_SalesData> data = [];
                response.data.forEach((element) {
                  data.add(_SalesData(
                      DateFormat('dd-MMM').format(element.createdAt),
                      element.salePrice.toDouble()));
                });
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: postTitleStyle(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: Get.height * 0.3,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_SalesData, String>>[
                          LineSeries<_SalesData, String>(
                              dataSource: data,
                              xValueMapper: (datum, index) => datum.year,
                              yValueMapper: (datum, index) => datum.sales,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Total',
                        ),
                        Spacer(),
                        Text(
                          'Services',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${totalBalance ?? 0}',
                          style: postTitleStyle(),
                        ),
                        Spacer(),
                        Text(
                          '${totalServices ?? 0}',
                          style: postTitleStyle(),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
