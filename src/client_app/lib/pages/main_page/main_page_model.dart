import '/flutter_flow/flutter_flow_util.dart';
import 'main_page_widget.dart' show MainPageWidget;
import 'package:flutter/material.dart';
import 'package:food/dio.dart';
import 'package:dio/dio.dart';
import 'package:food/util.dart';

class MainPageModel extends FlutterFlowModel<MainPageWidget> {
  ///  Local state fields for this page.

  Dio dio = DioSingleton.getInstance();

  String userName = 'Guest';

  String stressLevel = 'No Stress';

  late String userEmail;

  late String userId;

  late String userBirthDate;

  late String userImage;

  String? userPassword;

  bool isLoggedIn = false;

  bool fetchComplete = false;

  List<Map<String, dynamic>> stressLevelData = [];

  late BuildContext context;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    this.context = context;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  String calculateStressLevelCategory(
      List<Map<String, dynamic>> stressLevelData) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the date 30 days ago
    DateTime thirtyDaysAgo = currentDate.subtract(Duration(days: 30));

    // Filter entries within the past 30 days
    List<Map<String, dynamic>> past30DaysData = stressLevelData.where((entry) {
      // Parse 'date_tested' string into a DateTime object
      DateTime entryDate = DateTime.parse(entry['date_tested']);

      return entryDate.isAfter(thirtyDaysAgo) &&
          entryDate.isBefore(currentDate);
    }).toList();

    // Calculate the average stress level
    double averageStressLevel = past30DaysData.isNotEmpty
        ? past30DaysData
                .map((entry) => _stressLevelToNumeric(entry['stress_level']))
                .reduce((a, b) => a + b) /
            past30DaysData.length
        : 0.0;

    // Round up to the closest integer
    int roundedStressLevel = averageStressLevel.round();

    // Define stress level categories
    String stressLevelCategory;

    if (roundedStressLevel == 0) {
      stressLevelCategory = 'No Stress';
    } else if (roundedStressLevel == 1) {
      stressLevelCategory = 'Low Stress';
    } else if (roundedStressLevel == 2) {
      stressLevelCategory = 'Mid Stress';
    } else {
      stressLevelCategory = 'High Stress';
    }

    return stressLevelCategory;
  }

// Helper function to convert stress level string to numeric value
  double _stressLevelToNumeric(String stressLevel) {
    switch (stressLevel.toLowerCase()) {
      case 'no stress':
        return 0.0;
      case 'low stress':
        return 1.0;
      case 'mid stress':
        return 2.0;
      case 'high stress':
        return 3.0;
      default:
        return 0.0; // Default to 'No Stress' if unknown
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

  Future<void> profile() async {
    try {
      Response response = await dio.post('${getHost()}api/profile');

      if (response.statusCode == 200) {
        userName = response.data['user']['userName'];
        userId = response.data['user']['userId'];
        userEmail = response.data['user']['userEmail'];
        userBirthDate = response.data['user']['userBirthDate'];
        stressLevelData = List<Map<String, dynamic>>.from(
          response.data['user']['stressData'].map((item) {
            return {
              'date_tested': item['date_tested'] ?? DateTime(1).toString(),
              'stress_level': item['stress_level'] ?? '',
            };
          }),
        );
        userImage = response.data['user']['userImage'];
        stressLevel = calculateStressLevelCategory(stressLevelData);
      } else {
        // Handle error, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to fetch user profile with status: ${response.statusCode}'),
            duration: const Duration(seconds: 5),
          ),
        );
        print("db error");
      }
    } catch (error) {
      // Handle Dio errors, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred: $error'),
          duration: const Duration(seconds: 5),
        ),
      );
      print(error);
    }
  }
}
