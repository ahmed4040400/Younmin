import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/sentences/sentences_cubit.dart';

import 'chat_bubble.dart';
import 'fields.dart';

TextEditingController quantityController = TextEditingController();
TextEditingController sentenceController = TextEditingController();

bool saidMe = true;
bool madeMeHappy = true;

class Sentences extends StatelessWidget {
  const Sentences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SentencesCubit>(context).getSentences();
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
                        .copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: SentenceField(
                        controller: sentenceController,
                        onFeelingChanged: (value) {
                          madeMeHappy = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: quantityField(
                        controller: quantityController,
                        onPersonChanged: (value) {
                          saidMe = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  BlocBuilder<SentencesCubit, SentencesState>(
                      buildWhen: (oldState, state) =>
                          oldState.disableAddButton != state.disableAddButton,
                      builder: (context, state) {
                        return IgnorePointer(
                          ignoring: state.disableAddButton,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<SentencesCubit>(context)
                                  .createSentence(
                                      toldNumberController: quantityController,
                                      sentenceController: sentenceController,
                                      madeMeHappy: madeMeHappy,
                                      saidMe: saidMe);
                            },
                            child: Text(
                              "Add sentence",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        );
                      })
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
                  child: BlocBuilder<SentencesCubit, SentencesState>(
                      buildWhen: (oldState, state) =>
                          state.sentencesDocs != null,
                      builder: (context, state) {
                        return ImplicitlyAnimatedList(
                            items: state.sentencesDocs!,
                            itemBuilder: (BuildContext context,
                                Animation<double> animation,
                                QueryDocumentSnapshot<Map<String, dynamic>>
                                    item,
                                int index) {
                              return SizeFadeTransition(
                                sizeFraction: 0.2,
                                curve: Curves.easeInOut,
                                animation: animation,
                                child: Align(
                                  alignment: item["saidMe"]
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: ChatBubble(
                                    title: item["sentence"],
                                    subTitle: item["saidMe"]
                                        ? "Said to " +
                                            item["toldNumber"].toString()
                                        : "Told from " +
                                            item["toldNumber"].toString(),
                                    backGroundColor: item["madeMeHappy"]
                                        ? YounminColors.darkPrimaryColor
                                        : YounminColors.badSentenceColor,
                                    sentenceDoc: item,
                                  ),
                                ),
                              );
                            },
                            areItemsTheSame: (QueryDocumentSnapshot<
                                            Map<String, dynamic>>
                                        oldItem,
                                    QueryDocumentSnapshot<Map<String, dynamic>>
                                        newItem) =>
                                oldItem["date"] == newItem["date"],
                            removeItemBuilder: (context,
                                animation,
                                QueryDocumentSnapshot<Map<String, dynamic>>
                                    oldItem) {
                              return FadeTransition(
                                opacity: animation,
                                child: Align(
                                  alignment: oldItem["saidMe"]
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: ChatBubble(
                                    title: oldItem["sentence"],
                                    subTitle: oldItem["saidMe"]
                                        ? "Said to " +
                                            oldItem["toldNumber"].toString()
                                        : "Told from " +
                                            oldItem["toldNumber"].toString(),
                                    backGroundColor: oldItem["madeMeHappy"]
                                        ? YounminColors.darkPrimaryColor
                                        : YounminColors.badSentenceColor,
                                    sentenceDoc: oldItem,
                                  ),
                                ),
                              );
                            });
                        // return Column(
                        //   children:
                        //       List.generate(state.sentencesDocs.length, (index) {
                        //     return Align(
                        //       alignment: state.sentencesDocs[index]["saidMe"]
                        //           ? Alignment.centerRight
                        //           : Alignment.centerLeft,
                        //       child: ChatBubble(
                        //         title: state.sentencesDocs[index]["sentence"],
                        //         subTitle: state.sentencesDocs[index]["saidMe"]
                        //             ? "Said to " +
                        //                 state.sentencesDocs[index]["toldNumber"]
                        //                     .toString()
                        //             : "Told from " +
                        //                 state.sentencesDocs[index]["toldNumber"]
                        //                     .toString(),
                        //         backGroundColor: state.sentencesDocs[index]
                        //                 ["madeMeHappy"]
                        //             ? YounminColors.darkPrimaryColor
                        //             : YounminColors.badSentenceColor,
                        //         sentenceDoc: state.sentencesDocs[index],
                        //       ),
                        //     );
                        //   }),
                        // );
                      })),
            ),
          ),
        ],
      ),
    );
  }
}
