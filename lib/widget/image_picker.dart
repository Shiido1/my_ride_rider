import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


import '../constants/colors.dart';



enum ProfileOptionAction {
  viewImage,
  profileCamera,
  library,
  remove,
}

class ImagePickerHandler {
  File? file;

  Future<void> pickImage(
      {@required BuildContext? context,
      Function(File file)? file}) async {
    ProfileOptionAction? action;
    if (Platform.isAndroid) {
      action = await showModalBottomSheet(
          context: context!,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          builder: (context) => BottomSheet(
              onClosing: () {},
              builder: (context) => Wrap(
                    children: <Widget>[
                      ListTile(
                          title: const Center(
                            child: Text(
                            'Pick from library',
                              style: TextStyle(),
                            ),
                          ),
                          onTap: () => Navigator.pop(
                              context, ProfileOptionAction.library)),
                      const Divider(),
                      ListTile(
                          title: const Center(
                            child: Text('Take a photo'),
                          ),
                          onTap: () => Navigator.pop(
                              context, ProfileOptionAction.profileCamera)),
                      InkWell(
                        onTap: () => Navigator.pop(
                            context, ProfileOptionAction.remove),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(12.0),
                          color: Colors.grey[200],
                          child: const Center(
                            child: Text('Cancel'),
                          ),
                        ),
                      ),
                    ],
                  )));
    } else if (Platform.isIOS) {
      action = await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context!,
          builder: (context) => CupertinoActionSheet(
                  actions: <Widget>[
                    CupertinoButton(
                        child: const Text('Pick from library'),
                        onPressed: () => Navigator.pop(
                            context, ProfileOptionAction.library)),
                    CupertinoButton(
                        child: const Text('Take a photo'),
                        onPressed: () => Navigator.pop(
                            context, ProfileOptionAction.profileCamera)),
                  ],
                  cancelButton: CupertinoButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context))));
    }

    if (action == null) return;
    final getFile = await handleProfileAction(context!, action: action);
    file!(getFile!);
  }

  Future<File?>? handleProfileAction(BuildContext context,
      {@required ProfileOptionAction? action}) {
    switch (action!) {
      case ProfileOptionAction.viewImage:
      case ProfileOptionAction.library:
        return _getImage(context, ImageSource.gallery);
      case ProfileOptionAction.profileCamera:
        return _getImage(context, ImageSource.camera);
      case ProfileOptionAction.remove:
        break;
    }
    return null;
  }

  Future<File?> _getImage(
      BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker.platform.pickImage(source: source);
      if (pickedFile != null) {
        return await _cropImage(context, pickedFile);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<File?> _cropImage(
      BuildContext context, PickedFile imageFile) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square]
            : [CropAspectRatioPreset.square],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'My Driver',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'My Driver',
        ));

    return croppedFile;
  }
}
