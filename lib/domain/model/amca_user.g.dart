// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amca_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AmcaUser _$$_AmcaUserFromJson(Map<String, dynamic> json) => _$_AmcaUser(
      names: json['names'] as String,
      firstLastName: json['firstLastName'] as String,
      secondLastName: json['secondLastName'] as String,
      identification: json['identification'] as String,
      state: json['state'] as String,
      town: json['town'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String?,
      isAdmin: json['isAdmin'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AmcaUserToJson(_$_AmcaUser instance) =>
    <String, dynamic>{
      'names': instance.names,
      'firstLastName': instance.firstLastName,
      'secondLastName': instance.secondLastName,
      'identification': instance.identification,
      'state': instance.state,
      'town': instance.town,
      'email': instance.email,
      'uid': instance.uid,
      'isAdmin': instance.isAdmin,
    };
