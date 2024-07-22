import 'dart:convert';

import 'package:asset_tracker/models/login/login_model.dart';
import 'package:asset_tracker/resource/app_resource.dart';
import 'package:asset_tracker/screens/main_screen.dart';
import 'package:asset_tracker/utils/database_helper.dart';
import 'package:asset_tracker/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

import '../../models/login/new_login_model.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  var _isAuthenticating = false;
  var _isLogged = false;

  // Initially password is obscure
  bool _showPassword = false;
  late LoginModel _loginModel;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    print('User isValid: $isValid');

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();
    print('User Email: $_email');
    print('User password: $_password');

    var isInternetAvailable = await Utils().checkInternetConnectivity();
    if(isInternetAvailable){
      try {
        setState(() {
          _isAuthenticating = true;
        });
      } catch (error) {}
      const String loginUrl = AppApi.loginApi;

      print('User login url $loginUrl');
      final Map<String, String> headers = {
        AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
        AppApiKey.acceptKey: AppApiKey.acceptValue,
        // Add other headers as needed, e.g., 'Authorization'
      };
      final Map<String, dynamic> body = {
        AppApiKey.email: _email,
        AppApiKey.password: _password,
      };
      final response = await http.post(
        Uri.parse(AppApi.loginApi),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Login was successful
        final responseBody = json.decode(response.body);
        print('User Login successful. $responseBody');

        LoginResponseModel loginModel = LoginResponseModel.fromJson(responseBody);

        if (loginModel.isSuccess!) {
          String tempId = const Uuid().v4();
          int insertId = await DatabaseHelper().insert({
            AppDatabase.userId: tempId,
            AppDatabase.email: _email,
            AppDatabase.token: loginModel.token,
            AppDatabase.name: loginModel.user!.firstName,
          });

          _loginModel = LoginModel.fromJson({
            AppDatabase.userId: tempId,
            AppDatabase.email: _email,
            AppDatabase.token: loginModel.token,
            AppDatabase.name: loginModel.user!.firstName,
          });
          print('User insertId: $insertId');
          // Create storage
          const storage = FlutterSecureStorage();
          // Write token value
          await storage.write(key: AppDatabase.token, value: loginModel.token);

          setState(() {
            _isLogged = true;
          });
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Stack(children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC72C41),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Login failed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 40,
                        )
                      ],
                    ),
                  ),
                )
              ]),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
          // Login failed
          print('User Login failed. Status code: ${response.statusCode}');
          setState(() {
            _isLogged = false;
            _isAuthenticating = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            width: double.infinity,
            content: Stack(children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 80,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFC72C41),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Text(
                  'Login failed',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 20,
                      )
                    ],
                  ),
                ),
              )
            ]),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        // Login failed
        print('User Login failed. Status code: ${response.statusCode}');
        setState(() {
          _isLogged = false;
          _isAuthenticating = false;
        });
      }

    }else{
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          width: double.infinity,
          content: const Text(
            'No Internet Available. Connect and try again later!.',
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          elevation: 0,
        ),
      );
    }

  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: _isLogged
          ? MainScreen(
              loginModel: _loginModel,
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  tileMode: TileMode.decal,
                  colors: [
                    AppColors.contentColorBlue,
                    Colors.white,
                  ], // Your two colors
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          right: 20,
                        ),
                        child: Text(
                          AppTexts.aceHospitalAsset,
                          style: GoogleFonts.latoTextTheme()
                              .titleLarge!
                              .copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 300,
                          minWidth: double.infinity,
                          maxHeight: 430,
                        ),
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          margin: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Color(0x90a2a2f6),
                                      child: Icon(Icons.login),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColors.contentColorPurple,
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 2.0,
                                          ),
                                        ),
                                        label: Text(AppTexts.email),
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _emailFocus,
                                      onFieldSubmitted: (value) {
                                        Utils().fieldFocusChange(context,
                                            _emailFocus, _passwordFocus);
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty ||
                                            !EmailValidator.validate(value)) {
                                          return AppTexts
                                              .pleaseEnterValidPassword;
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        _email = newValue!;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      focusNode: _passwordFocus,
                                      onFieldSubmitted: (value) {
                                        _passwordFocus.unfocus();
                                      },
                                      obscureText: !_showPassword,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColors.contentColorPurple,
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 2.0,
                                          ),
                                        ),
                                        label: const Text(AppTexts.password),
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: GestureDetector(
                                            onTap: () {
                                              _toggle();
                                            },
                                            child: Icon(
                                              _showPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            )),
                                        border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,

                                      /// Hide the password
                                      //obscureText: _obscureText,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty ||
                                            value.trim().length < 6) {
                                          return 'Password must be at least 6 characters.';
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        _password = newValue!;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    if (_isAuthenticating)
                                      LoadingAnimationWidget.staggeredDotsWave(
                                        color: Colors.blueAccent,
                                        size: 70,
                                      ),
                                    if (!_isAuthenticating)
                                      ElevatedButton(
                                        onPressed: _submit,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.contentColorPurple,
                                        ),
                                        child: Text(
                                          AppTexts.signIn,
                                          style: GoogleFonts.latoTextTheme()
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    if (!_isAuthenticating)
                                      TextButton(
                                        onPressed: () {
                                          _formKey.currentState?.reset();
                                          setState(() {});
                                        },
                                        child: Text(
                                          AppTexts.createNewAccount,
                                          style: GoogleFonts.latoTextTheme()
                                              .bodyLarge!
                                              .copyWith(
                                                color: const Color(0x900707ce),
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
