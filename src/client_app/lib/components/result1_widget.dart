import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'result1_model.dart';
export 'result1_model.dart';

class Result1Widget extends StatefulWidget {
  const Result1Widget({
    super.key,
    String? parameter1,
  }) : this.parameter1 = parameter1 ?? '';

  final String parameter1;

  @override
  State<Result1Widget> createState() => _Result1WidgetState();
}

class _Result1WidgetState extends State<Result1Widget> {
  late Result1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Result1Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: MediaQuery.sizeOf(context).height * 0.56,
      decoration: BoxDecoration(
        color: Color(0xFF009478),
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
            progressColor: Color(0xFF00FF0A),
            backgroundColor: FlutterFlowTheme.of(context).accent4,
            center: Text(
              widget.parameter1,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
            ),
            startAngle: 215.0,
          ),
          Container(
            width: 288.0,
            height: 245.0,
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
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
