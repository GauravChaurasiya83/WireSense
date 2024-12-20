import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wire_sense/common/widgets/text_widgets.dart';
import '../../main.dart';
import '../utils/app_colors.dart';
import 'app_shadow.dart';

Widget appButtons(
    {String buttonText = "Next",
    Color buttonColor = AppColors.mainThemeColor,
    Color buttonTextColor = AppColors.dashBoardSecondaryTextColor,
    double buttonBorderWidth = 0.0,
    double height = 50,
    double width = 340,
    BuildContext? context,
    Color borderColor = Colors.black,
    double buttonTextSize = 20,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    /* we are calling any way door func when this button is pressed
    and this func will be executed in the file from where this button has been called.*/
    child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: appBoxDecoration(
            color: buttonColor,
            borderWidth: buttonBorderWidth,
            radius: 10,
            borderColor: borderColor),
        child: textcustomnormal(
          text: buttonText,
          fontWeight: FontWeight.w600,
          fontfamily: "Inter",
          fontSize: buttonTextSize,
          color: buttonTextColor,
        )),
  );
}

Widget documentsButtons(
    {String buttonText = "Next",
      Color buttonColor = AppColors.mainThemeColor,
      Color buttonTextColor = AppColors.dashBoardSecondaryTextColor,
    IconData buttonIcon = Icons.error_outline,
    double buttonBorderWidth = 1.0,
    Color iconColor = const Color(0xfffff0ce),
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: 5,
          borderColor: Colors.grey.shade400),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Icon(
            buttonIcon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            buttonText,
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                color: buttonTextColor),
          ),
        ],
      ),
    ),
  );
}

Widget customIconAppButton(
    {String buttonText = "Next",
      Color buttonColor = AppColors.mainThemeColor,
      Color buttonTextColor = AppColors.dashBoardSecondaryTextColor,
    double buttonTextSize = 16,
    double buttonRadius = 15,
    Color borderColor = Colors.black,
    double buttonBorderWidth = 0.0,
    IconData buttonIcon = Icons.edit_calendar_rounded,
    double height = 55,
    double width = 370,
    BuildContext? context,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    /* we are calling any way door func when this button is pressed
    and this func will be executed in the file from where this button has been called.*/
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      height: height,
      width: width,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: buttonRadius,
          borderColor: borderColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(buttonIcon),
          SizedBox(
            width: 10.w,
          ),
          textcustomnormal(
            fontSize: buttonTextSize,
            fontWeight: FontWeight.w600,
            fontfamily: "Poppins",
            text: buttonText,
            align: TextAlign.start,
            color: buttonTextColor,
          )
        ],
      ),
    ),
  );
}

Widget orderCardCommon(
    {String customerName = "",
    String amount = "",
    String status = "",
    int orderNumber = 12324}) {
  Color color;
  if (status == "Cancelled") {
    color = const Color(0xffF14B4B);
  } else {
    color = const Color(0xff599691);
  }
  return GestureDetector(
    onTap: () => navKey.currentState?.pushNamed(
      '/order_det_scr',
    ),
    child: Container(
      margin: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
      child: Card(
          shadowColor: Colors.grey.shade400,
          elevation: 5.0,
          clipBehavior: Clip.hardEdge,
          child: Container(
            alignment: Alignment.center,
            width: 434.w,
            height: 125.h,
            decoration: appBoxDecoration(
                color: const Color(0xffFFF5DD),
                radius: 10,
                borderWidth: 0,
                borderColor: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textcustomnormal(
                            text: customerName,
                            color: Colors.black,
                            fontSize: 16,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                          textcustomnormal(
                            text: "20 April, 11:40 AM",
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 150.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          textcustomnormal(
                            text: amount,
                            color: Colors.black,
                            fontSize: 16,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                          textcustomnormal(
                            text: "UPI",
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                dashLine(
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textcustomnormal(
                      text: "Order Number $orderNumber",
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                    textcustomnormal(
                      text: "3 Items",
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                    textcustomnormal(
                      text: status,
                      color: color,
                      fontSize: 14,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                )
              ],
            ),
          )),
    ),
  );
}
