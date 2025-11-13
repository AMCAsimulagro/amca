/// {@category Menu fishes admin}
library;

import 'package:amca/data/repository/fish_types_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/fish_type.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'dart:async';

class FishesAdminVM extends ChangeNotifier {
	final FishTypesRepository fishTypesRepository = locator<FishTypesRepository>();
	List<FishType> fishes = [];
	bool isLoading = true;

	Future<void> init() async {
		isLoading = true;
		try {
				fishes = await fishTypesRepository.getFishTypes().timeout(const Duration(seconds: 15));
			fishes.sort((a, b) => a.name.compareTo(b.name));
		} finally {
			isLoading = false;
			notifyListeners();
		}
	}

	void addLocal(String value) {
		fishes.add(FishType(id: null, name: value));
		notifyListeners();
	}

	void replaceValue(String id, String newValue) {
		final index = fishes.indexWhere((e) => e.id == id);
		if (index != -1) {
			fishes[index] = fishes[index].copyWith(name: newValue);
			notifyListeners();
		}
	}

	Future<void> createFishType(FishType fishType) async {
			isLoading = true;
			notifyListeners();
			try {
				await fishTypesRepository.createFishType(fishType).timeout(const Duration(seconds: 15));
				// refresh list after creating/upserting
				await init();
			} on TimeoutException catch (e) {
				log('createFishType timeout: $e');
				rethrow;
			} catch (e) {
				log('createFishType error: $e');
				rethrow;
			} finally {
				isLoading = false;
				notifyListeners();
			}
	}

	Future<void> deleteFishType(FishType fishType) async {
			isLoading = true;
			notifyListeners();
			try {
				await fishTypesRepository.deleteFishType(fishType).timeout(const Duration(seconds: 15));
				await init();
			} on TimeoutException catch (e) {
				log('deleteFishType timeout: $e');
				rethrow;
			} catch (e) {
				log('deleteFishType error: $e');
				rethrow;
			} finally {
				isLoading = false;
				notifyListeners();
			}
	}

	bool validateFish(String value) {
		for (var f in fishes) {
			if (f.name.toLowerCase().trim() == value.toLowerCase().trim()) {
				return true;
			}
		}
		return false;
	}
}

