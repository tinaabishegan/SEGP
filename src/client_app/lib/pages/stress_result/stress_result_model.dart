import '/flutter_flow/flutter_flow_util.dart';
import 'stress_result_widget.dart' show StressResultWidget;
import 'package:flutter/material.dart';

class StressResultModel extends FlutterFlowModel<StressResultWidget> {
  ///  Local state fields for this page.

  String stressLevel = 'No Stress';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
