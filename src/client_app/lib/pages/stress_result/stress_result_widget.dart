import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'stress_result_model.dart';
export 'stress_result_model.dart';

class StressResultWidget extends StatefulWidget {
  const StressResultWidget({
    super.key,
    required this.stressResult,
  });

  final String? stressResult;

  @override
  State<StressResultWidget> createState() => _StressResultWidgetState();
}

class _StressResultWidgetState extends State<StressResultWidget>
    with TickerProviderStateMixin {
  late StressResultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 200.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StressResultModel());

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
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.goNamed('mainPage');
                  },
                ),
                title: Text(
                  'Results',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.88,
                    height: MediaQuery.sizeOf(context).height * 0.119,
                    decoration: BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'Stress Test Diagnosis Result',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Text(
                          'This is a guide for you to understand how you will receive your stress level result and stress management advice.',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.stressResult == 'No Stress')
                SingleChildScrollView(
                    child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  decoration: BoxDecoration(
                    color: Color(0xFF4682A9),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        percent: 1.0,
                        radius: MediaQuery.sizeOf(context).width * 0.2,
                        lineWidth: 20.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: Color(0xFF112D4E),
                        backgroundColor: Color(0x00FFFFFF),
                        center: Text(
                          'No Stress',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                        ),
                        startAngle: 215.0,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0x22000000),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Color(0x00F6F6F6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Your stress diagnosis results indicate that your stress levels are negligibly low.\nThis could indicate that you are in a state of sustress (too little stress).\nThis could be good news, but a lack of stress in long term can result boredom and depression.\nIt is recommended to have low to moderate levels of stress.',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              if (widget.stressResult == 'Low Stress')
                SingleChildScrollView(
                    child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  decoration: BoxDecoration(
                    color: Color(0xFF4E6C50),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        percent: 1.0,
                        radius: MediaQuery.sizeOf(context).width * 0.2,
                        lineWidth: 20.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: Color(0xFF395144),
                        backgroundColor: Color(0x00FFFFFF),
                        center: Text(
                          'Low Stress',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                        ),
                        startAngle: 215.0,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0x22000000),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Color(0x00F6F6F6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Your stress diagnosis results indicate that your stress levels are low, which is beneficial for your psychological well-being.\n\n Research from the Youth Development Institute at the University of Georgia suggests that low stress levels may act as a form of psychological inoculation, potentially protecting against the development of mental health symptoms.\n',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              if (widget.stressResult == 'Mid Stress')
                SingleChildScrollView(
                    child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  decoration: BoxDecoration(
                    color: Color(0xFFD7A86E),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        percent: 1.0,
                        radius: MediaQuery.sizeOf(context).width * 0.2,
                        lineWidth: 20.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: Color(0xFFFFEBC1),
                        backgroundColor: Color(0x00FFFFFF),
                        center: Text(
                          'Mid Stress',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                        ),
                        startAngle: 215.0,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0x22000000),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Color(0x00F6F6F6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Your stress diagnosis results indicate that your stress levels are moderate, which is beneficial for your psychological well-being.\n \nAccording to research from the Youth Development Institute at the University of Georgia, it has been found that moderate levels of stress can help individuals develop resilience and reduce the risk of developing mental health disorders, like depression and antisocial behaviours.',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              if (widget.stressResult == 'High Stress')
                SingleChildScrollView(
                    child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  decoration: BoxDecoration(
                    color: Color(0xFF8E3200),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        percent: 1.0,
                        radius: MediaQuery.sizeOf(context).width * 0.2,
                        lineWidth: 20.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: Color(0xFFA64B2A),
                        backgroundColor: Color(0x00FFFFFF),
                        center: Text(
                          'High Stress',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                        ),
                        startAngle: 215.0,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0x22000000),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Color(0x00F6F6F6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Your stress diagnosis results indicate that your stress levels are high.  You may experience constant worry, or hopeless due to the never-ending dread.\n\nBoth of those feelings can cause issues with sleep, concentration, and memory due to an overload of worried thoughts, according to the National Library of Medicine.\n',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            ],
          ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
