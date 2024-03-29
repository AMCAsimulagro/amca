/// {@category Api}
/// This file contains the implementation of an interface `FrequentQuestionApi` and its adapter `FrequentQuestionApiAdapter`
///
/// which provide methods to interact with Firebase database in a Flutter application specifically for managing frequent questions.
/// These methods are designed to retrieve, manage, and delete frequent questions.

/// Imports of Bookstores and Resources
import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/frequent_question.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

/// Abstract interface defining methods to interact with the database specifically for managing frequent questions.
abstract class FrequentQuestionApi {
  Future<List<FrequentQuestion>> getFrequentQuestions();/// Retrieves a list of frequent questions from the database.

  Future<FrequentQuestion> manageFrequentQuestion(
      FrequentQuestion frequentQuestion);/// Manages a frequent question by adding or updating it in the database.

  Future<void> deleteFrequentQuestion(FrequentQuestion frequentQuestion);/// Deletes a frequent question from the database.
}

/// Implementation of the `FrequentQuestionApi` interface.
class FrequentQuestionApiAdapter extends FrequentQuestionApi {
  final _firebaseDb = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> deleteFrequentQuestion(FrequentQuestion frequentQuestion) async {
    try {
      await _firebaseDb
          .collection(FirebaseCollections.frequentQuestions)
          .doc(frequentQuestion.id!)
          .delete();
      return;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        message: e.message,
        codeError: e.code,
      );
    } catch (e) {
      throw AppException(
        codeError: Constants.generalError,
      );
    }
  }

  @override
  Future<List<FrequentQuestion>> getFrequentQuestions() async {
    try {
      final collection = await _firebaseDb
          .collection(FirebaseCollections.frequentQuestions)
          .get();
      final data = collection.docs
          .map((doc) => FrequentQuestion.fromJson(doc.data()))
          .toList();

      return data;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        message: e.message,
        codeError: e.code,
      );
    } catch (e) {
      throw AppException(
        codeError: Constants.generalError,
      );
    }
  }

  @override
  Future<FrequentQuestion> manageFrequentQuestion(
      FrequentQuestion frequentQuestion) async {
    try {
      final frequentQuestionId = frequentQuestion.id ?? const Uuid().v4();
      final frequentQuestionToUpload = frequentQuestion.copyWith(
        createdById: _firebaseAuth.currentUser?.uid ?? '',
        id: frequentQuestionId,
      );
      await _firebaseDb
          .collection(FirebaseCollections.frequentQuestions)
          .doc(frequentQuestionId)
          .set(frequentQuestionToUpload.toJson());
      return frequentQuestionToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        message: e.message,
        codeError: e.code,
      );
    } catch (e) {
      throw AppException(
        codeError: Constants.generalError,
      );
    }
  }
}
