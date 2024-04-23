import '/components/dott_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'pss_questionnaire_model.dart';
export 'pss_questionnaire_model.dart';

class PssQuestionnaireWidget extends StatefulWidget {
  const PssQuestionnaireWidget({super.key});

  @override
  State<PssQuestionnaireWidget> createState() => _PssQuestionnaireWidgetState();
}

class _PssQuestionnaireWidgetState extends State<PssQuestionnaireWidget> {
  late PssQuestionnaireModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PssQuestionnaireModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF9F7F7),
        appBar: responsiveVisibility(
          context: context,
          tablet: false,
          tabletLandscape: false,
          desktop: false,
        )
            ? AppBar(
                backgroundColor: Color(0xFF112D4E),
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                title: Text(
                  'BrainZen',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 22,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 2,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 236,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFB5E4FD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'PSS-10 Questionnaire',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.05,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: LinearPercentIndicator(
                          percent: _model.prog,
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          lineHeight: 3,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).primary,
                          backgroundColor: FlutterFlowTheme.of(context).accent4,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            wrapWithModel(
                              model: _model.dottModel1,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel2,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel3,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel4,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel5,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel6,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel7,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel8,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel9,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel10,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                            wrapWithModel(
                              model: _model.dottModel11,
                              updateCallback: () => setState(() {}),
                              child: DottWidget(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.55,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _model.questionList[_model.quesNum],
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      FlutterFlowRadioButton(
                        options: [
                          'Never',
                          'Almost never',
                          'Sometimes',
                          'Fairly often',
                          'Very often'
                        ].toList(),
                        onChanged: (val) async {
                          setState(() {});
                          _model.currentAns = valueOrDefault<int>(
                            () {
                              if (_model.radioButtonValue == 'Never') {
                                return 0;
                              } else if (_model.radioButtonValue ==
                                  'Almost never') {
                                return 1;
                              } else if (_model.radioButtonValue ==
                                  'Sometimes') {
                                return 2;
                              } else if (_model.radioButtonValue ==
                                  'Fairly often') {
                                return 3;
                              } else {
                                return 4;
                              }
                            }(),
                            0,
                          );
                        },
                        controller: _model.radioButtonValueController ??=
                            FormFieldController<String>('Never'),
                        optionHeight: 32,
                        textStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                        selectedTextStyle:
                            FlutterFlowTheme.of(context).bodyMedium,
                        buttonPosition: RadioButtonPosition.left,
                        direction: Axis.vertical,
                        radioButtonColor:
                            FlutterFlowTheme.of(context).primaryText,
                        inactiveRadioButtonColor:
                            FlutterFlowTheme.of(context).primaryText,
                        toggleable: false,
                        horizontalAlignment: WrapAlignment.start,
                        verticalAlignment: WrapCrossAlignment.start,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (_model.quesNum != 0)
                            FFButtonWidget(
                              onPressed: () async {
                                setState(() {
                                  _model.updateAnswerListAtIndex(
                                    _model.quesNum,
                                    (_) => _model.currentAns,
                                  );
                                  _model.quesNum = _model.quesNum + -1;
                                  _model.prog = _model.prog + -0.1;
                                });
                              },
                              text: 'Previous',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFFB5E4FD),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                    ),
                                elevation: 6,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          if (_model.quesNum != 9)
                            FFButtonWidget(
                              onPressed: () async {
                                setState(() {
                                  _model.updateAnswerListAtIndex(
                                    _model.quesNum,
                                    (_) => _model.currentAns,
                                  );
                                  _model.quesNum = _model.quesNum + 1;
                                  _model.prog = _model.prog + 0.1;
                                });
                              },
                              text: 'Next',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFF093462),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                elevation: 6,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          if (_model.quesNum == 9)
                            FFButtonWidget(
                              onPressed: () async {
                                _model.updateAnswerListAtIndex(
                                  _model.quesNum,
                                  (_) => _model.currentAns,
                                );
                                if (await _model.upload_stress() != '') {
                                  context.goNamed(
                                    'stressResult',
                                    queryParameters: {
                                      'stressResult': serializeParam(
                                        _model.stressLevel,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                } else {
                                  setState(() {});
                                }
                              },
                              text: 'Finish',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Colors.black,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                elevation: 6,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
