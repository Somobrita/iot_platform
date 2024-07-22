import 'dart:convert';

import 'package:asset_tracker/models/login/login_model.dart';
import 'package:asset_tracker/resource/app_resource.dart';
import 'package:asset_tracker/screens/alarms/alarms_screen.dart';
import 'package:asset_tracker/screens/area/area_management_screen.dart';
import 'package:asset_tracker/screens/asset_report/asset_track_report_screen.dart';
import 'package:asset_tracker/screens/assets/asset_management_screen.dart';
import 'package:asset_tracker/screens/dashboard/all_assets_screen.dart';
import 'package:asset_tracker/screens/dashboard/assets_chart_screen.dart';
import 'package:asset_tracker/screens/iot_core/device_management_screen.dart';
import 'package:asset_tracker/screens/iot_core/service_management_screen.dart';
import 'package:asset_tracker/screens/locate/locate_asset_screen.dart';
import 'package:asset_tracker/screens/login/login_screen.dart';
import 'package:asset_tracker/screens/user/user_management_screen.dart';
import 'package:asset_tracker/screens/zone/zone_management_screen.dart';
import 'package:asset_tracker/utils/constants.dart';
import 'package:asset_tracker/utils/database_helper.dart';
import 'package:asset_tracker/utils/utils.dart';
import 'package:asset_tracker/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../models/login/change_password_model.dart';
import '../provider/app_theme_provider.dart';
import '../widgets/cancel_button.dart';
import '../widgets/submit_button.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key, required this.loginModel});

  final LoginModel loginModel;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final FocusNode _currentFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();
  final FocusNode _newFocus = FocusNode();
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  void _setScreen(String identifier) {
    // Close the drawer
    Navigator.pop(context);

    if (identifier == Constants.dashBoard) {
      /// pushReplacement will replace the previous/active screen in stack and
      /// push will add the screen on top of previous/active screen
      /// in stack and back button will come automatically
      /// when user back it will return Map<Filter, bool> value and store to result
      /*Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const DashboardScreen(),
        ),
      );*/
    } else if (identifier == Constants.userManagement) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const UserManagement();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    } else if (identifier == Constants.deviceManagement) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const DeviceManageScreen();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    } else if (identifier == Constants.serviceManagement) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const ServiceManagementScreen();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    } else if (identifier == Constants.areaManagement) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const AreaManagementScreen();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    } else if (identifier == Constants.zoneManagement) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const ZoneManagementScreen();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    } else if (identifier == Constants.assetManagement) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const AssetManagementScreen();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    } else if (identifier == Constants.assetTrackReport) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const AssetTrackReportScreen();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    } else if (identifier == Constants.locateAsset) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const LocateAssetScreen();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    } else if (identifier == Constants.alarms) {
      // By default Category page showing that why If we are choose the food then close the drawer
      //Navigator.pop(context);
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const AlarmsScreen();
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to left
            const begin = Offset(1.0, 0.0);

            /// Left to Right
            //const begin = Offset(-1.0, 0.0);
            /// Top to Bottom
            //const begin = Offset(0.0, -1.0);
            /// Bottom to Top
            //const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            /// Curves to specify the timing of transitions and animations.
            /// Curves are used to define how the animation values change
            /// over time.
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

            /*var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );*/
          },
        ),
      );
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  Future<bool> _logout() async {
    /// Here we getting/fetch data from server
    const String logoutUrl = AppApi.logoutApi;
    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    print('authToken $authToken');
    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
    };
    print('logoutUrl $logoutUrl');
    print('headers $headers');
    final response = await http.get(Uri.parse(logoutUrl), headers: headers);
    print('response.statusCode ${response.statusCode}');
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      print('Logout fetch. $responseBody');
      // Delete all
      await storage.deleteAll();
      return true;
    } else {}
    return true;
  }

  void _changePassword(BuildContext context) async {
    Navigator.pop(context);
    Utils().showLoaderDialog(context);

    /// Here we getting/fetch data from server
    const String logoutUrl = AppApi.changePasswordApi;
    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    print('authToken $authToken');
    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
    };
    final Map<String, dynamic> body = {
      AppApiKey.currentPassword: _currentPassword,
      AppApiKey.newPassword: _newPassword,
    };
    print('changePasswordUrl $logoutUrl');
    print('headers $headers');
    final response = await http.post(
      Uri.parse(logoutUrl),
      headers: headers,
      body: json.encode(body),
    );
    print('response.statusCode ${response.statusCode}');
    if (response.statusCode == 200) {
      ChangePasswordModel responseBody = json.decode(response.body);
      print('Change Password fetch. $responseBody');
      if (responseBody.isSuccess == true) {
        // Delete all
        await storage.deleteAll();
        _currentController.clear();
        _newController.clear();
        _confirmController.clear();
        Navigator.pop(context);
        _passwordChangedSuccessDialog();
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Some thing went wrong. Try again!',
              style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
            ),
            backgroundColor: Theme.of(context).colorScheme.onBackground,
          ),
        );
      }
    }
  }

  void _onCancelClick() {
    _formKey.currentState?.reset();
    _currentController.clear();
    _newController.clear();
    _confirmController.clear();
    Navigator.of(context).pop();
  }

  void _onSubmitClick() {
    final isValid = _formKey.currentState!.validate();
    print('Form isValid: $isValid');
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    print('Current password: ${_currentController.text}');
    print('New password: ${_newController.text}');
    print('Confirm password: ${_confirmController.text}');

    _changePassword(context);
  }

  void _onLogoutClick() async {
    bool isLogout = await _logout();
    //bool isLogout = true;
    if (isLogout) {
      DatabaseHelper().deleteAll();
      Navigator.of(context).pop();
      setState(() {
        ref.read(appThemeProvider.notifier).setTheme(false);
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            //ref.read(appThemeProvider.notifier).setTheme(!isDarkMode);
            /*bool theme = ref.read(appThemeProvider).getTheme();
              print('User dark theme $theme');
              if (theme){
                //ref.read(appThemeProvider).setThemeLight(false);
                ref.read(appThemeProvider.notifier).setThemeLight(false);
              }*/
            return const LoginScreen();
          },
        ),
      );
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Stack(children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFC72C41),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: const Text(
                'Logout failed',
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
          duration: Duration(seconds: 2),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
  }

  Future<void> _changePasswordDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        'Change Password',
        style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 20),
      ),

      /// In Flutter, the StatefulBuilder widget is often used when you need to
      /// rebuild a part of the UI tree in response to user interactions without
      /// rebuilding the entire widget tree. This can be useful when working with dialogs,
      content: StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _currentController,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Password',
                        labelText: 'Current Password',
                        labelStyle: const TextStyle(fontSize: 18),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _currentFocus,
                      onFieldSubmitted: (value) {
                        Utils().fieldFocusChange(context, _currentFocus, _newFocus);
                      },
                      /*onEditingComplete: () {
                            Utils().fieldFocusChange(context, _currentFocus,
                                _newFocus);
                          },*/
                      onSaved: (currentPassword) {
                        this._currentPassword = currentPassword!;
                      },
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      validator: (currentPassword) {
                        if (currentPassword == null || currentPassword.isEmpty) {
                          return "Please Input Current Password";
                        } else {
                          return null;
                        }
                      },
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _newController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Password',
                        labelText: 'New Password',
                        labelStyle: const TextStyle(fontSize: 18),
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _newFocus,
                      onFieldSubmitted: (value) {
                        Utils()
                            .fieldFocusChange(context, _newFocus, _confirmFocus);
                      },
                      /*onEditingComplete: () {
                            Utils().fieldFocusChange(context, _newFocus, _confirmFocus);
                          },*/
                      onSaved: (newPassword) {
                        this._newPassword = newPassword!;
                      },
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      validator: (newPassword) {
                        if (newPassword == null || newPassword.isEmpty) {
                          return "Please Input New Password";
                        } else {
                          return null;
                        }
                      },
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Password',
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(fontSize: 18),
                      ),
                      textInputAction: TextInputAction.done,
                      focusNode: _confirmFocus,
                      onFieldSubmitted: (value) {
                        _confirmFocus.unfocus();
                      },
                      /*onEditingComplete: () {
                            _confirmFocus.unfocus();
                          },*/
                      onSaved: (confirmPassword) {
                        this._confirmPassword = confirmPassword!;
                      },
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      validator: (confirmPassword) {
                        if (confirmPassword == null || confirmPassword.isEmpty) {
                          return "Please Input Confirm Password";
                        } else if (_newController.text != confirmPassword) {
                          return "New and Confirm Password Must be Same.";
                        } else {
                          return null;
                        }
                      },
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },),
      actions: [
        CancelButton(
          cancelText: AppTexts.cancel,
          onCancelClick: _onCancelClick,
        ),
        SubmitButton(
          submitText: AppTexts.change,
          onSubmitClick: _onSubmitClick,
        ),
      ],
    );
    // show the dialog
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const SizedBox.expand(child: FlutterLogo()),
        );
      },
      transitionBuilder: (ctx, anim, a2, child) {
        var curve = Curves.easeInOut.transform(anim.value);
        return Transform.scale(
          scale: curve,
          child: alertDialog,
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
      barrierDismissible: false,
      barrierLabel: "Barrier",
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void _passwordChangedSuccessDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const SizedBox.expand(child: FlutterLogo()),
        );
      },
      transitionBuilder: (ctx, anim, a2, child) {
        var curve = Curves.easeInOut.transform(anim.value);
        return Transform.scale(
          scale: curve,
          child: WillPopScope(
            child: AlertDialog(
              title: Text(
                'Password Changed Successfully',
                style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your password has been changed successfully. Please login again with new password!",
                    style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    DatabaseHelper().deleteAll();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    AppTexts.ok,
                    style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ),
                  ),
                ),
              ],
            ),
            onWillPop: () async {
              return false;
            },
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
      barrierDismissible: false,
      barrierLabel: "Barrier",
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void _logoutAccountDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      /*shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),*/
      title: Text(
        AppTexts.logoutAlert,
        style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 24,
            ),
      ),
      content: Text(
        AppTexts.logoutMessage,
        style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 14,
            ),
      ),
      actions: [
        CancelButton(
          cancelText: AppTexts.cancel,
          onCancelClick: () {
            Navigator.of(context).pop();
          },
        ),
        SubmitButton(
          submitText: AppTexts.logout,
          onSubmitClick: _onLogoutClick,
        ),
      ],
    );

    // show the dialog
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const SizedBox.expand(child: FlutterLogo()),
        );
      },
      transitionBuilder: (ctx, anim, a2, child) {
        var curve = Curves.easeInOut.transform(anim.value);
        return Transform.scale(
          scale: curve,
          child: alert,
        );
        /*return Transform.rotate(
          angle: math.radians(anim.value * 360),
          child: _dialog(ctx),
        );*/

        /*Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );*/
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: "Barrier",
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentController.dispose();
    _confirmController.dispose();
    _newController.dispose();
    _currentFocus.dispose();
    _newFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = ref.watch(appThemeProvider).getTheme();
    //Widget activePage = const AssetsChartScreen();
    String activeText = Constants.assetChart;

    if (_selectedIndex == 1) {
      //final favoriteFoods = ref.watch(favoriteFood);
      //activePage = const AllAssetsScreen();
      activeText = Constants.allAssets;
    }

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.background,
      /// bottomNavbar is moving up with the keyboard when the keyboard is enabled.
      /// I solved it by checking if the keyboard is open or not. If it is open,
      /// just hide the disable the bottomNavbar and when it is closed, it's
      /// time to enable the navbar resizeToAvoidBottomInset
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        // Set the preferred height of the AppBar
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15), // Adjust border radius as needed
            bottomRight: Radius.circular(15),
          ),
          child: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            // hides default back button
            automaticallyImplyLeading: false,
            //backgroundColor: Colors.transparent,
            title: Text(
              activeText,
              style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: <Color>[Colors.black, Colors.blue]),
              ),
            ),
            actions: [
              /*if (_selectedIndex == 1)
                IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),*/
              Switch(
                value: isDarkMode,
                onChanged: (value) async {
                  var data = await DatabaseHelper().queryAll();
                  if (data.isNotEmpty) {
                    setState(() {
                      ref.read(appThemeProvider.notifier).setTheme(!isDarkMode);
                    });
                  }
                },
                inactiveThumbColor: Colors.white,
                activeColor: Colors.white,

                activeTrackColor: AppColors.switchThemeColor,
                //inactiveThumbColor: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  _logoutAccountDialog(context);
                },
                icon: const Icon(Icons.logout),
              ),
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'change_password',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/change_password.png',
                          color: AppColors.contentColorBlue,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Change Password'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  // Handle menu item selection
                  if (value == 'change_password') {
                    _changePasswordDialog(context);
                  }
                },
              ),
            ],
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
      ),
      drawer: MainDrawer(
          userName: widget.loginModel.name,
          userEmail: widget.loginModel.email,
          onSelect: _setScreen),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          allowImplicitScrolling: true,
          children: const <Widget>[
            AssetsChartScreen(),
            AllAssetsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        // Set the preferred height of the AppBar
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            onTap: (index) {
              _selectPage(index);
            },
            currentIndex: _selectedIndex,
            // Color for selected item
            selectedItemColor: AppColors.contentColorBlue,
            // Color for unselected item
            unselectedItemColor: Colors.blueGrey,
            selectedLabelStyle:
                GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
            unselectedLabelStyle:
                GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 15,
                    ),
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                //backgroundColor: Colors.lightGreenAccent,
                icon: Icon(Icons.pie_chart,),
                label: Constants.assetChart,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assessment),
                label: Constants.allAssets,
              )
            ],
          ),
        ),
      ),
    );
  }
}
