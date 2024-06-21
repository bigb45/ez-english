import 'package:ez_english/features/models/base_answer.dart';
import 'package:ez_english/widgets/radio_button.dart';

class MultipleChoiceAnswer extends BaseAnswer<RadioItemData> {
  MultipleChoiceAnswer({
    required RadioItemData answer,
  }) : super(answerType: AnswerType.multipleChoice);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  @override
  bool validate(RadioItemData userAnswer) {
    // TODO: implement validate
    throw UnimplementedError();
  }
}