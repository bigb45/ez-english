import 'package:ez_english/features/models/base_question.dart';
import 'package:ez_english/features/sections/components/evaluation_section.dart';
import 'package:ez_english/features/sections/components/leave_alert_dialog.dart';
import 'package:ez_english/features/sections/grammar/grammar_section_viewmodel.dart';
import 'package:ez_english/theme/palette.dart';
import 'package:ez_english/theme/text_styles.dart';
import 'package:ez_english/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../util/build_question.dart';

class GrammarPractice extends StatefulWidget {
  const GrammarPractice({super.key});

  @override
  State<GrammarPractice> createState() => _GrammarPracticeState();
}

class _GrammarPracticeState extends State<GrammarPractice> {
  List<BaseQuestion> questions = [];
  late GrammarSectionViewmodel grammarSectionViewmodel;

  @override
  void initState() {
    super.initState();
    grammarSectionViewmodel =
        Provider.of<GrammarSectionViewmodel>(context, listen: false);
    questions = grammarSectionViewmodel.questions;
  }

  @override
  Widget build(BuildContext context) {
    grammarSectionViewmodel = Provider.of<GrammarSectionViewmodel>(context);

    BaseQuestion currentQuestion =
        questions[grammarSectionViewmodel.currentIndex];

    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        showLeaveAlertDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Palette.primaryText,
              ),
              onPressed: () {
                showLeaveAlertDialog(
                  context,
                  onPressed: () {},
                );
              },
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          title: ListTile(
            contentPadding: const EdgeInsets.only(left: 0, right: 0),
            // TODO: get title and subtitle from viewmodel
            title: Text(
              "Grammar Practice",
              style: TextStyles.titleTextStyle
                  .copyWith(color: Palette.primaryText),
            ),
            subtitle: Text(
              "Daily Conversations",
              style: TextStyles.subtitleTextStyle
                  .copyWith(color: Palette.primaryText),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TODO: change this to actual value (current question index / total questions)
                      const ProgressBar(value: 20),

                      Center(
                        child: buildQuestion(
                            question: currentQuestion,
                            onChanged: (value) {
                              grammarSectionViewmodel.updateAnswer(value);
                            },
                            answerState: grammarSectionViewmodel.answerState),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            EvaluationSection(
              onContinue: () {
                grammarSectionViewmodel.incrementIndex();
              },
              onPressed: grammarSectionViewmodel.evaluateAnswer,
              state: grammarSectionViewmodel.answerState,
            ),
          ],
        ),
      ),
    );
  }
}
