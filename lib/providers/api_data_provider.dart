import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/data_defination.dart';

class ApiDataProvider with ChangeNotifier {
  // This class will provide or handle all the heavy lifting of the
  // application. For example api connections will be defined in this
  // class and also the data which will be extracted from the api will
  // be distributed in the application from this class.

  // An empty list of DataDefination to store the value
  // extracted from the api.
  List<DataDefination> _items = [];

  // A getter of the list of DataDefination that returns a copy
  // of the original list.
  List<DataDefination> get items {
    // This getter returns a copy the the original list.
    return [..._items];
  }

  Future<void> fetchData() async {
    String apiUrl =
        'http://website-bucket-12234.s3-website-us-east-1.amazonaws.com/api.json';
    try {
      final response = await http.get(apiUrl);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<DataDefination> _dummyList = [];
      final apiData = extractedData['data'] as Map<String, dynamic>;
      // apiData['title'];
      // apiData['coverUrl'];
      final apiDataComponents = apiData['components'] as List;
      for (var i = 0; i < apiDataComponents.length; i += 2) {
        if (i == 4) {
          _dummyList.add(DataDefination(
            headerImage: apiData['coverUrl'],
            headerTitle: apiData['title'],
            imageUrl: apiDataComponents[i]['url'],
            textTitle: 'Null',
            textDescription: 'Null',
          ));
        } else {
          _dummyList.add(DataDefination(
            headerImage: apiData['coverUrl'],
            headerTitle: apiData['title'],
            imageUrl: apiDataComponents[i]['url'],
            textTitle: apiDataComponents[i + 1]['title'],
            textDescription: apiDataComponents[i + 1]['desc'],
          ));
        }
      }
      _items = _dummyList;
    } catch (error) {
      Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
