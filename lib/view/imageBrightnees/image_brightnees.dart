import 'dart:io';
import 'dart:typed_data';

import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class EditPhotoScreen extends StatefulWidget {
  final List arguments;

  EditPhotoScreen({this.arguments});

  @override
  _EditPhotoScreenState createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  double sat = 1;
  double bright = 0;
  double con = 1;

  final defaultColorMatrix = const <double>[
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0
  ];

  List<double> calculateSaturationMatrix(double saturation) {
    final m = List<double>.from(defaultColorMatrix);
    final invSat = 1 - saturation;
    final R = 0.213 * invSat;
    final G = 0.715 * invSat;
    final B = 0.072 * invSat;

    m[0] = R + saturation;
    m[1] = G;
    m[2] = B;
    m[5] = R;
    m[6] = G + saturation;
    m[7] = B;
    m[10] = R;
    m[11] = G;
    m[12] = B + saturation;

    return m;
  }

  List<double> calculateContrastMatrix(double contrast) {
    final m = List<double>.from(defaultColorMatrix);
    m[0] = contrast;
    m[6] = contrast;
    m[12] = contrast;
    return m;
  }

  ScreenshotController screenshotController = ScreenshotController();

  File image;
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  void initState() {
    super.initState();
    image = widget.arguments[0];
  }

  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Edit Image",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Obx(
              () => IconButton(
                icon: Icon(
                  Icons.settings_backup_restore,
                  color: isLoading.value ? Colors.grey : Colors.white,
                ),
                onPressed: isLoading.value
                    ? null
                    : () {
                        setState(() {
                          sat = 1;
                          bright = 0;
                          con = 1;
                        });
                        print(image);
                      },
              ),
            ),
            Obx(() => IconButton(
                icon: Icon(
                  Icons.done,
                  color: isLoading.value ? Colors.grey : Colors.white,
                ),
                onPressed: isLoading.value
                    ? null
                    : () {
                        isLoading.value = true;
                        screenshotController
                            .capture()
                            .then((Uint8List image) async {
                          final directory =
                              await getApplicationDocumentsDirectory();
                          final imagePath =
                              await File('${directory.path}/image.png')
                                  .create();
                          await imagePath.writeAsBytes(image);
                          print('Done: ${imagePath.path}');
                          Navigator.pop(context, imagePath);
                          //File.fromRawPath(image);
                        }).catchError((e) {
                          print('Error: $e');
                          isLoading.value = false;
                        });
                      }))
          ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: buildImage(),
                  ),
                ),
                // Spacer(),
                Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.28,
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(flex: 3),
                        _buildSat(),
                        Spacer(flex: 1),
                        _buildBrightness(),
                        Spacer(flex: 1),
                        _buildCon(),
                        Spacer(flex: 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(() => isLoading.value ? loadingIndicator() : SizedBox())
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Screenshot(
      controller: screenshotController,
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(calculateContrastMatrix(con)),
        child: ColorFiltered(
          colorFilter: ColorFilter.matrix(calculateSaturationMatrix(sat)),
          child: ExtendedImage(
            color: bright > 0
                ? Colors.white.withOpacity(bright)
                : Colors.white.withOpacity(-bright),
            colorBlendMode: bright > 0 ? BlendMode.lighten : BlendMode.darken,
            image: ExtendedFileImageProvider(image),
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            extendedImageEditorKey: editorKey,
            //mode: ExtendedImageMode.editor,
            fit: BoxFit.contain,
            initEditorConfigHandler: (ExtendedImageState state) {
              return EditorConfig(
                maxScale: 8.0,
                hitTestSize: 20.0,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.brush,
                color: Colors.white.withOpacity(0.5),
              ),
              Text(
                "Saturation",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.4),
            label: 'sat : ${sat.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                sat = value;
              });
            },
            divisions: 50,
            value: sat,
            min: 0,
            max: 2,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            sat.toStringAsFixed(2),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildBrightness() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.brightness_4,
                color: Colors.white.withOpacity(0.5),
              ),
              Text(
                "Brightness",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.4),
            label: '${bright.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                bright = value;
              });
            },
            divisions: 50,
            value: bright,
            min: -1,
            max: 1,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            bright.toStringAsFixed(2),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.color_lens,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Center(
                child: Text(
                  "Contrast",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.4),
            label: 'con : ${con.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                con = value;
              });
            },
            divisions: 50,
            value: con,
            min: 0,
            max: 4,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            con.toStringAsFixed(2),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
