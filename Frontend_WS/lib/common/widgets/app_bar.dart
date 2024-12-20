// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../main.dart';
// import '../utils/image_res.dart';
// import 'app_shadow.dart';
//
// AppBar buildAppBar({BuildContext? context}) {
//   return AppBar(
//       backgroundColor: const Color(0xff1d254e),
//       centerTitle: true,
//       elevation: 0,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           bottom: Radius.circular(26),
//         ),
//       ),
//       leading: IconButton(
//         onPressed: () {
//           Navigator.pop(context!);
//         },
//         icon: Container(
//           margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
//           child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 13.h,
//               child: const Icon(Icons.arrow_back_ios_new)),
//         ),
//       ),
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(20),
//         child: Container(
//           color: Colors.grey.withOpacity(0.5),
//           height: 0,
//         ),
//       ),
//       title: appBarLogo());
// }
// AppBar buildAppBarWithoutActionAndLeading({BuildContext? context}) {
//   return AppBar(
//       backgroundColor: const Color(0xff1d254e),
//       centerTitle: true,
//       elevation: 1,
//       leading: Container(),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           bottom: Radius.circular(26),
//         ),
//       ),
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(20),
//         child: Container(
//           color: Colors.grey.withOpacity(0.5),
//           height: 0,
//         ),
//       ),
//       title: appBarLogo());
// }
//
// // Widget appBarLogo() {
// //   return Container(
// //     margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
// //     width: 150.w,
// //     height: 40.h,
// //     alignment: Alignment.center,
// //     child: SizedBox(
// //       child: Image.asset(
// //         ImageRes.logo,
// //         fit: BoxFit.cover,
// //       ),
// //     ),
// //   );
// // }
//
// AppBar buildAppBarWithAction({BuildContext? context}) {
//   return AppBar(
//       backgroundColor: const Color(0xff1d254e),
//       centerTitle: true,
//       elevation: 0,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           bottom: Radius.circular(26),
//         ),
//       ),
//       leading: Container(),
//       actions: [
//         GestureDetector(
//           //navigating to the profile section
//           onTap: () => navKey.currentState
//               ?.pushNamed("/profile_scr"),
//           child: Container(
//             margin: EdgeInsets.fromLTRB(0, 25.h, 15.w, 0),
//             alignment: Alignment.center,
//             width: 35.w,
//             height: 30.h,
//             decoration: appBoxDecoration(borderWidth: 0, radius: 8.h),
//             child: Image.asset(
//               ImageRes.menuicon,
//               color: Colors.black,
//               height: 25.h,
//               width: 25.w,
//             ),
//           ),
//         )
//       ],
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(20),
//         child: Container(
//           color: Colors.grey.withOpacity(0.5),
//           height: 0,
//         ),
//       ),
//       title: appBarLogo());
// }
//
// AppBar buildAppBarWithActionAndLeading({BuildContext? context}) {
//   return AppBar(
//       backgroundColor: const Color(0xff1d254e),
//       centerTitle: true,
//       elevation: 0,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           bottom: Radius.circular(26),
//         ),
//       ),
//       leading: IconButton(
//         onPressed: () {
//           Navigator.pop(context!);
//         },
//         icon: Container(
//           margin: EdgeInsets.fromLTRB(0, 14.h, 0, 0),
//           child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 13.h,
//               child: Image.asset(
//                 ImageRes.arrowbackicon,
//                 color: Colors.black,
//               )),
//         ),
//       ),
//       actions: [
//         GestureDetector(
//           //navigating to the profile section
//           onTap: () => navKey.currentState
//               ?.pushNamedAndRemoveUntil("/profile_scr", (route) => false),
//           child: Container(
//             margin: EdgeInsets.fromLTRB(0, 20.h, 10.w, 0),
//             alignment: Alignment.center,
//             width: 35.w,
//             height: 30.h,
//             decoration: appBoxDecoration(borderWidth: 0, radius: 8.h),
//             child: Image.asset(
//               ImageRes.menuicon,
//               color: Colors.black,
//               height: 25.h,
//               width: 25.w,
//             ),
//           ),
//         )
//       ],
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(20),
//         child: Container(
//           color: Colors.grey.withOpacity(0.5),
//           height: 0,
//         ),
//       ),
//       title: appBarLogo());
// }
//
//
// AppBar buildAppBarWithCustomLeadingNavigation({BuildContext? context,void Function()?
// goToApplication}) {
//   return AppBar(
//       backgroundColor: const Color(0xff1d254e),
//       centerTitle: true,
//       elevation: 0,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           bottom: Radius.circular(26),
//         ),
//       ),
//       leading: IconButton(
//         onPressed: goToApplication!,
//         icon: Container(
//           margin: EdgeInsets.fromLTRB(0, 14.h, 0, 0),
//           child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 13.h,
//               child: Image.asset(
//                 ImageRes.arrowbackicon,
//                 color: Colors.black,
//               )),
//         ),
//       ),
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(20),
//         child: Container(
//           color: Colors.grey.withOpacity(0.5),
//           height: 0,
//         ),
//       ),
//       title: appBarLogo());
// }
//
