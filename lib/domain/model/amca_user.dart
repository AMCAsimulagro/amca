/// {@category Domain}
/// This file defines the [AmcaUser] class which represents a user in the AMCA system.
/// The [AmcaUser] class is annotated with @freezed and @unfreezed which are used
/// for code generation to handle immutable data classes with ease.
library;

/// Imports of Bookstores and Resources
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'amca_user.freezed.dart';

part 'amca_user.g.dart';

/// A class representing a user in the AMCA system.
@unfreezed
class AmcaUser with _$AmcaUser {
  /// Default constructor for [AmcaUser].
  factory AmcaUser({
    required String names,
    required String firstLastName,
    required String secondLastName,
    required final String identification,
    required String state,
    required String town,
    required String email,
    String? uid,
    @Default(false) bool? isAdmin,
  }) = _AmcaUser;

  /// Deserialize a JSON map into an [AmcaUser] instance
  factory AmcaUser.fromJson(Map<String, Object?> json) =>
      _$AmcaUserFromJson(json);

  /// Create an [AmcaUser] instance from a Firestore document snapshot.
  factory AmcaUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AmcaUser(
      names: data?['names'],
      firstLastName: data?['firstLastName'],
      secondLastName: data?['secondLastName'],
      identification: data?['identification'],
      state: data?['state'],
      town: data?['town'],
      email: data?['email'],
      uid: data?['uid'],
      isAdmin: data?['isAdmin'],
    );
  }
}
