import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/util.dart';


class ImageView extends StatefulWidget {
  final String imgUrl;

  ImageView({required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  Future<void> setLock() async{
    await Permission.storage.request();
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    final bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    if (result == true){
    Utils.showSuccess('wallpaper set successfully');
    }
    else{
      Utils.showError('wallpaper not set');
    }
    print(result);
 // Navigator.pop(context);
  }

  Future<void> setHome() async{
   await Permission.storage.request();
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    final bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    if (result == true){
      Utils.showSuccess('wallpaper set successfully');
    }
    else{
    Utils.showError('wallpaper not set');
    }
   // Navigator.pop(context);
    print(result);

  }

  Future<void> setBoth() async{
    await Permission.storage.request();
    int location = WallpaperManager.BOTH_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    final bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    if (result == true){
     Utils.showSuccess('wallpaper set successfully');
    }
    else{
      Utils.showError('wallpaper not set');
    }
    Navigator.pop(context);
    print(result);

  }

//toast permission granted
_saveimg() async{
    var status = await Permission.storage.request();
    if(status.isGranted){
  var response = await Dio().get(widget.imgUrl,options: Options(responseType: ResponseType.bytes));
  final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  if ( result == false ) {
   Utils.showError('Image not Saved');
  } else{
   Utils.showSuccess('Saved to Gallery');
  }

} else if(status.isDenied) {
      Fluttertoast.showToast(msg: "Give Storage permissions from Settings");
    await Permission.storage.request();
    }
else{
      await Permission.storage.request();
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          )
      ),
      floatingActionButton:  FloatingActionButton(
                onPressed: (){
                  _saveimg();

                },
                child:
                const Icon(Icons.download_rounded)
                ),
        body: Stack(
  children: <Widget>[
    Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.3)],
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.imgUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => CircularProgressIndicator(), // Use a custom loading animation
      ),
    ),
    Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                setHome();
              },
              child: Text(
                'Set to Home',
                style: TextStyle(color: Colors.white), // Customize button text color
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setLock();
              },
              child: Text(
                'Set to LockScreen',
                style: TextStyle(color: Colors.white), // Customize button text color
              ),
            ),
          ),
        ],
      ),
    ),
  ],
)

    );

  }
}