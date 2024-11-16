import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class domainLocationprovider extends ChangeNotifier {
  String? _selectedTrade;
  String? _selectedLocation;

  String? get selectedTrade => _selectedTrade;
  String? get selectedLocation => _selectedLocation;

  void selectTrade(String? trade) {
    _selectedTrade = trade;
    print(_selectedTrade);
    notifyListeners();
  }

  void selectLocation(String? location) {
    _selectedLocation = location;
    print(_selectedLocation);
    notifyListeners();
  }

  Stream<List<String>> get domainStream {
    return FirebaseFirestore.instance.collection('DOMAIN').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => doc['DOMAIN'] as String).toList());
  }

  Stream<List<String>> get locationStream {
    return FirebaseFirestore.instance.collection('LOCATION').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => doc['LOCATION'] as String).toList());
  }
}
