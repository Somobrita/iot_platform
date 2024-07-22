import 'dart:io';

import 'package:asset_tracker/resource/app_resource.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

// Singleton class
class Utils {
  // Private constructor
  Utils._();

  // Singleton instance
  // The one and only instance of this singleton
  // In Dart, all global variables are lazy-loaded naturally. This implies
  // that they are possibly initialized when they are first utilized.
  static final Utils _instance = Utils._();

  // Factory constructor to get the instance
  factory Utils() {
    return _instance;
  }

  final Logger logger = Logger(AppTexts.appName);

  Future<String> get _localPath async {
    var directory = await getExternalStorageDirectory();
    directory ??= await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/asset_tracker.txt');
  }

  void setupLogging() async {
    File file = await _localFile;
    Logger.root.level = Level.ALL; // Set the logging level
    Logger.root.onRecord.listen((record) {
      // Print log messages to the console
      print('${record.level.name}: ${record.time}: ${record.message}');

      // Write log messages to a file
      file.writeAsStringSync(
        '${record.level.name}: ${record.time}: ${record.message}\n',
        mode: FileMode.append,
      );
    });
  }

  Future<void> downloadFile(String fileUrl) async {
    print('fileUrl $fileUrl');
    //You can download a single file
    FileDownloader.downloadFile(
      url: fileUrl,
      //name: 'alarm_mindteck', //THE FILE NAME AFTER DOWNLOADING,
      onProgress: (String? fileName, double progress) {
        print('FILE fileName HAS PROGRESS $progress');
      },
      onDownloadCompleted: (String path) {
        print('FILE DOWNLOADED TO PATH: $path');
        final File file = File(path);
        //This will be the path of the downloaded file
        print('FILE DOWNLOADED TO file: $file');
      },
      onDownloadError: (String error) {
        print('FILE DOWNLOAD ERROR: $error');
      },
      notificationType: NotificationType.all,
      downloadDestination: DownloadDestinations.publicDownloads,
    );
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blueAccent,
            size: 70,
          ),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Please wait...")),
        ],
      ),
    );
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const SizedBox.expand(child: FlutterLogo()),
        );
      },
      transitionBuilder: (ctx, anim, a2, child) {
        var curve = Curves.easeInOut.transform(anim.value);
        return Transform.scale(
          scale: curve,
          filterQuality: FilterQuality.medium,
          child: alert,
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: false,
      barrierLabel: "Barrier",
      barrierColor: Colors.black.withOpacity(0.5),
    );
    /*showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );*/
  }

  void downloadFileDialog(BuildContext context, String downloadUrl) {
    showModalBottomSheet(
      useRootNavigator: true,
      //isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10),
          //color: Theme.of(context).colorScheme.background,
          //height: 180,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              InkWell(
                splashColor: Colors.black26, // Change the splash color
                //radius: 60, // Change the highlight shape
                borderRadius: BorderRadius.circular(20),
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("assets/images/csv.png"),
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 20,
                ),
                title: Text(
                  AppTexts.csv,
                  style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 15,
                      ),
                ),
                onTap: () {
                  // Handle the selection of Item 1.
                  print('CSV 1 selected');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.picture_as_pdf,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  AppTexts.pdf,
                  style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 15,
                      ),
                ),
                onTap: () {
                  // Handle the selection of Item 2.
                  Utils().downloadFile(downloadUrl);
                  print('PDF 2 selected');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

}
