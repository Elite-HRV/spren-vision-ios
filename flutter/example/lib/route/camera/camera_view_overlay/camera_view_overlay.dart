import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spren_flutter/spren_flutter.dart';
import 'package:spren_flutter/spren_stream.dart';
import 'package:spren_flutter/spren_model.dart';
import 'package:spren_flutter_example/route/camera/camera_view_overlay/camera_modals.dart';
import 'package:spren_flutter_example/route/camera/camera_view_overlay/state_pre_reading_compliance_change.dart';
import 'package:spren_flutter_example/route/camera/widgets/flash_disable_button.dart';
import 'package:spren_flutter_example/route/camera/widgets/flash_enable_button.dart';
import 'package:spren_flutter_example/route/camera/widgets/progress.dart';
import 'package:spren_flutter_example/widgets/close_button.dart';
import 'package:spren_flutter_example/route/processing/processing.dart';
import 'package:tuple/tuple.dart';

class CameraViewOverlay extends HookWidget {
  final double width;
  final double height;

  CameraViewOverlay(this.width, this.height, {Key? key}) : super(key: key);

  CancelListening? cancelListeningStateChange;
  CancelListening? cancelListeningPreReadingComplianceCheckChange;
  CancelListening? cancelListeningProgressChange;
  AwesomeDialog? lightInsufficientModal;
  AwesomeDialog? readingStoppedModal;

  @override
  Widget build(BuildContext context) {
    final progress = useState(0);
    final droppedFrames = useState(0);
    final exposure = useState(0);
    final brightness = useState(1);
    final lensCovered = useState(1);
    final flash = useState(-1);
    final readingStatus = useState<SprenState>(SprenState.preReading);
    final modal = useState<ModalVisible?>(null);

    Future<void> getReadingData() async {
      // Simulator: Testing
      // await Future.delayed(const Duration(seconds: 2));
      // String readingData = dotenv.env['READING_TEST_DATA'];
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => RouteProcessing(readingData)),
      // );
      // return;
      //
      try {
        String readingData = await SprenFlutter.getReadingData();
        SprenFlutter.captureStop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RouteProcessing(readingData)),
        );
      } catch (e) {
        SprenFlutter.captureStop();
        Navigator.pop(context);
      }
    }

    Future<void> onInit() async {
      // Simulator: Testing
      // await getReadingData();
      // return;
      //
      await Future.delayed(const Duration(seconds: 1));

      flash.value = 1;
      SprenFlutter.setAutoStart(true);
    }

    void handleOverExposure() async {
      try {
        await SprenFlutter.handleOverExposure();
      } catch (e) { }
    }

    void setTorchMode(int mode) async {
      try {
        await SprenFlutter.setTorchMode(mode);
      } catch (e) {
        if (mode == 0) {
          flash.value = 1;
        } else {
          flash.value = 0;
        }
      }
    }

    reset() {
      readingStatus.value = SprenState.preReading;
      progress.value = 0;
      droppedFrames.value = 0;
      brightness.value = 1;
      SprenFlutter.setAutoStart(true);
    }

    useEffect(() {
      cancelListeningPreReadingComplianceCheckChange =
          startListeningPreReadingComplianceCheckChange((dynamic message) {
        Tuple4<int, int, int, int> tuple4 =
            onStatePreReadingComplianceCheckChange(message);
        droppedFrames.value = droppedFrames.value + tuple4.item1;
        brightness.value = brightness.value + tuple4.item2;
        lensCovered.value = lensCovered.value + tuple4.item3;
        exposure.value = exposure.value + tuple4.item4;
      });
      cancelListeningProgressChange =
          startListeningProgressChange((dynamic message) {
        progress.value = message['progress'];
      });
      cancelListeningStateChange = startListeningStateChange((dynamic message) {
        String? state = message['state'];
        if (state == null) {
          return;
        }
        SprenState _sprenState =
            SprenState.values.firstWhere((e) => e.toShortString() == state);
        if (_sprenState == SprenState.error) {
          modal.value = ModalVisible.stop;
        } else if (_sprenState == SprenState.finished) {
          progress.value = 100;
          getReadingData();
        }
        readingStatus.value = _sprenState;
      });

      lightInsufficientModal = getLightInsufficientModal(context, () {
        flash.value = 1;
        modal.value = null;
      }, () {
        modal.value = null;
      });

      readingStoppedModal = getReadingStoppedModal(context, () {
        modal.value = null;
        reset();
      });

      onInit();

      return () {
        if (cancelListeningPreReadingComplianceCheckChange != null) {
          cancelListeningPreReadingComplianceCheckChange!();
        }
        if (cancelListeningStateChange != null) {
          cancelListeningStateChange!();
        }
        if (cancelListeningProgressChange != null) {
          cancelListeningProgressChange!();
        }
      };
    }, []);

    useEffect(() {
      if (droppedFrames.value != 2) {
        return;
      }
      SprenFlutter.dropComplexity();
      setTorchMode(flash.value);
      droppedFrames.value = 0;
      return null;
    }, [droppedFrames.value]);

    // BRIGHTNESS
    useEffect(() {
      if (brightness.value % 6 != 0 ||
          readingStatus.value == SprenState.started ||
          modal.value != null) {
        return;
      }
      modal.value = ModalVisible.brightness;
      return null;
    }, [brightness.value]);

    // LENS_COVERED
    useEffect(() {
      if (lensCovered.value % 6 != 0 ||
          readingStatus.value == SprenState.started ||
          readingStatus.value == SprenState.error ||
          readingStatus.value == SprenState.preReading ||
          modal.value != null) {
        return;
      }
      modal.value = ModalVisible.stop;
      return null;
    }, [lensCovered.value]);

    // EXPOSURE
    useEffect(() {
      handleOverExposure();
      return null;
    }, [exposure.value]);

    useOnAppLifecycleStateChange((AppLifecycleState? previous,
        AppLifecycleState current) {
      if (current == AppLifecycleState.resumed) {
        setTorchMode(flash.value);
      }
    });

    Future<void> modalDisplay(ModalVisible? modal) async {
      await Future.delayed(const Duration(milliseconds: 1));
      if (modal == ModalVisible.brightness) {
        lightInsufficientModal?.show();
      } else if (modal == ModalVisible.stop) {
        readingStoppedModal?.show();
      }
    }

    // MODAL
    useEffect(() {
      modalDisplay(modal.value);
      return null;
    }, [modal.value]);

    // FLASH
    useEffect(() {
      if (flash.value == -1) {
        return;
      }
      setTorchMode(flash.value);
      return null;
    }, [flash.value]);

    void changeTorchMode(int mode) {
      flash.value = mode;
    }

    return Positioned(
        top: 0,
        left: 0,
        width: width,
        height: height,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 40),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CloseBtn(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          CameraProgress(progress: progress.value),
                        ],
                      ),
                      if (flash.value == 1)
                        FlashEnableButton(notifyParent: changeTorchMode),
                      if (flash.value == 0)
                        FlashDisableButton(notifyParent: changeTorchMode),
                    ],
                  ),
                ))));
  }
}

enum ModalVisible {
  brightness,
  stop,
}
