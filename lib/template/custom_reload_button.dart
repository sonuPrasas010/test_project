
import 'package:flutter/material.dart';

class CustomReloadButton extends StatelessWidget {
  final Function onReload;

  const CustomReloadButton(this.onReload, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
          onPressed:()=>onReload(),
          icon: const Icon(Icons.refresh),
          label: const Text("Reload")),
    );
  }
}
