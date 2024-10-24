// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      token: json['token'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      company: json['company'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'address': instance.address,
      'token': instance.token,
      'phone': instance.phone,
      'image': instance.image,
      'company': instance.company,
      'createdAt': instance.createdAt,
    };
