import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/*** 중요한 부분임  ===== Provider. ***/

//extends == 오른쪽의 차, 가 왼쪽의 브랜드(현대, 기아, 벤츠 등) 이 된다.
class CameraState extends ChangeNotifier {
  CameraController _controller;
  CameraDescription _cameraDescription;
  bool _readyTakePhoto = false; // 처음에는 사진찍을 준비 안됨

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras =
        await availableCameras(); //it is future, so with await, sync

    if (cameras != null && cameras.isNotEmpty) {
      setCameraDescription(cameras[0]); //첫번째 카메라러 지정된 카메라를 가져와서 사용
    }

    bool init = false;
    while (!init) {
      init = await initialize(); //for 중간에 error 캐치
    }
    _readyTakePhoto = true;
    notifyListeners();
  }

  void setCameraDescription(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    _controller = CameraController(_cameraDescription, ResolutionPreset.medium);
  }

  Future<bool> initialize() async {
    try {
      await _controller.initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  //for can use outside also
  CameraController get controller => _controller;
  CameraDescription get description => _cameraDescription;
  bool get isReadyToTakePhoto => _readyTakePhoto;
}
