import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'amca_user.freezed.dart';

part 'amca_user.g.dart';

@unfreezed
class AmcaUser with _$AmcaUser {
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

  factory AmcaUser.fromJson(Map<String, Object?> json) =>
      _$AmcaUserFromJson(json);

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
