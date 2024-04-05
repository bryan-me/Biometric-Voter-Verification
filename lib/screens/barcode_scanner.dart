import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class barcode extends StatefulWidget {
  const barcode({super.key});

  @override
  State<barcode> createState() => _barcodeState();
}

class _barcodeState extends State<barcode> {
  String _scanBarcodeResult = '';

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Barcode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: scanBarcodeNormal, child: Text("Start Barcode Scanner")),
            Text("Barcode Result $_scanBarcodeResult")
          ],
        ),
      ),
    );
  }
    void scanBarcodeNormal() async{
    String barcodeScanRes;
    try{
      barcodeScanRes=await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "cancel",
      true,
      ScanMode.BARCODE
    ); 
    }  on PlatformException {
      barcodeScanRes = "Failed to get platform version";
    }
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }
}