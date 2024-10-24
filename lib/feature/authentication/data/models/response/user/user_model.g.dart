// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      address: json['address'] as String?,
      token: json['token'] as String?,
      phone: json['phone'] as String?,
      imgUrl: json['imgUrl'] as String?,
      company: json['company'] as String?,
      isActive: json['isActive'] as bool?,
      status: json['status'] as String?,
      isVerified: json['isVerified'] as bool?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'address': instance.address,
      'token': instance.token,
      'phone': instance.phone,
      'imgUrl': instance.imgUrl,
      'company': instance.company,
      'isActive': instance.isActive,
      'status': instance.status,
      'isVerified': instance.isVerified,
      'createdAt': instance.createdAt,
    };
