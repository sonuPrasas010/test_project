// import 'package:flutter/material.dart';
// import 'package:native_admob_flutter/native_admob_flutter.dart';

// class NativeAds extends StatefulWidget {
//   @override
//   _NativeAdsState createState() => _NativeAdsState();
// }

// class _NativeAdsState extends State<NativeAds> {
//   final controller = NativeAdController();

//   @override
//   void initState() {
//     super.initState();
//     controller.load();
//     controller.onEvent.listen((event) {
//       print(event);
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   AdLayoutBuilder get fullBuilder => (ratingBar, media, icon, headline,
//           advertiser, body, price, store, attribuition, button) {
//         return AdLinearLayout(
//           padding: EdgeInsets.all(10),
//           // The first linear layout width needs to be extended to the
//           // parents height, otherwise the children won't fit good
//           width: MATCH_PARENT,
//           decoration: AdDecoration(
//               gradient: AdLinearGradient(
//             colors: const [
//               Color.fromARGB(255, 121, 134, 203),
//               Color.fromARGB(255, 48, 63, 159)
//             ],
//             orientation: AdGradientOrientation.tl_br,
//           )),
//           children: [
//             media,
//             AdLinearLayout(
//               children: [
//                 icon,
//                 AdLinearLayout(children: [
//                   headline,
//                   AdLinearLayout(
//                     children: [attribuition, advertiser, ratingBar],
//                     orientation: HORIZONTAL,
//                     width: MATCH_PARENT,
//                   ),
//                 ], margin: const EdgeInsets.only(left: 4)),
//               ],
//               gravity: LayoutGravity.center_horizontal,
//               width: WRAP_CONTENT,
//               orientation: HORIZONTAL,
//               margin: const EdgeInsets.only(top: 6),
//             ),
//             AdLinearLayout(
//               children: [button],
//               orientation: HORIZONTAL,
//             ),
//           ],
//         );
//       };

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: controller.isLoaded ? 300 : 0,
//       child: NativeAd(
//         controller: controller,
//         height: 300,
//         unitId: MobileAds.nativeAdTestUnitId,
//         builder: (context, child) {
//           return Material(
//             child: child,
//           );
//         },
//         buildLayout: fullBuilder,
//         loading: const Center(
//           child: CircularProgressIndicator(),
//         ),
//         error: const Text(
//           'error',
//         ),
//       ),
//     );
//   }
// }
