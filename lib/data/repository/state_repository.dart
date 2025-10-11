/// {@category Repository}
/// This file contains the implementation of an interface `StateRepository` and its adapter `StateRepositoryAdapter`
/// 
/// which provide methods to retrieve a list of states from a JSON file in a Flutter application.
library;

/// Imports of Bookstores and Resources
import 'dart:convert';

import 'package:amca/domain/model/state.dart';
import 'package:amca/ui/utils/assets.dart';
import 'package:flutter/services.dart';

/// Abstract class defining a method to retrieve a list of states.
abstract class StateRepository {
  Future<List<State>> getStates();/// Retrieves a list of states.
}

/// Implementation of the `StateRepository` interface.
class StateRepositoryAdapter extends StateRepository {
  @override
  Future<List<State>> getStates() async {
    final statesJson = await rootBundle.loadString(Assets.statesJson);
    List<dynamic> jsonMap = jsonDecode(statesJson);
    final states = jsonMap.map((state) => State.fromJson(state)).toList();
    return states;
  }
}
