import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/presentation/questions/show_answers.dart';

List<Map> answers = [
  {
    "userName": 'ahmed',
    "answer": "Lorem ipsum dolor sit amet, condimentu elit pharetra sed."
  },
  {
    "userName": 'mohamed',
    "answer": "Lorem ipsum dolor sit amet, condimentu elit pharetra sed."
  },
  {
    "userName": 'darlene',
    "answer": "Lorem ipsum dolor sit amet, condimentu elit pharetra sed."
  },
  {
    "userName": 'eliot',
    "answer": "Lorem ipsum dolor sit amet, condimentu elit pharetra sed."
  },
];

List<Map> questionsList = [
  {
    "title": "what do you think that makes you happy",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu,consectetur adipiscing elit. Curabitur eu",
    "Answers": answers,
  },
  {
    "title": "Lorem ipsum dolor sit amet",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu",
    "Answers": answers,
  },
  {
    "title": "Lorem ipsum dolor sit amet",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu",
    "Answers": answers,
  },
  {
    "title": "Lorem ipsum dolor sit amet",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu",
    "Answers": answers,
  },
  {
    "title": "Lorem ipsum dolor sit amet",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu",
    "Answers": answers,
  },
  {
    "title": "Lorem ipsum dolor sit amet",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu",
    "Answers": answers,
  },
];

class Questions extends StatelessWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: const LogoButton(
                      textColor: YounminColors.darkPrimaryColor,
                    ),
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/home/1.png'),
                        backgroundColor: YounminColors.primaryColor,
                        radius: 15.sp,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        "Ahmed Elshentenawy",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Log out",
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: YounminColors.backGroundColor,
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: ListView.builder(
                  itemCount: questionsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.h,
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                              backgroundColor: YounminColors.backGroundColor,
                              shape: RoundedRectangleBorder(
                                //the rounded corner is created here
                                borderRadius: BorderRadius.circular(5.sp),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (conext) => const Answers(),
                            );
                          },
                          title: Text(
                            questionsList[index]['title'],
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            questionsList[index]['body'],
                          ),
                          trailing: const Tooltip(
                            message: 'Answers',
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text(
                                "50",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
