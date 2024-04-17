import 'package:attendance_tracker/controller/add_attendance_controller.dart';
import 'package:attendance_tracker/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:velocity_x/velocity_x.dart';

class ScannerScreen extends StatefulWidget {
  String classId;
  ScannerScreen({required this.classId});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

var data;
var roll;
var name;

class _ScannerScreenState extends State<ScannerScreen> {
  var attendance = Get.put(Attendance());
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  changetoNull() {
    controller!.pauseCamera();
    Future.delayed(Duration(seconds: 5), () {
      controller!.resumeCamera();
      setState(() {
        result = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Scan QR Code')),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 2, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (result != null)
                  Column(
                    children: [
                      Center(
                        child: Text(
                          roll,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      10.heightBox,
                      Center(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  const Center(
                    child: Text(
                      'Scanning data',
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Icon(
                  Icons.check_circle,
                  color: result != null ? Colors.green : Colors.grey,
                  size: 35,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.deepPurple.shade400,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      changetoNull();
      attendance.addAttendance(widget.classId);
      setState(() {
        result = scanData;
        data = result!.code;
        Finddeatils finddeatils = Finddeatils(data);
        roll = finddeatils.Findroll(widget.classId);
        name = finddeatils.Findname();
      });
      // attendance.addAttendance(widget.classId);
    });
    await Future.delayed(Duration(seconds: 5));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
