import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
 import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import 'model/my_safari_webbrowser.dart';

class Utility {
  static Future<void> launchURLWithCustomTabs(
      BuildContext context, String url) async {
    final theme = Theme.of(context);
    MyChromeSafariBrowser().open(
      url: Uri.parse(url),
      options: ChromeSafariBrowserClassOptions(
          android: AndroidChromeCustomTabsOptions(
        toolbarBackgroundColor: theme.primaryColor,
      )),
    );
  }

  static bool checkScrollPosition(double position, double maxScrollExtend) {
    if (maxScrollExtend - position < 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> launchMyUrl(String url, BuildContext ctx) async {
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url, webOnlyWindowName: "dfdf");
    } else {
      showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
          title: const Text("Make Choice"),
          content: const Text(
              "You don't have torrent to download this movie. Do you want to download it?"),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                launchMyUrl(
                    'https://play.google.com/store/apps/details?id=intelligems.torrdroid',
                    ctx);
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    }
  }
}
