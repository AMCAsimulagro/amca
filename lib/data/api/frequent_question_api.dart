import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/frequent_question.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

abstract class FrequentQuestionApi {
  Future<List<FrequentQuestion>> getFrequentQuestions();

  Future<FrequentQuestion> manageFrequentQuestion(
      FrequentQuestion frequentQuestion);

  Future<void> deleteFrequentQuestion(FrequentQuestion frequentQuestion);
}

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
