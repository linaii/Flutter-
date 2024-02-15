

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _textEditingController = TextEditingController();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) => print('onStatus: $val'),
//         onError: (val) => print('onError: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) => setState(() {
//             _textEditingController.text = val.recognizedWords;
//             if (val.hasConfidenceRating && val.confidence > 0) {
//               _showImages(val.recognizedWords);
//             }
//           }),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Viewer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter a word',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 String userInput = _textEditingController.text;
//                 _showImages(userInput);
//               },
//               child: Text('Show Images'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _listen,
//               child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// Future<void> _showImages(String userInput) async {
//   String directoryPath = 'assets/output_images/';
//   print("User Input: $userInput");
//   print("Directory Path: $directoryPath");

//   List<String> assetFiles = await rootBundle
//       .loadString('AssetManifest.json')
//       .then((String manifestContent) {
//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//     return manifestMap.keys
//         .where((String key) => key.startsWith(directoryPath))
//         .toList();
//   });

//   List<String> imageFiles = assetFiles.where((String assetPath) =>
//       assetPath.toLowerCase().endsWith('.jpg') ||
//       assetPath.toLowerCase().endsWith('.gif')).toList();

//   List<String> words = userInput.split(' '); // Tokenize the sentence into words

//   for (String word in words) {
//     String wordImagePath = '$directoryPath$word.gif';

//     if (imageFiles.contains(wordImagePath)) {
//       await _showDialogWithImage(wordImagePath);
//     } else {
//       for (int i = 0; i < word.length; i++) {
//         String letter = word[i];
//         String letterImagePath = imageFiles.firstWhere(
//           (assetPath) => assetPath.toLowerCase().endsWith('$letter.jpg'),
//           orElse: () => '',
//         );
//         if (letterImagePath.isNotEmpty) {
//           await _showDialogWithImage(letterImagePath);
//         } else {
//           print('No image found for $letter');
//         }
//       }
//     }
//   }
// }

  

//   Future<void> _showDialogWithImage(String imagePath) async {
//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Image.asset(imagePath),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await _downloadImage(imagePath);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Download'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _downloadImage(String assetPath) async {
//     try {
//       final ByteData data = await rootBundle.load(assetPath);
//       final List<int> bytes = data.buffer.asUint8List();

//       final result = await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));

//       if (result != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Image saved to gallery.'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save image to gallery.'),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error downloading image: $e');
//     }
//   }
// }







// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _textEditingController = TextEditingController();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) => print('onStatus: $val'),
//         onError: (val) => print('onError: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) => setState(() {
//             _textEditingController.text = val.recognizedWords;
//             if (val.hasConfidenceRating && val.confidence > 0) {
//               _showImages(val.recognizedWords);
//             }
//           }),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Viewer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter a word',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 String userInput = _textEditingController.text;
//                 _showImages(userInput);
//               },
//               child: Text('Show Images'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _listen,
//               child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _showImages(String userInput) async {
//     String directoryPath = 'assets/output_images/';
//     print("User Input: $userInput");
//     print("Directory Path: $directoryPath");

//     List<String> assetFiles = await rootBundle
//         .loadString('AssetManifest.json')
//         .then((String manifestContent) {
//       final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//       return manifestMap.keys
//           .where((String key) => key.startsWith(directoryPath))
//           .toList();
//     });

//     List<String> imageFiles = assetFiles.where((String assetPath) =>
//         assetPath.toLowerCase().endsWith('.jpg') ||
//         assetPath.toLowerCase().endsWith('.gif')).toList();

//     List<String> words = userInput.split(' '); 
//     int totalImages = words.length;
//     int currentImageIndex = 0;

//     for (String word in words) {
//       String wordImagePath = '$directoryPath$word.gif';

//       if (imageFiles.contains(wordImagePath)) {
//         await _showDialogWithImage(wordImagePath, currentImageIndex == totalImages - 1);
//         await Future.delayed(Duration(seconds: 3));
//       } else {
//         for (int i = 0; i < word.length; i++) {
//           String letter = word[i];
//           String letterImagePath = imageFiles.firstWhere(
//             (assetPath) => assetPath.toLowerCase().endsWith('$letter.jpg'),
//             orElse: () => '',
//           );
//           if (letterImagePath.isNotEmpty) {
//             await _showDialogWithImage(letterImagePath, currentImageIndex == totalImages - 1);
//             await Future.delayed(Duration(seconds: 3));
//           } else {
//             print('No image found for $letter');
//           }
//         }
//       }
//       currentImageIndex++;
//     }
//   }

//   Future<void> _showDialogWithImage(String imagePath, bool isLastImage) async {
//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Image.asset(imagePath),
//           actions: isLastImage ? [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await _downloadImage(imagePath);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Download'),
//             ),
//           ] : [],
//         );
//       },
//     );
//   }
// Future<void> _downloadImages(List<String> assetPaths) async {
//   try {
//     final List<Uint8List> imageBytesList = [];
//     final Directory tempDir = await getTemporaryDirectory();

//     for (String assetPath in assetPaths) {
//       final ByteData data = await rootBundle.load(assetPath);
//       final List<int> bytes = data.buffer.asUint8List();
//       imageBytesList.add(Uint8List.fromList(bytes));
//     }

//     final String tempPath = '${tempDir.path}/temp.mp4';

//     final FlutterFFmpeg ffmpeg = FlutterFFmpeg();
//     final String command = '-y -f image2 -i %d.jpg -vcodec libx264 -crf 25 -pix_fmt yuv420p $tempPath';
//     await ffmpeg.executeWithArguments(command.split(' '));

//     final result = await ImageGallerySaver.saveFile(tempPath);

//     if (result != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Video saved to gallery.'),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to save video to gallery.'),
//         ),
//       );
//     }

//     File(tempPath).deleteSync();
//   } catch (e) {
//     print('Error creating video: $e');
//   }
// }
// List<String> imageAssetPaths = [
//   'assets/image1.jpg',
//   'assets/image2.jpg',
//   'assets/image3.jpg',
//   // Add more image paths as needed
// ];

// _downloadImages(imageAssetPaths);

// }





// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _textEditingController = TextEditingController();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) => print('onStatus: $val'),
//         onError: (val) => print('onError: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) => setState(() {
//             _textEditingController.text = val.recognizedWords;
//             if (val.hasConfidenceRating && val.confidence > 0) {
//               _showImages(val.recognizedWords);
//             }
//           }),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Viewer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter a word',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 String userInput = _textEditingController.text;
//                 _showImages(userInput);
//               },
//               child: Text('Show Images'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _listen,
//               child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _showImages(String userInput) async {
//     String directoryPath = 'assets/output_images/';
//     print("User Input: $userInput");
//     print("Directory Path: $directoryPath");

//     List<String> assetFiles = await rootBundle
//         .loadString('AssetManifest.json')
//         .then((String manifestContent) {
//       final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//       return manifestMap.keys
//           .where((String key) => key.startsWith(directoryPath))
//           .toList();
//     });

//     List<String> imageFiles = assetFiles.where((String assetPath) =>
//         assetPath.toLowerCase().endsWith('.jpg') ||
//         assetPath.toLowerCase().endsWith('.gif')).toList();

//     List<String> words = userInput.split(' ');
//     int totalImages = words.length;
//     int currentImageIndex = 0;

//     for (String word in words) {
//       String wordImagePath = '$directoryPath$word.gif';

//       if (imageFiles.contains(wordImagePath)) {
//         await _showDialogWithImage(wordImagePath, currentImageIndex == totalImages - 1);
//         await Future.delayed(Duration(seconds: 3));
//       } else {
//         for (int i = 0; i < word.length; i++) {
//           String letter = word[i].toLowerCase();
//           String letterImagePath = imageFiles.firstWhere(
//             (assetPath) => assetPath.toLowerCase().endsWith('/$letter.jpg'),
//             orElse: () => '',
//           );
//           if (letterImagePath.isNotEmpty) {
//             await _showDialogWithImage(letterImagePath, currentImageIndex == totalImages - 1);
//             await Future.delayed(Duration(seconds: 3));
//           } else {
//             print('No image found for $letter');
//           }
//         }
//       }
//       currentImageIndex++;
//     }
//   }

//   Future<void> _showDialogWithImage(String imagePath, bool isLastImage) async {
//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Image.asset(imagePath),
//           actions: isLastImage ? [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await _downloadImage(imagePath);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Download'),
//             ),
//           ] : [],
//         );
//       },
//     );
//   }

//   Future<void> _downloadImage(String imagePath) async {
//     try {
//       final ByteData data = await rootBundle.load(imagePath);
//       final Uint8List bytes = data.buffer.asUint8List();

//       final result = await ImageGallerySaver.saveImage(bytes);

//       if (result != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Image saved to gallery.'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save image to gallery.'),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error saving image: $e');
//     }
//   }
// }





















// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _textEditingController = TextEditingController();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   List<String> _imagePaths = [];
//   int _currentIndex = 0;
//   bool _showDownloadButton = false;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) => print('onStatus: $val'),
//         onError: (val) => print('onError: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) => setState(() {
//             _textEditingController.text = val.recognizedWords;
//             if (val.hasConfidenceRating && val.confidence > 0) {
//               _showImages(val.recognizedWords);
//             }
//           }),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   void _showImages(String userInput) async {
//     String directoryPath = 'assets/output_images/';
//     List<String> assetFiles = await rootBundle.loadString('AssetManifest.json').then((String manifestContent) {
//       final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//       return manifestMap.keys.where((String key) => key.startsWith(directoryPath)).toList();
//     });

//     List<String> imageFiles = assetFiles.where((String assetPath) =>
//         assetPath.toLowerCase().endsWith('.jpg') || assetPath.toLowerCase().endsWith('.gif')).toList();

//     List<String> words = userInput.split(' ');

//     _imagePaths.clear();

//     for (String word in words) {
//       String wordImagePath = '$directoryPath$word.gif';

//       if (imageFiles.contains(wordImagePath)) {
//         _imagePaths.add(wordImagePath);
//       } else {
//         for (int i = 0; i < word.length; i++) {
//           String letter = word[i];
//           String letterImagePath = imageFiles.firstWhere(
//             (assetPath) => assetPath.toLowerCase().endsWith('$letter.jpg'),
//             orElse: () => '',
//           );
//           if (letterImagePath.isNotEmpty) {
//             _imagePaths.add(letterImagePath);
//           } else {
//             print('No image found for $letter');
//           }
//         }
//       }
//     }

//     _currentIndex = 0;
//     _showDownloadButton = false;

//     _startImageTimer();
//   }

//   void _startImageTimer() {
//     Timer.periodic(Duration(seconds: 3), (timer) {
//       setState(() {
//         if (_currentIndex < _imagePaths.length - 1) {
//           _currentIndex++;
//         } else {
//           timer.cancel();
//           _showDownloadButton = true;
//         }
//       });
//     });
//   }

//   Future<void> _downloadImagesAndCreateVideo() async {
//     FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

//     List<String> imagePaths = _imagePaths;

//     try {
//       // Get the directory for saving videos
//       final Directory? appDir = await getExternalStorageDirectory();
//       final String appDirPath = appDir!.path;

//       // Define the output video file path
//       String outputVideoPath = path.join(appDirPath, 'video.mp4');

//       // Prepare a list of commands to concatenate images into a video
//       List<String> commands = [
//         '-y', // Overwrite output file if it exists
//         '-framerate', '1/3', // Set framerate to 1 image every 3 seconds
//         '-i', 'image%d.jpg', // Input files (images)
//         '-c:v', 'libx264', // Video codec
//         '-r', '30', // Output video frame rate
//         outputVideoPath // Output file path
//       ];

//       // Execute the FFmpeg command
//       int rc = await _flutterFFmpeg.executeWithArguments(commands);

//       if (rc == 0) {
//         // Save the video in the gallery
//         await _saveVideoToGallery(outputVideoPath);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Video saved to gallery.'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save video.'),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error creating video: $e');
//     }
//   }

//   Future<void> _saveVideoToGallery(String videoPath) async {
//     try {
//       final result = await ImageGallerySaver.saveFile(videoPath);
//       if (result != null) {
//         print('Video saved to gallery: $videoPath');
//       } else {
//         print('Failed to save video to gallery.');
//       }
//     } on PlatformException catch (e) {
//       print('Error saving video to gallery: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Viewer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter a word',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 String userInput = _textEditingController.text;
//                 _showImages(userInput);
//               },
//               child: Text('Show Images'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _listen,
//               child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
//             ),
//             SizedBox(height: 16.0),
//             if (_imagePaths.isNotEmpty)
//               Image.asset(
//                 _imagePaths[_currentIndex],
//                 fit: BoxFit.cover,
//               ),
//             if (_showDownloadButton)
//               ElevatedButton(
//                 onPressed: _downloadImagesAndCreateVideo,
//                 child: Text('Download Video'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }












// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _textEditingController = TextEditingController();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   List<String> _imagePaths = [];
//   int _currentIndex = 0;
//   bool _showDownloadButton = false;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) => print('onStatus: $val'),
//         onError: (val) => print('onError: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) => setState(() {
//             _textEditingController.text = val.recognizedWords;
//             if (val.hasConfidenceRating && val.confidence > 0) {
//               _showImages(val.recognizedWords);
//             }
//           }),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   void _showImages(String userInput) async {
//     String directoryPath = 'assets/output_images/';
//     List<String> assetFiles = await rootBundle.loadString('AssetManifest.json').then((String manifestContent) {
//       final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//       return manifestMap.keys.where((String key) => key.startsWith(directoryPath)).toList();
//     });

//     List<String> imageFiles = assetFiles.where((String assetPath) =>
//         assetPath.toLowerCase().endsWith('.jpg') || assetPath.toLowerCase().endsWith('.gif')).toList();

//     List<String> words = userInput.split(' ');

//     _imagePaths.clear();

//     for (String word in words) {
//       String wordImagePathGif = '$directoryPath$word.gif';
//       String wordImagePathJpg = '$directoryPath$word.jpg';

//       if (imageFiles.contains(wordImagePathGif)) {
//         _imagePaths.add(wordImagePathGif);
//       } else if (imageFiles.contains(wordImagePathJpg)) {
//         _imagePaths.add(wordImagePathJpg);
//       } else {
//         for (int i = 0; i < word.length; i++) {
//           String letter = word[i];
//           String letterImagePathJpg = imageFiles.firstWhere(
//             (assetPath) => assetPath.toLowerCase().endsWith('$letter.jpg'),
//             orElse: () => '',
//           );
//           String letterImagePathGif = imageFiles.firstWhere(
//             (assetPath) => assetPath.toLowerCase().endsWith('$letter.gif'),
//             orElse: () => '',
//           );
//           if (letterImagePathJpg.isNotEmpty) {
//             _imagePaths.add(letterImagePathJpg);
//           } else if (letterImagePathGif.isNotEmpty) {
//             _imagePaths.add(letterImagePathGif);
//           } else {
//             print('No image found for $letter');
//           }
//         }
//       }
//     }

//     setState(() {
//       _currentIndex = 0;
//       _showDownloadButton = false;
//     });

//     _startImageTimer();
//   }

//   void _startImageTimer() {
//     Timer.periodic(Duration(seconds: 3), (timer) {
//       setState(() {
//         if (_currentIndex < _imagePaths.length - 1) {
//           _currentIndex++;
//         } else {
//           timer.cancel();
//           setState(() {
//             _showDownloadButton = true;
//           });
//         }
//       });
//     });
//   }

//   Future<void> _downloadImagesAndCreateVideo() async {
//     try {
//       final List<String> imagePaths = _imagePaths;

//       final Directory appDir = await getTemporaryDirectory();
//       final String tempDirPath = appDir.path;

//       List<String> convertedImagePaths = [];

//       // Convert all images to a consistent format (GIF)
//       for (int i = 0; i < imagePaths.length; i++) {
//         final String imagePath = imagePaths[i];
//         final ByteData imageData = await rootBundle.load(imagePath);
//         final Uint8List bytes = imageData.buffer.asUint8List();
//         final String imageExtension = path.extension(imagePath).toLowerCase();
//         final String imageName = 'image$i$imageExtension';
//         final File imageFile = File('$tempDirPath/$imageName');
//         await imageFile.writeAsBytes(bytes);
//         convertedImagePaths.add(imageFile.path); // Update converted image paths
//       }

//       final String imageListPath = '$tempDirPath/imageList.txt';

//       // Write list of converted image paths to a text file
//       final File imageListFile = File(imageListPath);
//       await imageListFile.writeAsString(convertedImagePaths.map((e) => 'file $e').join('\n'));

//       final String outputVideoPath = '${appDir.path}/video.mp4';

//       final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
//       final int rc = await _flutterFFmpeg.execute(
//         '-y -f concat -safe 0 -i $imageListPath -c:v mpeg4 -vf fps=25 -pix_fmt yuv420p $outputVideoPath',
//       );

//       if (rc == 0) {
//         await _saveVideoToGallery(outputVideoPath);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Video saved to gallery.'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save video.'),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error creating video: $e');
//     }
//   } 




//   Future<void> _saveVideoToGallery(String videoPath) async {
//     try {
//       final result = await ImageGallerySaver.saveFile(videoPath);
//       if (result != null) {
//         print('Video saved to gallery: $videoPath');
//       } else {
//         print('Failed to save video to gallery.');
//       }
//     } on PlatformException catch (e) {
//       print('Error saving video to gallery: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Viewer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter a word',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 String userInput = _textEditingController.text;
//                 _showImages(userInput);
//               },
//               child: Text('Show Images'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _listen,
//               child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
//             ),
//             SizedBox(height: 16.0),
//             if (_imagePaths.isNotEmpty)
//               Image.asset(
//                 _imagePaths[_currentIndex],
//                 fit: BoxFit.cover,
//               ),
//             if (_showDownloadButton)
//               ElevatedButton(
//                 onPressed: _downloadImagesAndCreateVideo,
//                 child: Text('Download Video'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }











import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  List<String> _imagePaths = [];
  int _currentIndex = 0;
  bool _showDownloadButton = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _textEditingController.text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _showImages(val.recognizedWords);
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _showImages(String userInput) async {
    String directoryPath = 'assets/output_images/';
    List<String> assetFiles = await rootBundle.loadString('AssetManifest.json').then((String manifestContent) {
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      return manifestMap.keys.where((String key) => key.startsWith(directoryPath)).toList();
    });

    List<String> imageFiles = assetFiles.where((String assetPath) =>
        assetPath.toLowerCase().endsWith('.jpg') || assetPath.toLowerCase().endsWith('.gif')).toList();

    List<String> words = userInput.split(' ');

    _imagePaths.clear();

    for (String word in words) {
      String wordImagePath = '$directoryPath$word.gif';

      if (imageFiles.contains(wordImagePath)) {
        _imagePaths.add(wordImagePath);
      } else {
        for (int i = 0; i < word.length; i++) {
          String letter = word[i];
          String letterImagePath = imageFiles.firstWhere(
            (assetPath) => assetPath.toLowerCase().endsWith('$letter.jpg'),
            orElse: () => '',
          );
          if (letterImagePath.isNotEmpty) {
            _imagePaths.add(letterImagePath);
          } else {
            print('No image found for $letter');
          }
        }
      }
    }

    setState(() {
      _currentIndex = 0;
      _showDownloadButton = false;
    });

    _startImageTimer();
  }

  void _startImageTimer() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (_currentIndex < _imagePaths.length - 1) {
          _currentIndex++;
        } else {
          timer.cancel();
          setState(() {
            _showDownloadButton = true;
          });
        }
      });
    });
  }
  Future<void> _downloadImagesAndCreateVideo() async {
  try {
    final List<String> imagePaths = _imagePaths;

    final Directory appDir = await getTemporaryDirectory();
    final String tempDirPath = appDir.path;

    // Load images from assets and save them to temporary directory with their original extensions
    for (int i = 0; i < imagePaths.length; i++) {
      final String imagePath = imagePaths[i];
      final ByteData imageData = await rootBundle.load(imagePath);
      final Uint8List bytes = imageData.buffer.asUint8List();

      // Determine the file extension to preserve the image type
      String extension = path.extension(imagePath).toLowerCase();
      if (extension.isEmpty) {
        extension = '.jpg'; // Default to jpg if no extension found
      }

      final File imageFile = File('$tempDirPath/image$i$extension');
      await imageFile.writeAsBytes(bytes);
      imagePaths[i] = imageFile.path; // Update image paths with the correct extension
    }

    final String imageListPath = '$tempDirPath/imageList.txt';

    // Write list of image paths to a text file
    final File imageListFile = File(imageListPath);
    await imageListFile.writeAsString(imagePaths.map((e) => 'file $e').join('\n'));

    final String outputVideoPath = '${appDir.path}/video.mp4';

    final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
    final int rc = await _flutterFFmpeg.execute(
      '-y -f concat -safe 0 -i $imageListPath -c:v mpeg4 -vf fps=10 -pix_fmt yuv420p $outputVideoPath',
    );

    if (rc == 0) {
      await _saveVideoToGallery(outputVideoPath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video saved to gallery.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save video.'),
        ),
      );
    }
  } catch (e) {
    print('Error creating video: $e');
  }
}





  Future<void> _saveVideoToGallery(String videoPath) async {
    try {
      final result = await ImageGallerySaver.saveFile(videoPath);
      if (result != null) {
        print('Video saved to gallery: $videoPath');
      } else {
        print('Failed to save video to gallery.');
      }
    } on PlatformException catch (e) {
      print('Error saving video to gallery: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Enter a word',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String userInput = _textEditingController.text;
                _showImages(userInput);
              },
              child: Text('Show Images'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _listen,
              child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
            ),
            SizedBox(height: 16.0),
            if (_imagePaths.isNotEmpty)
              Image.asset(
                _imagePaths[_currentIndex],
                fit: BoxFit.cover,
              ),
            if (_showDownloadButton)
              ElevatedButton(
                onPressed: _downloadImagesAndCreateVideo,
                child: Text('Download Video'),
              ),
          ],
        ),
      ),
    );
  }
}