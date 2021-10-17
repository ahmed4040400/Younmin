import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/presentation/questions/questions.dart';

class Answers extends StatelessWidget {
  const Answers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.h,
      child: Column(
        children: [
          Text(
            'hello test test test',
            style: Theme.of(context).textTheme.headline1,
          ),
          Divider(),
          Text(
            'helo test body',
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              itemCount: answers.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.h,
                  child: Card(
                    child: Center(
                      child: ListTile(
                        title: Text(
                          answers[index]['answer'],
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: YounminColors.primaryColor,
                          foregroundImage:
                              AssetImage("assets/images/home/1.png"),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20.h,
            width: 50.w,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Write an answer",
                  suffixIcon: IconButton(
                    icon: FaIcon(Icons.send),
                    onPressed: () {},
                  )),
            ),
          )
        ],
      ),
    );
  }
}
