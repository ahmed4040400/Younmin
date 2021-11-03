import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/questions_page_strings.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/questions/questions_cubit.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> init = [];

class Answers extends StatelessWidget {
  Answers({Key? key, required this.questionDoc}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> questionDoc;

  TextEditingController answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuestionsCubit>(context).getAnswers(questionDoc);
    return Container(
      height: 95.h,
      child: Column(
        children: [
          Text(
            questionDoc['title'],
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            questionDoc['body'],
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 20),
          Expanded(
            child: Builder(builder: (context) {
              BlocProvider.of<QuestionsCubit>(context).getAnswers(questionDoc);

              return BlocBuilder<QuestionsCubit, QuestionsState>(
                  buildWhen: (oldStat, state) => state.answerDocs != null,
                  builder: (context, state) {
                    return ImplicitlyAnimatedList(
                      items: state.answerDocs ?? init,
                      itemBuilder: (BuildContext context,
                          animation,
                          QueryDocumentSnapshot<Map<String, dynamic>> item,
                          int index) {
                        return SizedBox(
                          height: 100,
                          child: Card(
                            child: Center(
                              child: ListTile(
                                title: Text(
                                  item['answer'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: YounminColors.primaryColor,
                                  foregroundImage: NetworkImage(item[
                                          'photoUrl'] ??
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg"),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      areItemsTheSame:
                          (QueryDocumentSnapshot<Map<String, dynamic>> oldItem,
                                  QueryDocumentSnapshot<Map<String, dynamic>>
                                      newItem) =>
                              oldItem["answer"] == newItem["answer"],
                    );
                  });
            }),
          ),
          SizedBox(
            height: 100,
            width: 500,
            child: TextField(
              controller: answerController,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: QuestionsStrings.writeAnAnswer,
                  suffixIcon: IconButton(
                    icon: FaIcon(Icons.send),
                    onPressed: () {
                      BlocProvider.of<QuestionsCubit>(context)
                          .addAnswer(questionDoc, answerController);
                    },
                  )),
            ),
          )
        ],
      ),
    );
  }
}
