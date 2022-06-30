
import "package:flutter/material.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() async {
  // if (Platform.isAndroid) {
  //   return;
  // }
  runApp(TestClass());
}

class TestClass extends StatefulWidget {
  @override
  _TestClassState createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  HeadlessInAppWebView? headlessWebView;
  String url = "dfdf";

  @override
  void initState() {
    super.initState();
    print("someshit");
    headlessWebView =  HeadlessInAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse("https://github.com/flutter")),
      onWebViewCreated: (controller) {
        print("webview created");
        // final snackBar = SnackBar(
        //   content: Text('HeadlessInAppWebView created!'),
        //   duration: Duration(seconds: 1),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onConsoleMessage: (controller, consoleMessage) {
        // final snackBar = SnackBar(
        //   content: Text('Console Message: ${consoleMessage.message}'),
        //   duration: Duration(seconds: 1),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onLoadStart: (controller, url) async {
        print("load start");
        // final snackBar = SnackBar(
        //   content: Text('onLoadStart $url'),
        //   duration: Duration(seconds: 1),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // setState(() {
        //   this.url = url?.toString() ?? '';
        // });
      },
      onLoadStop: (controller, url) async {
        // final snackBar = SnackBar(
        //   content: Text('onLoadStop $url'),
        //   duration: Duration(seconds: 1),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // setState(() {
        //   this.url = url?.toString() ?? '';
        // });
      },
    );

    print("after webview");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    headlessWebView = new HeadlessInAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
              useShouldInterceptRequest: true,
            ),
            crossPlatform: InAppWebViewOptions(
              useShouldInterceptAjaxRequest: true,
            )),
        initialUrlRequest:
            URLRequest(url: Uri.parse("https://github.com/flutter")),
        onWebViewCreated: (controller) {
          print("webview created");
          // final snackBar = SnackBar(
          //   content: Text('HeadlessInAppWebView created!'),
          //   duration: Duration(seconds: 1),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onConsoleMessage: (controller, consoleMessage) {
          // final snackBar = SnackBar(
          //   content: Text('Console Message: ${consoleMessage.message}'),
          //   duration: Duration(seconds: 1),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onLoadStart: (controller, url) async {
          print("load start");
          // final snackBar = SnackBar(
          //   content: Text('onLoadStart $url'),
          //   duration: Duration(seconds: 1),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);

          setState(() {
            this.url = url?.toString() ?? '';
          });
        },
        onLoadStop: (controller, url) async {
          // final snackBar = SnackBar(
          //   content: Text('onLoadStop $url'),
          //   duration: Duration(seconds: 1),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onAjaxReadyStateChange: (controller, req) async {
          setState(() async{
            
          
          url = await controller.getHtml()??"";
          });

          return req.action;
        });
    print(headlessWebView.toString());

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Test"),
          ),
          body: ElevatedButton(
              onPressed: () {
                headlessWebView?.run();
              },
              child: Text(
                url,
              ))),
    );
  }
}
