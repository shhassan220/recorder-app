import 'package:path/path.dart' as path;

import 'dart:async';
import 'dart:html';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:recording_app/Widget/drawer.dart';

void main() {
  runApp(AudioRecorder());
}

class AudioRecorder extends StatefulWidget {
  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {



FlutterSoundRecorder _myRecorder;
  final audioPlayer = AssetsAudioPlayer();
  String filePath;
  bool _play = false;
  String _recorderTxt = '00:00:00';

  @override
  void initState() {
    super.initState();
    startIt();
  }

  void startIt() async {
    filePath = '/sdcard/Download/temp.wav';
    _myRecorder = FlutterSoundRecorder();

    await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }







  // final _recorder = FlutterSoundRecorder();
  // bool isRecorderReady = false;

  // Future _recoder () async {
  //   await _recorder.startRecorder(toFile: 'audio');
  // }
  // Future stop () async {

  //   if(!isRecorderReady) return;

  //   final path = await _recorder.stopRecorder();
  //   // final audioFile = File(path);
  //   // print('Recorded Audio: $audioFile');
  // } 

  // @override
  // void initState() {
  //   initRecorder();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _recorder.closeRecorder();
  //   super.dispose();
  // }

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();

  //   if(status != PermissionStatus.granted){
  //     throw 'MicroPhone Permission not granted';
  //   }
  //   await _recorder.openRecorder();
  //   _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  // }

  // FlutterSoundRecorder? _myRecorder;
  // final audioPlayer = AssetsAudioPlayer();
  // String? filePath;
  // bool _play = false;
  // String _recorderText = '00:00:00';



  // void startIt () async {
  //   filePath = '/sdcard/Download/temp.wav';
  //   _myRecorder = FlutterSoundRecorder();
  //    await _myRecorder.openAudioSession(
  //       focus: AudioFocus!.requestFocusAndStopOthers,
  //       category: SessionCategory.playAndRecord,
  //       mode: SessionMode.modeDefault,
  //       device: AudioDevice.speaker);
  // }

  
  bool iconBool = false;
  IconData _iconLight = Icons.wb_sunny;
  IconData _iconDark = Icons.nights_stay;

  ThemeData _themeLight = ThemeData(
    primarySwatch: Colors.amber,
    brightness: Brightness.light,
  );
  ThemeData _themeDark = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: iconBool ? _themeDark : _themeLight,
      home: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          // backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                // color: Colors.amberAccent,
              ),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    iconBool = !iconBool;
                  });
                },
                icon: Icon(
                  iconBool ? _iconDark : _iconLight,
                  // color: Colors.amberAccent,
                  size: 31,
                ),
              ),
            ],
          ),
          drawer: DrawerScreen(
              // size: size,
              ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: _recorder.onProgress,
                  builder: (context, snapshot){
                  final duration = snapshot.hasData ? snapshot.data!.duration :Duration.zero;
                  String twoDigits (int n) => n.toString().padLeft(60);
                  // final twoDigitsHours = twoDigits(duration.inHours).reminder(12)),
                  final twoDigitsMinutes = twoDigits(duration.inMinutes).reminder(60));
                  final twoDigitsSeconds = twoDigits(duration.inSeconds).reminder(60));
                  return Text("$twoDigitsMinutes:$twoDigitSeconds");
                })
                // Text(
                //   "00:00:02",
                //   style: TextStyle(
                //     fontSize: 71,
                //   ),
                //   ),
                  SizedBox(height: 55,),
                  Container(
                    height: 95,
                    width: 95,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(45),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 35,
                        ),
                      ],
                    ),
                    child: Icon(Icons.circle, size: 31, color: Colors.white,),
                  ),
                  // SizedBox(height: 55,),
                  Padding(
                    padding: EdgeInsets.all(45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButtons(
                          icon: Icons.pause,
                          f: () async {
                            if (_recorder.isRecording){
                              await stop();                            }
                          }
                          else{
                            await record(); 
                          }
                        ),
                           IconButtons(
                          icon: Icons.music_note,
                          f: (){},
                        ),
                           IconButtons(
                          icon: Icons.settings,
                          f: (){},
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton IconButtons({IconData? icon, VoidCallback? f,}) {
    return IconButton(
                        onPressed: f,
                         icon: Icon(icon, size: 45,));
  }
}

var scaffoldKey = GlobalKey<ScaffoldState>();
