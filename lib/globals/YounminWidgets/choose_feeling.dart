import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

Map<String, bool> feelingsList = {
  "happy": false,
  "sad": false,
  "angry": false,
  "afraid": false,
  "scared": false,
  "disgust:": false,
  "shocked": false,
  "satisfied": false,
  "confused": false,
};

class ChooseFeeling extends StatefulWidget {
  const ChooseFeeling({Key? key, this.onChoosed}) : super(key: key);

  final void Function(int feelingIndex)? onChoosed;

  @override
  State<ChooseFeeling> createState() => _ChooseFeelingState();
}

class _ChooseFeelingState extends State<ChooseFeeling> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 20.h,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            feelingsList.length,
            (index) {
              return CircleAvatar(
                backgroundColor: feelingsList.values.toList()[index]
                    ? YounminColors.primaryColor
                    : Colors.transparent,
                radius: 8.sp,
                child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                  constraints:
                      BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
                  icon: Image.asset('assets/images/emoji/${index + 1}.png'),
                  onPressed: () {
                    widget.onChoosed!(index + 1);
                    setState(() {
                      feelingsList.keys.toList().forEach((key) {
                        feelingsList[key] = false;
                      });
                      feelingsList[feelingsList.keys.toList()[index]] = true;
                    });
                  },
                  tooltip: feelingsList.keys.toList()[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
//
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/1.png'),
// onPressed: () {},
// tooltip: "happy",
// ),
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/2.png'),
// onPressed: () {},
// tooltip: "sad",
// ),
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/3.png'),
// onPressed: () {},
// tooltip: "angry",
// ),
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/4.png'),
// onPressed: () {},
// tooltip: "afraid",
// ),
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/5.png'),
// onPressed: () {},
// tooltip: "scared",
// ),
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/6.png'),
// onPressed: () {},
// tooltip: "disgust",
// ),
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/7.png'),
// onPressed: () {},
// tooltip: "shocked",
// ),
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/8.png'),
// onPressed: () {},
// tooltip: "satisfied",
// ),
// IconButton(
// padding: EdgeInsets.symmetric(horizontal: 0.1.w),
// constraints: BoxConstraints(minHeight: 15.sp, minWidth: 15.sp),
// icon: Image.asset('assets/images/emoji/9.png'),
// onPressed: () {},
// tooltip: "confused",
// ),
