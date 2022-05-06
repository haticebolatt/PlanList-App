import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:planlistapp/task.dart';

class DataTask with ChangeNotifier {
  final List<Task> _tasks = [];

  late SharedPreferences sharedPrefs;

  List<String> itemAsString = [];

  void ToggleStatus(int index) {
    _tasks[index].Toggle();
    saveItemsToShared(_tasks);
    notifyListeners();
  }

  //yenigörevekle
  void adderTask(String title) {
    _tasks.add(Task(title: title));
    saveItemsToShared(_tasks);
    notifyListeners();
  }

  //görevsil
  void DeleteTask(int index) {
    _tasks.removeAt(index);
    saveItemsToShared(_tasks);
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  Future<void> createPrefObject() async {
    final SharedPreferences sharedPrefs;
    sharedPrefs = await SharedPreferences.getInstance();
  }

  void saveItemsToShared(List<Task> tasks) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    itemAsString.clear();

    for (var item in tasks) {
      itemAsString.add(json.encode(item.toMap()));
    }

    sharedPrefs.setStringList('Data', itemAsString);
  }

//--------------------------------------------------------------

  void loadItemsFromSharedPref() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    List<String> geciciListe = sharedPrefs.getStringList('Data') ?? [];
    _tasks.clear();
    for (var item in geciciListe) {
      _tasks.add(Task.fromMap(json.decode(item)));
    }
  }
}
