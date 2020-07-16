import 'dart:math';

import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:calculatorapp/screens/scan.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  GlobalKey globalKey = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String qrData = "http://www.google.com";
  TextEditingController teText = new TextEditingController();
  bool qr = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                LineIcons.arrow_left,
                size: 21,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    try {
                      RenderRepaintBoundary boundary =
                          globalKey.currentContext.findRenderObject();
                      var image = await boundary.toImage();

                      ByteData byteData = await image.toByteData(
                        format: ImageByteFormat.png,
                      );
                      Uint8List pngBytes = byteData.buffer.asUint8List();

                      final tempDir = await getTemporaryDirectory();
                      final file =
                          await new File('${tempDir.path}/image.png').create();
                      await file.writeAsBytes(pngBytes);

                      ShareExtend.share(
                        file.path,
                        "file",
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  })
            ],
            title: Text(
              'Generate QR',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Google',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            elevation: 0,
            backgroundColor: Color(0xFF2B1137)),
        body: Container(
            padding: EdgeInsets.all(19),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                    child: RepaintBoundary(
                        key: globalKey,
                        child: qr == true
                            ? QrImage(
                                data: qrData,
                                size: 200,
                                padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                                backgroundColor: Colors.white70,
                                foregroundColor: Colors.black87,
                              )
                            : BarCodeImage(
                                params: Code39BarCodeParams(
                                  "$qrData",
                                  lineWidth:
                                      2.0, // width for a single black/white bar (default: 2.0)
                                  barHeight:
                                      90.0, // height for the entire widget (default: 100.0)
                                  withText:
                                      true, // Render with text label or not (default: false)
                                ),
                                onError: (error) {
                                  // Error handler
                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(
                                          content:
                                              new Text('Capslock is off')));
                                  print('error = $error');
                                },
                              ))),
                SizedBox(height: 20.0),
                Text('Get your own QR Code '),
                TextField(
                  controller: teText,
                  decoration: InputDecoration(
                      hintText: 'Enter the Data/Link',
                      focusColor: Color(0xFF2B1137),
                      fillColor: Color(0xFF2B1137),
                      hoverColor: Color(0xFF2B1137)),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 5)),
                FlatButton(
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      qr = true;
                    });
                    if (teText.text.isEmpty) {
                      setState(() {
                        qrData = 'http://google.com';
                      });
                    } else {
                      setState(() {
                        qrData = teText.text;
                      });
                    }
                    //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new Generate()));
                  },
                  child: Text('Generate QR Code',
                      style: TextStyle(
                          fontFamily: 'Google',
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color(0xFF2B1137), width: 2.0)),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 5)),
                FlatButton(
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      qr = false;
                    });
                    if (teText.text.isEmpty) {
                      setState(() {
                        qrData = 'http://google.com';
                      });
                    } else {
                      setState(() {
                        qrData = teText.text;
                      });
                    }
                    //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new Generate()));
                  },
                  child: Text('Generate Bar Code',
                      style: TextStyle(
                          fontFamily: 'Google',
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color(0xFF2B1137), width: 2.0)),
                ),
              ],
            )));
  }
}
