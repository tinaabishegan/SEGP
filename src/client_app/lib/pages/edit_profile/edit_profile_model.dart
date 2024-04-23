import 'dart:convert';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:flutter/material.dart';
import 'package:food/dio.dart';
import 'package:dio/dio.dart';
import 'package:food/util.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  Local state fields for this page.
  Dio dio = DioSingleton.getInstance();

  String userName = 'Guest';

  String userEmail = 'guest@gmail.com';

  String userId = '1';

  String userBirthDate = '2012-02-27 13:27:00';

  String? userOldPassword;

  late String userImage;

  String? userNewPassword;

  bool fetchComplete = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController6;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? textController6Validator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    passwordVisibility1 = false;
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();

    textFieldFocusNode6?.dispose();
    textController6?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  String formatDate(String dateTimeString) {
    DateTime utcDateTime = DateTime.parse(dateTimeString);
    // Replace 'UTC' with your local time zone identifier
    DateTime localDateTime = utcDateTime.toLocal();

    String formattedDate = DateFormat('yyyy-MM-dd').format(localDateTime);

    return formattedDate;
  }

  String? validateEmail(String value) {
    // Simple email validation
    if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    // Password validation (at least 8 characters, 1 capital letter, 1 special character)
    if (value == '') {
      return null;
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'(?=.*[A-Z])(?=.*[!@#$%^&*()_+]).*$').hasMatch(value)) {
      return 'Password must contain at least 1 capital letter and 1 special character';
    }
    return null;
  }

  String? validateBirthdate(DateTime value) {
    // Birthdate validation
    // ignore: unnecessary_null_comparison
    if (value == null) {
      return 'Please select a valid birthdate';
    }
    return null;
  }

  String? validateName(String value) {
    // Name validation (only text)
    if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
      return 'Enter a valid name';
    }
    return null;
  }

  Future<String> compressImageToBase64(Uint8List originalBytes) async {
    // Define the maximum target file size (in bytes)
    const int maxFileSizeBytes = 60 * 1024; // 60KB

    // Initialize quality (0-100, higher values mean better quality)
    int quality = 80;

    // Compress the image iteratively until the file size is below the limit
    Uint8List compressedBytes = originalBytes;
    while (compressedBytes.length > maxFileSizeBytes) {
      compressedBytes = await FlutterImageCompress.compressWithList(
        compressedBytes,
        quality: quality,
      );

      // Reduce quality for the next iteration
      quality -= 20; // Adjust as needed
      // if (quality < 10) {
      //   // If quality becomes too low, break the loop
      //   break;
      // }
    }

    // Encode the compressed image bytes to base64
    final compressedBase64 = base64.encode(compressedBytes);
    return compressedBase64;
  }

  Future<void> edit_profile(BuildContext context) async {
    print("comp");
    userImage = await compressImageToBase64(base64Decode(userImage));
    print("donecomp");
    try {
      Response response = await dio.post('${getHost()}api/edit_profile', data: {
        'userName': userName,
        'userEmail': userEmail,
        'userBirthDate': userBirthDate,
        'userOldPassword': userOldPassword,
        'userNewPassword': userNewPassword,
        'userImage': userImage,
      });

      if (response.statusCode == 200) {
        context.goNamed('mainPage');
        print("yoo");
      } else {
        // Handle error, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Failed to save changes: ${response.data['message']}'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (error) {
      // Handle Dio errors, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred: $error'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<bool> profile(BuildContext context) async {
    try {
      Response response = await dio.post('${getHost()}api/profile');

      if (response.statusCode == 200) {
        userName = response.data['user']['userName'];
        userId = response.data['user']['userId'];
        userEmail = response.data['user']['userEmail'];
        userBirthDate = response.data['user']['userBirthDate'];
        userImage = response.data['user']['userImage'];
        return true;
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
        return false;
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
      return false;
    }
  }
}
