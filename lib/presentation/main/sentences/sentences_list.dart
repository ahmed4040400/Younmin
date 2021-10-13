import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

import 'chat_bubble.dart';
import 'fields.dart';

Map<String, dynamic> sentance = {
  "sentence": "you're stupid",
  "SaidMe": false,
  "person": "someone",
  "madMeHappy": false,
};

List sentencesList = [
  {
    "sentence": "you're stupid",
    "saidMe": false,
    "saidQuantity": 1,
    "madeMeHappy": false,
  },
  {
    "sentence": "you look great",
    "saidMe": false,
    "saidQuantity": 5,
    "madeMeHappy": true,
  },
  {
    "sentence": "i like you",
    "saidMe": true,
    "saidQuantity": 2,
    "madeMeHappy": true,
  },
  {
    "sentence": "good work",
    "saidMe": false,
    "saidQuantity": 6,
    "madeMeHappy": true,
  },
];

class Sentences extends StatelessWidget {
  const Sentences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.h,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sentences",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 9.sp),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 30.w,
                    child: SentenceField(
                      onFeelingChanged: (value) {
                        if (value) {
                          print('happy');
                        } else {
                          print('sad');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 30.w,
                    child: quantityField(
                      onPersonChanged: (value) {
                        if (value) {
                          print('you');
                        } else {
                          print('else');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5.h),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Add sentence",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: YounminColors.yearlyTodoListColor,
              child: Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Column(
                    children: List.generate(sentencesList.length, (index) {
                      return Align(
                        alignment: sentencesList[index]["saidMe"]
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ChatBubble(
                          title: sentencesList[index]["sentence"],
                          subTitle: sentencesList[index]["saidMe"]
                              ? "Said to " +
                                  sentencesList[index]["saidQuantity"]
                                      .toString()
                              : "Told from " +
                                  sentencesList[index]["saidQuantity"]
                                      .toString(),
                          backGroundColor: sentencesList[index]["madeMeHappy"]
                              ? YounminColors.darkPrimaryColor
                              : YounminColors.badSentenceColor,
                        ),
                      );
                    }),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
