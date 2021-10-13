import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.backGroundColor = YounminColors.darkPrimaryColor})
      : super(key: key);

  final String title;
  final String subTitle;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backGroundColor,
      child: Padding(
        padding: EdgeInsets.all(2.sp),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 35.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
