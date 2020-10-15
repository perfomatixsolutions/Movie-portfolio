import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/const/constants.dart';
import 'package:movie_mock_list/model/profileDetailsModel.dart';
import 'package:movie_mock_list/services/database/dbHelper.dart';
import 'package:movie_mock_list/utils/utils.dart';
import 'package:path_provider/path_provider.dart';


List<CameraDescription> cameras;



IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError(UNKNOWN_LENS_DIRECTION);
}

class CameraWidget extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<CameraWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;
  bool showCamera = true;
  String imagePath;
  // Inputs
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController abvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  /// camera setup

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: showCamera
                        ? Container(
                      height: 500,
                      width: double.infinity,
                        child: cameraPreviewWidget(),
                    )
                        : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.check,color: Colors.white,size: 20,),
                                  Container(width: 10,),
                                  Text(SAVE,style: TextStyle(color:  Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                              onTap: ()
                              {
                                insertPath(imagePath,context);
                              },
                            ),
                          ),
                          imagePreviewWidget(),
                        ]),
                    /*   : Container(
                        width: double.infinity,
                        child: imagePreviewWidget(),
                      ),*/
                  ),
                  showCamera ? captureControlRowWidget() :  editCaptureControlRowWidget(),
                ],
              ),
            )));
  }

    /// fun to  recreate  controller when changing toggle operation

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('$CAMERA_ERROR ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      showInSnackBar('$CAMERA_ERROR $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// fun to enable toggle option

  Widget cameraOptionsWidget() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          showCamera ? cameraTogglesRowWidget() : Container(),
        ],
      ),
    );
  }

  /// fun to perform  toggle option

  Widget cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras != null) {
      if (cameras.isEmpty) {
        return const Text(NO_CAMERA);
      } else {
        for (CameraDescription cameraDescription in cameras) {
          toggles.add(
            SizedBox(
              width: 90.0,
              child: RadioListTile<CameraDescription>(
                title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
                groupValue: controller?.description,
                value: cameraDescription,
                onChanged: controller != null ? onNewCameraSelected : null,
              ),
            ),
          );
        }
      }
    }

    return Row(children: toggles);
  }

  /// fun to capture  camera

  Widget captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera),
          color: Colors.blue,iconSize: 50,
          onPressed: controller != null && controller.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }


  /// fun to Retake picture

  Widget editCaptureControlRowWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: IconButton(
        icon: const Icon(Icons.camera_alt_sharp),
        color: Colors.blue,
        iconSize: 50,
        onPressed: () => setState(() {
          showCamera = true;
        }),
      ),
    );
  }

  /// fun to take picture   when  pressing

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          showCamera = false;
          imagePath = filePath;
        });
      }
    });
  }

  ///Snackbar

  void showInSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  /// fun to take Picture

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/movie_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      return null;
    }
    return filePath;
  }

  /// camera preview Widget

  Widget cameraPreviewWidget() {
    if (!isReady || !controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller));
  }

  /// fun to provide timeStamp

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

 /// fun for image preview

  Widget imagePreviewWidget() {
    return Container(
       width: double.infinity,
        child: Image.file(File(imagePath)), );
  }

  /// fun to insert path

  void insertPath(String imagePath,BuildContext context) {
    DatabaseHelper db = new DatabaseHelper();
    var details = ProfileDetailsModel();
    details.imgPath = imagePath;
    db.insertImagePath(details).then((value) {
      setState(() {
     moveToLastScreen(context);
      });
    });
  }

}