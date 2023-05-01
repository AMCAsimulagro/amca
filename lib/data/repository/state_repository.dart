import 'dart:convert';

import 'package:amca/domain/model/state.dart';
import 'package:amca/ui/utils/assets.dart';
import 'package:flutter/services.dart';

abstract class StateRepository {
  Future<List<State>> getStates();
}

class StateRepositoryAdapter extends StateRepository {
  @override
  Future<List<State>> getStates() async {
    final statesJson = await rootBundle.loadString(Assets.statesJson);
    List<dynamic> jsonMap = jsonDecode(statesJson);
    final states = jsonMap.map((state) => State.fromJson(state)).toList();
    return states;
  }
}
