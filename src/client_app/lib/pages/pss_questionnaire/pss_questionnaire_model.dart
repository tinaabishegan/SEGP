import '/components/dott_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'pss_questionnaire_widget.dart' show PssQuestionnaireWidget;
import 'package:flutter/material.dart';
import 'package:food/dio.dart';
import 'package:dio/dio.dart';
import 'package:food/util.dart';

class PssQuestionnaireModel extends FlutterFlowModel<PssQuestionnaireWidget> {
  ///  Local state fields for this page.

  Dio dio = DioSingleton.getInstance();

  double prog = 0.0;

  late String stressLevel;

  List<String> questionList = [
    'l. In the last month, how often have you been upset because of something that\nhappened unexpectedly?',
    '2. In the last month, how often have you felt that you were unable to control the\nimportant things in your life?',
    '3. In the last month, how often have you felt nervous and stressed?',
    '4. In the last month, how often have you felt confident about your ability to handle\nyour personal problems?',
    '5. In the last month, how often have you felt that things were going your way?',
    '6. In the last month, how often have you found that you could not cope with\nall the things that you had to do?',
    '7. In the last month, how often have you been able to control irritations in\nyour life?',
    '8. In the last month, how often have you felt that you were on top of things?',
    '9. In the last month, how often have you been angered because of things that\nhappened that were outside of your control?',
    '10. In the last month, how often have you felt difficulties were piling up so high that\nyou could not overcome them?'
  ];
  void addToQuestionList(String item) => questionList.add(item);
  void removeFromQuestionList(String item) => questionList.remove(item);
  void removeAtIndexFromQuestionList(int index) => questionList.removeAt(index);
  void insertAtIndexInQuestionList(int index, String item) =>
      questionList.insert(index, item);
  void updateQuestionListAtIndex(int index, Function(String) updateFn) =>
      questionList[index] = updateFn(questionList[index]);

  List<int> answerList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  void addToAnswerList(int item) => answerList.add(item);
  void removeFromAnswerList(int item) => answerList.remove(item);
  void removeAtIndexFromAnswerList(int index) => answerList.removeAt(index);
  void insertAtIndexInAnswerList(int index, int item) =>
      answerList.insert(index, item);
  void updateAnswerListAtIndex(int index, Function(int) updateFn) =>
      answerList[index] = updateFn(answerList[index]);

  int quesNum = 0;

  int currentAns = 0;

  bool isDone = false;

  late BuildContext context;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for dott component.
  late DottModel dottModel1;
  // Model for dott component.
  late DottModel dottModel2;
  // Model for dott component.
  late DottModel dottModel3;
  // Model for dott component.
  late DottModel dottModel4;
  // Model for dott component.
  late DottModel dottModel5;
  // Model for dott component.
  late DottModel dottModel6;
  // Model for dott component.
  late DottModel dottModel7;
  // Model for dott component.
  late DottModel dottModel8;
  // Model for dott component.
  late DottModel dottModel9;
  // Model for dott component.
  late DottModel dottModel10;
  // Model for dott component.
  late DottModel dottModel11;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    this.context = context;
    dottModel1 = createModel(context, () => DottModel());
    dottModel2 = createModel(context, () => DottModel());
    dottModel3 = createModel(context, () => DottModel());
    dottModel4 = createModel(context, () => DottModel());
    dottModel5 = createModel(context, () => DottModel());
    dottModel6 = createModel(context, () => DottModel());
    dottModel7 = createModel(context, () => DottModel());
    dottModel8 = createModel(context, () => DottModel());
    dottModel9 = createModel(context, () => DottModel());
    dottModel10 = createModel(context, () => DottModel());
    dottModel11 = createModel(context, () => DottModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    dottModel1.dispose();
    dottModel2.dispose();
    dottModel3.dispose();
    dottModel4.dispose();
    dottModel5.dispose();
    dottModel6.dispose();
    dottModel7.dispose();
    dottModel8.dispose();
    dottModel9.dispose();
    dottModel10.dispose();
    dottModel11.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  String interpretPSS10Stress(List<int> responses) {
    // Check if the list of responses has the correct length
    if (responses.length != 10) {
      throw ArgumentError("List of responses must contain exactly 10 items.");
    }

    // Reverse scores for questions 4, 5, 7, and 8
    Map<int, int> reverseScores = {0: 4, 1: 3, 2: 2, 3: 1, 4: 0};
    List<int> questionsToReverse = [
      2,
      3,
      5,
      6
    ]; // 0-indexed, so subtract 1 from each question number
    for (int i = 0; i < responses.length; i++) {
      if (questionsToReverse.contains(i)) {
        responses[i] = reverseScores[responses[i]] ?? responses[i];
      }
    }

    // Summing up the adjusted responses
    int sum = responses.reduce((value, element) => value + element);

    // Interpret the stress level
    if (sum >= 0 && sum <= 13) {
      return "Low Stress";
    } else if (sum >= 14 && sum <= 26) {
      return "Mid Stress"; // Updated wording according to your requirements
    } else if (sum >= 27 && sum <= 40) {
      return "High Stress";
    } else {
      throw ArgumentError("Invalid stress score: $sum");
    }
  }

  Future<bool> authenticate() async {
    try {
      Response response = await dio.post('${getHost()}api/authenticate');

      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 201) {
        return false;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<String> upload_stress() async {
    stressLevel = interpretPSS10Stress(answerList);
    print(stressLevel);
    if (await authenticate()) {
      try {
        Response response = await dio.post('${getHost()}api/upload_stress',
            data: {'result': stressLevel.toLowerCase()});
        if (response.statusCode == 200) {
          return stressLevel;
        } else {
          return '';
        }
      } catch (error) {
        print('Error occurred: $error');
        return '';
      }
    } else {
      return stressLevel;
    }
  }

  String? get radioButtonValue => radioButtonValueController?.value;
}
