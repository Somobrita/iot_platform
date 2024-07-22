import 'dart:convert';

import 'package:asset_tracker/models/asset_report/tabular_view_model.dart';
import 'package:asset_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../widgets/error_screen.dart';
import '../../widgets/no_data_screen.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class TabularViewScreen extends StatefulWidget {
  const TabularViewScreen({super.key});

  @override
  State<TabularViewScreen> createState() => _TabularViewScreenState();
}

class _TabularViewScreenState extends State<TabularViewScreen> {
  late Future<List<TabularViewModel>> _loadedItems;

  void _reload() {
    setState(() {
      _loadedItems = Future.value([]);
      //_error = null;
      //_isLoading = true;
      _loadedItems = _loadTabularData();
    });
  }

  Future<List<TabularViewModel>> _loadTabularData() async {
    /// Here we getting/fetch data from server
    final url = Uri.https(
        'https://www.iotace.mindteck.com/pages/user-management/area-list');
    final response = await http.get(url);
    print('response.statusCode ${response.statusCode}');
    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data. Please try again later!');
    }
    print(response.body);

    /// if no data available in firebase then response will 'null'
    if (response.body == 'null') {
      /*setState(() {
        _isLoading = false;
      });*/
      return [];
    }
    final Map<String, dynamic> listUser = json.decode(response.body);
    print(listUser);
    List<TabularViewModel> localList = [];
    /*for (final item in listGrocery.entries) {
      final category = categories.entries
          .firstWhere(
            (element) => element.value.title == item.value['category'],
      )
          .value;
      localList.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }*/
    return localList;
  }

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadTabularData();
  }

  @override
  Widget build(BuildContext context) {
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
          return Center(
            child: ErrorScreen(errorMessage: '', onRetry: _reload),
          );
        }

        if (snapshot.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: NoDataScreen(onRetry: _reload),
          );
        }
        return const Card(
          child: Text(Constants.userManagement),
        );
      },
    );
  }
}
