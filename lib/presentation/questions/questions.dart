import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/questions_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/login/login_cubit.dart';
import 'package:younmin/logic/questions/questions_cubit.dart';
import 'package:younmin/presentation/questions/show_answers.dart';

final _auth = FirebaseAuth.instance;

class Questions extends StatelessWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => QuestionsCubit(),
      child: Builder(builder: (context) {
        BlocProvider.of<QuestionsCubit>(context).getQuestions();
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
                          navigateOnTap: false,
                        ),
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(_auth.currentUser!.photoURL!),
                            backgroundColor: YounminColors.primaryColor,
                            radius: 70,
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            _auth.currentUser!.displayName!,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginCubit>(context)
                                .logout(context);
                          },
                          child: Text(
                            QuestionsStrings.logout,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 25),
                          )),
                      SizedBox(
                        height: 30,
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
                    padding: EdgeInsets.only(top: 25),
                    child: BlocBuilder<QuestionsCubit, QuestionsState>(
                        buildWhen: (oldState, state) =>
                            state.questionDocs != null,
                        builder: (context, state) {
                          return ImplicitlyAnimatedList(
                            items: state.questionDocs!,
                            itemBuilder: (BuildContext context,
                                Animation<double> animation,
                                QueryDocumentSnapshot<Map<String, dynamic>>
                                    item,
                                int index) {
                              return SizedBox(
                                height: 85,
                                child: Card(
                                  child: ListTile(
                                    onTap: () {
                                      showModalBottomSheet<dynamic>(
                                        backgroundColor:
                                            YounminColors.backGroundColor,
                                        shape: RoundedRectangleBorder(
                                          //the rounded corner is created here
                                          borderRadius:
                                              BorderRadius.circular(5.sp),
                                        ),
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (_) => BlocProvider.value(
                                          value:
                                              BlocProvider.of<QuestionsCubit>(
                                                  context),
                                          child: Answers(questionDoc: item),
                                        ),
                                      );
                                    },
                                    title: Text(
                                      item['title'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      item['body'],
                                    ),
                                  ),
                                ),
                              );
                            },
                            areItemsTheSame: (QueryDocumentSnapshot<
                                            Map<String, dynamic>>
                                        oldItem,
                                    QueryDocumentSnapshot<Map<String, dynamic>>
                                        newItem) =>
                                oldItem['title'] == newItem['title'],
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
