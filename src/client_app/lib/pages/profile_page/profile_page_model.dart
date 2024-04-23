import '/flutter_flow/flutter_flow_util.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';
import 'package:food/dio.dart';
import 'package:dio/dio.dart';
import 'package:food/util.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  Local state fields for this page.
  Dio dio = DioSingleton.getInstance();

  bool isLoggedIn = false;

  bool fetchComplete = false;

  String userName = 'Guest';

  String userEmail = 'guest@email.com';

  String userId = '1234';

  String? userContact = '';

  String lang = 'English';

  String? userBirthDate;

  late String userImage;

  String? userPassword;

  List<Map<String, dynamic>> stressLevelData = [];

  late BuildContext context;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameController;
  String? Function(BuildContext, String?)? nameControllerValidator;
  // State field(s) for id widget.
  FocusNode? idFocusNode;
  TextEditingController? idController;
  String? Function(BuildContext, String?)? idControllerValidator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for birthdate widget.
  FocusNode? birthdateFocusNode;
  TextEditingController? birthdateController;
  String? Function(BuildContext, String?)? birthdateControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for emailAddress_Create widget.
  FocusNode? emailAddressCreateFocusNode;
  TextEditingController? emailAddressCreateController;
  String? Function(BuildContext, String?)?
      emailAddressCreateControllerValidator;
  // State field(s) for password_create widget.
  FocusNode? passwordCreateFocusNode;
  TextEditingController? passwordCreateController;
  late bool passwordCreateVisibility;
  String? Function(BuildContext, String?)? passwordCreateControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    this.context = context;
    passwordVisibility = false;
    passwordCreateVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    nameFocusNode?.dispose();
    nameController?.dispose();

    idFocusNode?.dispose();
    idController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressController?.dispose();

    birthdateFocusNode?.dispose();
    birthdateController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    emailAddressCreateFocusNode?.dispose();
    emailAddressCreateController?.dispose();

    passwordCreateFocusNode?.dispose();
    passwordCreateController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
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
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'(?=.*[A-Z])(?=.*[!@#$%^&*()_+]).*$').hasMatch(value)) {
      return 'Password must contain at least 1 capital letter and 1 special character';
    }
    return null;
  }

  String? validateUserId(String value) {
    // User ID validation (only numbers)
    if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
      return 'User ID must contain only numbers';
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

  Future<bool> register() async {
    try {
      Response response = await dio.post('${getHost()}api/register', data: {
        'userName': userName,
        'userId': userId,
        'userEmail': userEmail,
        'userPassword': userPassword,
        'userBirthDate': userBirthDate,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed : ${response.data['message']}'),
            duration: const Duration(seconds: 5),
          ),
        );
        return false;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred: $error'),
          duration: const Duration(seconds: 5),
        ),
      );
      return false;
    }
  }

  Future<bool> login() async {
    try {
      Response response = await dio.post('${getHost()}api/login', data: {
        'userEmail': userEmail,
        'userPassword': userPassword,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        // Login failed, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed : ${response.data['message']}'),
            duration: const Duration(seconds: 5),
          ),
        );
        // Print the error message
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
      // Print the error message
      return false;
    }
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
          response.data['user']['stressData'],
        );
        userImage = response.data['user']['userImage'];
        print(stressLevelData);
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

  Future<void> logout() async {
    try {
      Response response = await dio.post('${getHost()}api/logout');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logout succesful'),
            duration: Duration(seconds: 5),
          ),
        );
        context.goNamed('mainPage');
      }
    } catch (error) {}
  }
}
