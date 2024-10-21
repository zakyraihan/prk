import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
    // required this.cameras,
  });

  // final List<CameraDescription> cameras;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final bool _isCameraInitialized = false;

  // CameraController? controller;

  // void onNewCameraSelected(CameraDescription cameraDescription) async {
  //   final previousCameraController = controller;

  //   final cameraController = CameraController(
  //     cameraDescription,
  //     ResolutionPreset.medium,
  //   );

  //   await previousCameraController!.dispose();

  //   try {
  //     cameraController.initialize();
  //   } catch (e) {
  //     print('error initializing camera $e');
  //   }

  //   if (mounted) {
  //     setState(() {
  //       controller = cameraController;
  //       _isCameraInitialized = controller!.value.isInitialized;
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   onNewCameraSelected(widget.cameras.first);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ambil Gambar"),
      ),
      // body: Center(
      //   child: Stack(
      //     children: [
      //       _isCameraInitialized
      //           ? CameraPreview(controller!)
      //           : const Center(
      //               child: CircularProgressIndicator(),
      //             ),
      //       Align(
      //         alignment: const Alignment(0, 0.95),
      //         child: _actionWidget(),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  Widget _actionWidget() {
    return FloatingActionButton(
      heroTag: "take-picture",
      tooltip: "Ambil Gambar",
      onPressed: () => _onCameraButtonClick(),
      child: const Icon(Icons.camera_alt),
    );
  }

  Future<void> _onCameraButtonClick() async {
    final navigator = Navigator.of(context);
    // final image = await controller?.takePicture();

    // navigator.pop(image);
  }
}
