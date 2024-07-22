import 'dart:async';
import 'dart:convert';

import 'package:asset_tracker/models/alarm/alarm_model.dart';
import 'package:asset_tracker/models/area/area_model.dart';
import 'package:asset_tracker/models/asset/asset_model.dart';
import 'package:asset_tracker/models/user/result.dart';
import 'package:asset_tracker/models/user/user_model.dart';
import 'package:asset_tracker/models/zone/zone_model.dart';
import 'package:asset_tracker/utils/constants.dart';
import 'package:asset_tracker/widgets/area_management_list_row.dart';
import 'package:asset_tracker/widgets/asset_management_list_row.dart';
import 'package:asset_tracker/widgets/zone_management_list_row.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class CustomSearchDelegate<T> extends SearchDelegate {
  CustomSearchDelegate({required this.optionName, required this.searchList});

  final String optionName;
  final List<T> searchList;
  String searchString = '';
  List searchResult = [];

  Future<List> search(searchData) async {
    Uri url = Uri.https(
        'https://iotace.mindteck.com/pages/user-management/user-list');
    switch (optionName) {
      case Constants.userManagement:
        url = Uri.https(
            'https://iotace.mindteck.com/pages/user-management/user-list');
        break;
      case Constants.areaManagement:
        url = Uri.https(
            'https://iotace.mindteck.com/pages/user-management/user-list');
        break;
      case Constants.zoneManagement:
        url = Uri.https(
            'https://iotace.mindteck.com/pages/user-management/user-list');
        break;
      case Constants.assetManagement:
        url = Uri.https(
            'https://iotace.mindteck.com/pages/user-management/user-list');
        break;
      case Constants.alarms:
        url = Uri.https(
            'https://iotace.mindteck.com/pages/user-management/user-list');
        break;
    }
    var param = {'searchby': searchData};
    var result = await http.post(url, body: param);

    if (result.statusCode >= 400) {
      throw Exception('Failed to fetch data. Please try again later!');
    }

    if (result.body == 'null') {
      return [];
    }

    final list = json.decode(result.body) as List;

    switch (optionName) {
      case Constants.userManagement:
        return list.map((e) => UserModel.fromJson(e)).toList();
      case Constants.areaManagement:
        return list.map((e) => AreaModel.fromJson(e)).toList();
      case Constants.zoneManagement:
        return list.map((e) => ZoneModel.fromJson(e)).toList();
      case Constants.assetManagement:
        return list.map((e) => AssetModel.fromJson(e)).toList();
      case Constants.alarms:
        return list.map((e) => AlarmModel.fromJson(e)).toList();
    }

    return [];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    /*ThemeData(
      primaryColor:  Colors.white,
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
        Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
      ),
    )*/
    final ThemeData theme = Theme.of(context).copyWith(
      hintColor: Theme.of(context).colorScheme.secondaryContainer,
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none
      ),
    );
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchResult.clear();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    /*AnimatedIcon(
      icon:AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
    )*/
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchResult.clear();
    switch (optionName) {
      case Constants.userManagement:
        searchResult = (searchList as Iterable<Result>)
            .where((item) =>
                item.firstName!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        break;
      case Constants.areaManagement:
        searchResult = (searchList as Iterable<AreaModel>)
            .where((item) =>
                item.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        break;
      case Constants.zoneManagement:
        searchResult = (searchList as Iterable<ZoneModel>)
            .where((item) =>
                item.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        break;
      case Constants.assetManagement:
        searchResult = (searchList as Iterable<AssetModel>)
            .where((item) =>
                item.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        break;
      case Constants.alarms:
        searchResult = (searchList as Iterable<AlarmModel>)
            .where((item) =>
                item.assetName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        break;
    }
    print('buildResults optionName $optionName');
    print('buildResults searchResultss $searchResult');
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          var item = searchResult[index];
          print('buildResults item $item');
          switch (optionName) {
            case Constants.userManagement:
              return Container();
            case Constants.areaManagement:
              return AreaManagementListRow(areaModel: item);
            case Constants.zoneManagement:
              print(
                  'buildResults Constants.zoneManagement ${Constants.zoneManagement}');
              return ZoneManagementListRow(zoneModel: item);
            case Constants.assetManagement:
              return AssetManagementListRow(assetModel: item);
            case Constants.alarms:
              return Container();
          }
          return Container();
        },
      ),
    );

    /* return FutureBuilder(
      future: search(query),
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
          return ErrorScreen(errorMessage: '', onRetry: () {});
        }
        if (snapshot.data!.isEmpty) {
          return NoDataScreen(onRetry: () {});
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data![index].title),
              onTap: () {
                close(context, snapshot.data![index]);
              },
            );
          },
          itemCount: snapshot.data!.length,
        );
      },
    );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    switch (optionName) {
      case Constants.userManagement:
        searchResult = query.isEmpty
            ? []
            : (searchList as Iterable<Result>).where((item) {
                return _containsLetters(
                    item.firstName!.toLowerCase(), query.toLowerCase());
                //return item.firstName!.toLowerCase().contains(query.toLowerCase());
              }).toList();
        break;
      case Constants.areaManagement:
        searchResult = query.isEmpty
            ? []
            : (searchList as Iterable<AreaModel>).where((item) {
                return _containsLetters(
                    item.name!.toLowerCase(), query.toLowerCase());
                //return item.name!.toLowerCase().contains(query.toLowerCase());
              }).toList();
        break;
      case Constants.zoneManagement:
        searchResult = query.isEmpty
            ? []
            : (searchList as Iterable<ZoneModel>).where((item) {
                return _containsLetters(
                    item.name!.toLowerCase(), query.toLowerCase());
                //return item.name!.toLowerCase().contains(query.toLowerCase());
              }).toList();
        break;
      case Constants.assetManagement:
        searchResult = query.isEmpty
            ? []
            : (searchList as Iterable<AssetModel>).where((item) {
                return _containsLetters(
                    item.name!.toLowerCase(), query.toLowerCase());
                //return item.name!.toLowerCase().contains(query.toLowerCase());
              }).toList();
        break;
      case Constants.alarms:
        searchResult = query.isEmpty
            ? []
            : (searchList as Iterable<AlarmModel>).where((item) {
                return _containsLetters(
                    item.assetName.toLowerCase(), query.toLowerCase());
                //return item.assetName!.toLowerCase().contains(query.toLowerCase());
              }).toList();
        break;
    }
    print('buildSuggestion optionName $optionName');
    print('buildSuggestion searchResult $searchResult');
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: searchResult.isNotEmpty
            ? _buildSuggestionsSuccess(context)
            : _buildNoSuggestions(context),
      ),
    );
    /*return FutureBuilder(
      future: search(query),
      builder: (context, snapshot) {
        if (query.isEmpty) return buildNoSuggestions();
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blueAccent,
                      size: 70,
                    ),);
          default:
            if (snapshot.hasError || snapshot.data!.isEmpty) {
              return buildNoSuggestions();
            } else {
              return buildSuggestionsSuccess(snapshot.data!!.);
            }
        }
      },
    );*/
  }

  Widget _buildNoSuggestions(BuildContext context) => Center(
        child: Text(
          'No suggestions!',
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
              ),
        ),
      );

  Widget _buildSuggestionsSuccess(BuildContext context) {
    print('_buildSuggestion optionName $optionName');
    print('_buildSuggestion searchResult $searchResult');

    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        switch (optionName) {
          case Constants.userManagement:
            searchString = searchResult[index].firstName!;
            break;
          case Constants.areaManagement:
            searchString = searchResult[index].name!;
            break;
          case Constants.zoneManagement:
            searchString = searchResult[index].name!;
            break;
          case Constants.assetManagement:
            searchString = searchResult[index].name!;
            break;
          case Constants.alarms:
            searchString = searchResult[index].assetName!;
            break;
        }
        //final suggestion = suggestions[index];
        final queryText = searchString.substring(0, query.length);
        final remainingText = searchString.substring(query.length);
        /*TextSpan(
          text: queryText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          children: [
            TextSpan(
              text: remainingText,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withAlpha(100),
                fontSize: 15,
              ),
            ),
          ],
        )*/
        print('buildSuggestion searchString $searchString');
        return ListTile(
          title: RichText(
            text: _searchMatchText(searchString, context),
          ),
          onTap: () {
            switch (optionName) {
              case Constants.userManagement:
                searchString = searchResult[index].firstName!;
                break;
              case Constants.areaManagement:
                searchString = searchResult[index].name!;
                break;
              case Constants.zoneManagement:
                searchString = searchResult[index].name!;
                break;
              case Constants.assetManagement:
                searchString = searchResult[index].name!;
                break;
              case Constants.alarms:
                searchString = searchResult[index].assetName!;
                break;
            }
            print('buildSuggestion tap searchString $searchString');
            print('buildSuggestion tap $query');
            print('buildSuggestion tap index $index');
            print(
                'buildSuggestion tap searchResult[index] ${searchResult[index]}');
            // Handle the selected search result.
            query = searchString;
            showResults(context);
            //close(context, searchResults[index]);
          },
        );
      },
    );
  }

  bool _containsLetters(String word, String letters) {
    for (int i = 0; i < letters.length; i++) {
      if (!word.contains(letters[i])) {
        return false;
      }
    }
    return true;
  }

  TextSpan _searchMatchText(String match, BuildContext context) {
    TextStyle positiveColorStyle = TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 15,
        fontWeight: FontWeight.bold);
    TextStyle negativeColorStyle = TextStyle(
      color: Theme.of(context).colorScheme.onBackground.withAlpha(100),
      fontSize: 15,
    );
    if (query == "") {
      return TextSpan(
        text: match,
        style: negativeColorStyle,
      );
    }
    var refinedMatch = match.toLowerCase();
    var refinedSearch = query.toLowerCase();
    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: positiveColorStyle,
          text: match.substring(0, refinedSearch.length),
          children: [
            _searchMatchText(
                match.substring(
                  refinedSearch.length,
                ),
                context),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(
          text: match,
          style: positiveColorStyle,
        );
      } else {
        return TextSpan(
          style: negativeColorStyle,
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            _searchMatchText(
                match.substring(
                  refinedMatch.indexOf(refinedSearch),
                ),
                context),
          ],
        );
      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      return TextSpan(
        text: match,
        style: negativeColorStyle,
      );
    }
    return TextSpan(
      text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
      style: negativeColorStyle,
      children: [
        _searchMatchText(
            match.substring(refinedMatch.indexOf(refinedSearch)), context)
      ],
    );
  }
}
