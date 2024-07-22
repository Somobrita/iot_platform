import 'dart:convert';

import 'package:asset_tracker/models/user/result.dart';
import 'package:asset_tracker/models/user/user_model.dart';
import 'package:asset_tracker/resource/app_resource.dart';
import 'package:asset_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../provider/api_data_provider.dart';
import '../../widgets/custom_search_delegate.dart';
import '../../widgets/error_screen.dart';
import '../../widgets/no_data_screen.dart';
import 'add_user_screen.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class UserManagement extends ConsumerStatefulWidget {
  const UserManagement({super.key});

  @override
  ConsumerState<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends ConsumerState<UserManagement> {
  late Future<List<Result>> _loadedItems;

  void _reload() {
    ref.invalidate(loadUserProvider);
    ref.read(loadUserProvider);
    /*setState(() {
      _loadedItems = Future.value([]);
      //_error = null;
      //_isLoading = true;
      _loadedItems = _loadUsers();
    });*/
  }

  Future<List<Result>> _loadUsers() async {
    /// Here we getting/fetch data from server
    const String userUrl = AppApi.getAllUserApi;

    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    print('authToken $authToken');

    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
      // Add other headers as needed, e.g., 'Authorization'
    };
    print('userUrl $userUrl');
    print('headers $headers');
    final response = await http.get(Uri.parse(userUrl), headers: headers);
    print('response.statusCode ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      UserModel areaList = UserModel.fromJson(responseBody);
      print('User fetch. $responseBody');
      print('User fetch List $areaList');
      if (areaList.result != null) {
        return areaList.result!;
      } else {
        return [];
      }
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  void _addNewUser() async {
    final isAdded = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (context) {
        return const AddUserScreen();
      },
    ));

    if (isAdded!) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'User add feature available soon!',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(
          seconds: 5,
        ),
        backgroundColor: Colors.black,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    ref.read(loadUserProvider);
    //_loadedItems = _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    var userData = ref.watch(loadUserProvider);
    return Scaffold(
      /// WillPopScope is a widget in the Flutter framework, which is used for
      /// controlling the behavior of the back button or the system navigation
      /// gestures on Android devices. It allows you to intercept and handle
      /// the back button press event to perform custom actions
      ///
      /// Inside the CustomScrollView, we add several Sliver widgets:
      //
      // SliverAppBar: A flexible app bar with a title.
      // SliverList: A scrollable list of items.
      // SliverGrid: A scrollable grid with cards.
      // SliverToBoxAdapter: A custom container with non-sliver content.
      // SliverFillRemaining: A custom container with fills all remaining space in a
      // scroll view, and lays a box widget out inside that space.

      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            forceElevated: true,
            elevation: 4,
            floating: true,
            snap: true,
            title: Text(
              Constants.userManagement,
              style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  _loadedItems.then((List<Result> value) {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate<Result>(
                          optionName: Constants.userManagement,
                          searchList: value),
                    );
                  });
                },
              ),
              IconButton(
                onPressed: _addNewUser,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: _reload,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SliverFillRemaining(
            child: userData.when(
              data: (data) {
                List<Result> userList = data.map((e) => e).toList();
                if (userList.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: NoDataScreen(onRetry: _reload),
                  );
                }
                return const Card(
                  child: Text(Constants.userManagement),
                );
              },
              error: (error, stackTrace) {
                return Center(
                  child: ErrorScreen(
                      errorMessage: error.toString(), onRetry: _reload),
                );
              },
              loading: () {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blueAccent,
                    size: 70,
                  ),
                );
              },
            ),
          ),
          /*SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder(
                  future: _loadedItems,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blueAccent,
                      size: 70,
                    ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (snapshot.data!.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      child: const Text('No Users available'),
                    );
                  }
                  return const Card(
                    child: Text(Constants.userManagement),
                  );
                },);
              },
            ),
          )*/
        ],
      ),
    );
  }
}
