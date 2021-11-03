import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/sentences/sentences_cubit.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.backGroundColor = YounminColors.darkPrimaryColor,
      required this.sentenceDoc})
      : super(key: key);

  final String title;
  final String subTitle;
  final Color backGroundColor;
  final QueryDocumentSnapshot<Map<String, dynamic>> sentenceDoc;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backGroundColor,
      child: Padding(
        padding: EdgeInsets.all(2.sp),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 35.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      BlocProvider.of<SentencesCubit>(context)
                          .deleteSentence(sentenceDoc: sentenceDoc);
                    },
                    iconSize: 30,
                    splashRadius: 5.sp,
                    icon: const FaIcon(Icons.close),
                    color: Colors.white.withOpacity(0.5),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
