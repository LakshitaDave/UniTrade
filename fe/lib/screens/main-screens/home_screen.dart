import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smilestone/Utils/size_config.dart';
import 'package:smilestone/constants/app_colors.dart';
import 'package:smilestone/screens/main-screens/display_image_screen.dart';
import 'package:smilestone/screens/main-screens/display_video_screen.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isFlashOn = false;
  bool isCameraInitialized = false;
  bool backCamera = true;
  bool isRecording = false;
  FlashMode currentFlashMode = FlashMode.off;
  final FlutterSoundPlayer _soundPlayer = FlutterSoundPlayer();

  final List<Map<String, String>> animalList = [
    {'sound': 'lib/assets/sounds/cat_meow.mp3', 'image': 'lib/assets/dog.png'},
    {'sound': 'lib/assets/sounds/cat_meow.mp3', 'image': 'lib/assets/cat.png'},
    {'sound': 'lib/assets/sounds/cat_meow.mps', 'image': 'lib/assets/bear.png'},
    {'sound': 'lib/assets/sounds/cat_meow.mp3', 'image': 'lib/assets/dog.png'},
    {'sound': 'lib/assets/sounds/cat_meow.mp3', 'image': 'lib/assets/cat.png'},
    {'sound': 'lib/assets/sounds/cat_meow.mps', 'image': 'lib/assets/bear.png'},
    {'sound': 'lib/assets/sounds/cat_meow.mp3', 'image': 'lib/assets/dog.png'},
    {'sound': 'lib/assets/sounds/cat_meow.mp3', 'image': 'lib/assets/cat.png'},
    {'sound': 'lib/assets/sounds/cat_meow.mps', 'image': 'lib/assets/dog.png'},
    // Add more animals here
  ];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    WidgetsFlutterBinding.ensureInitialized();
    _soundPlayer.openPlayer();
  }


  Future<void> _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final status = await Permission.camera.request();
    if (status.isGranted) {
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        controller = CameraController(cameras![backCamera ?0:1], ResolutionPreset.high);
        await controller!.initialize();
        setState(() {
          isCameraInitialized = true;
        });
      } else {
        print('No camera available');
      }
    } else {
      print('Camera permission denied');
    }
  }
  void _startVideoRecording() async {
    if (controller != null && controller!.value.isInitialized && !isRecording) {
      try {
        await controller!.startVideoRecording();
        setState(() {
          isRecording = true;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void _stopVideoRecording() async {
    if (controller != null && controller!.value.isInitialized && isRecording) {
      try {
        final videoFile = await controller!.stopVideoRecording();
        setState(() {
          isRecording = false;
        });
        // Handle the saved video file here
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayVideoScreen(videoPath: videoFile.path),
          ),
        );
      } catch (e) {
        print(e);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight / 9,),
             Center(child: Text("UniTrade",style: TextStyle(
                fontSize: 30,color: greenButtonColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),)),
            //Image.asset('lib/assets/app_name.png'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(

                child: Container(
                  height: screenHeight / 1.8,
                  width: screenWidth/1.2,

                  child: isCameraInitialized
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: CameraPreview(controller!))
                      : Center(child: CircularProgressIndicator()),
                ),
              ),

            ),
            //SizedBox(height: screenHeight / 30,),
            // Container(
            //   height: screenHeight * 0.08,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: animalList.length,
            //     itemBuilder: (context, index) {
            //       return _buildAnimalButton(animalList[index]['sound']!, animalList[index]['image']!);
            //     },
            //   ),
            // ),
            SizedBox(height: screenHeight / 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(0.0, 600, 100, 10),
                    items: [
                      PopupMenuItem(
                        child: Text(
                          'Flashlight Off',
                          style: TextStyle(color: Colors.yellow),
                        ),
                        value: 'off',
                      ),
                      PopupMenuItem(
                        child: Text('Flashlight On'),
                        value: 'on',
                      ),
                      PopupMenuItem(
                        child: Text('Auto'),
                        value: 'auto',
                      ),
                    ],
                    color: Colors.black12,
                  ).then((value) {
                    if (value == 'on') {
                      controller?.setFlashMode(FlashMode.torch);
                      isFlashOn=true;
                    } else if (value == 'off') {
                      controller?.setFlashMode(FlashMode.off);
                      isFlashOn=false;
                    } else if (value == 'auto') {
                      controller?.setFlashMode(FlashMode.auto);
                      isFlashOn=false;
                    }
                  });
                },
                  icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off, size: 35,),
                  color: greenButtonColor,),
                IconButton(onPressed: () {},
                  icon: Icon(Icons.electric_bolt, size: 35,),
                  color: greenButtonColor,),
                IconButton(onPressed: () async {
                  XFile picture = await controller!.takePicture();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayImageScreen(imagePath: picture.path),
                    ),
                  );
                },
                  icon: Icon(Icons.camera, size: 35,),
                  color: Colors.yellow[600],),
                IconButton(onPressed: isRecording ? _stopVideoRecording : _startVideoRecording,
                  icon: Icon(isRecording ? Icons.stop : Icons.videocam_outlined, size: 35,),
                  color: greenButtonColor,),
                IconButton(onPressed: () {
                  if (cameras != null && cameras!.length > 1) {
                    setState(() {
                      backCamera = !backCamera;
                      _initializeCamera();
                    });

                  }
                },
                  icon: Icon(Icons.flip_camera_ios_outlined, size: 35,),
                  color: greenButtonColor,),
              ],
            )
          ],
        ),
      ),

    );
  }
  Widget _buildAnimalButton(String soundPath, String imagePath) {
    return GestureDetector(
      onTap: () async {
        //await _soundPlayer.openPlayer();
        await _soundPlayer.startPlayer(fromURI: soundPath,codec: Codec.mp3);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
      ),
    );
  }

}
