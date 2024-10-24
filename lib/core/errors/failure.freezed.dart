// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) server,
    required TResult Function(String message) client,
    required TResult Function(String message) timeout,
    required TResult Function(String message) generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? server,
    TResult? Function(String message)? client,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? server,
    TResult Function(String message)? client,
    TResult Function(String message)? timeout,
    TResult Function(String message)? generic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) server,
    required TResult Function(ClientError value) client,
    required TResult Function(TimeOutError value) timeout,
    required TResult Function(GenericError value) generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? server,
    TResult? Function(ClientError value)? client,
    TResult? Function(TimeOutError value)? timeout,
    TResult? Function(GenericError value)? generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? server,
    TResult Function(ClientError value)? client,
    TResult Function(TimeOutError value)? timeout,
    TResult Function(GenericError value)? generic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
          _$ServerErrorImpl value, $Res Function(_$ServerErrorImpl) then) =
      __$$ServerErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
      _$ServerErrorImpl _value, $Res Function(_$ServerErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ServerErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ServerErrorImpl extends ServerError {
  const _$ServerErrorImpl({this.message = 'Something went wrong.'}) : super._();

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.server(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      __$$ServerErrorImplCopyWithImpl<_$ServerErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) server,
    required TResult Function(String message) client,
    required TResult Function(String message) timeout,
    required TResult Function(String message) generic,
  }) {
    return server(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? server,
    TResult? Function(String message)? client,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? generic,
  }) {
    return server?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? server,
    TResult Function(String message)? client,
    TResult Function(String message)? timeout,
    TResult Function(String message)? generic,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) server,
    required TResult Function(ClientError value) client,
    required TResult Function(TimeOutError value) timeout,
    required TResult Function(GenericError value) generic,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? server,
    TResult? Function(ClientError value)? client,
    TResult? Function(TimeOutError value)? timeout,
    TResult? Function(GenericError value)? generic,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? server,
    TResult Function(ClientError value)? client,
    TResult Function(TimeOutError value)? timeout,
    TResult Function(GenericError value)? generic,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerError extends Failure {
  const factory ServerError({final String message}) = _$ServerErrorImpl;
  const ServerError._() : super._();

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClientErrorImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ClientErrorImplCopyWith(
          _$ClientErrorImpl value, $Res Function(_$ClientErrorImpl) then) =
      __$$ClientErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ClientErrorImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ClientErrorImpl>
    implements _$$ClientErrorImplCopyWith<$Res> {
  __$$ClientErrorImplCopyWithImpl(
      _$ClientErrorImpl _value, $Res Function(_$ClientErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ClientErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ClientErrorImpl extends ClientError {
  const _$ClientErrorImpl({this.message = 'Something went wrong.'}) : super._();

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.client(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientErrorImplCopyWith<_$ClientErrorImpl> get copyWith =>
      __$$ClientErrorImplCopyWithImpl<_$ClientErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) server,
    required TResult Function(String message) client,
    required TResult Function(String message) timeout,
    required TResult Function(String message) generic,
  }) {
    return client(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? server,
    TResult? Function(String message)? client,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? generic,
  }) {
    return client?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? server,
    TResult Function(String message)? client,
    TResult Function(String message)? timeout,
    TResult Function(String message)? generic,
    required TResult orElse(),
  }) {
    if (client != null) {
      return client(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) server,
    required TResult Function(ClientError value) client,
    required TResult Function(TimeOutError value) timeout,
    required TResult Function(GenericError value) generic,
  }) {
    return client(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? server,
    TResult? Function(ClientError value)? client,
    TResult? Function(TimeOutError value)? timeout,
    TResult? Function(GenericError value)? generic,
  }) {
    return client?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? server,
    TResult Function(ClientError value)? client,
    TResult Function(TimeOutError value)? timeout,
    TResult Function(GenericError value)? generic,
    required TResult orElse(),
  }) {
    if (client != null) {
      return client(this);
    }
    return orElse();
  }
}

abstract class ClientError extends Failure {
  const factory ClientError({final String message}) = _$ClientErrorImpl;
  const ClientError._() : super._();

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ClientErrorImplCopyWith<_$ClientErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeOutErrorImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$TimeOutErrorImplCopyWith(
          _$TimeOutErrorImpl value, $Res Function(_$TimeOutErrorImpl) then) =
      __$$TimeOutErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TimeOutErrorImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$TimeOutErrorImpl>
    implements _$$TimeOutErrorImplCopyWith<$Res> {
  __$$TimeOutErrorImplCopyWithImpl(
      _$TimeOutErrorImpl _value, $Res Function(_$TimeOutErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TimeOutErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TimeOutErrorImpl extends TimeOutError {
  const _$TimeOutErrorImpl({this.message = 'The request timed out.'})
      : super._();

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.timeout(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeOutErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeOutErrorImplCopyWith<_$TimeOutErrorImpl> get copyWith =>
      __$$TimeOutErrorImplCopyWithImpl<_$TimeOutErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) server,
    required TResult Function(String message) client,
    required TResult Function(String message) timeout,
    required TResult Function(String message) generic,
  }) {
    return timeout(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? server,
    TResult? Function(String message)? client,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? generic,
  }) {
    return timeout?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? server,
    TResult Function(String message)? client,
    TResult Function(String message)? timeout,
    TResult Function(String message)? generic,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) server,
    required TResult Function(ClientError value) client,
    required TResult Function(TimeOutError value) timeout,
    required TResult Function(GenericError value) generic,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? server,
    TResult? Function(ClientError value)? client,
    TResult? Function(TimeOutError value)? timeout,
    TResult? Function(GenericError value)? generic,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? server,
    TResult Function(ClientError value)? client,
    TResult Function(TimeOutError value)? timeout,
    TResult Function(GenericError value)? generic,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class TimeOutError extends Failure {
  const factory TimeOutError({final String message}) = _$TimeOutErrorImpl;
  const TimeOutError._() : super._();

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$TimeOutErrorImplCopyWith<_$TimeOutErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GenericErrorImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$GenericErrorImplCopyWith(
          _$GenericErrorImpl value, $Res Function(_$GenericErrorImpl) then) =
      __$$GenericErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GenericErrorImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$GenericErrorImpl>
    implements _$$GenericErrorImplCopyWith<$Res> {
  __$$GenericErrorImplCopyWithImpl(
      _$GenericErrorImpl _value, $Res Function(_$GenericErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$GenericErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GenericErrorImpl extends GenericError {
  const _$GenericErrorImpl({this.message = 'Something went wrong.'})
      : super._();

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.generic(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericErrorImplCopyWith<_$GenericErrorImpl> get copyWith =>
      __$$GenericErrorImplCopyWithImpl<_$GenericErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) server,
    required TResult Function(String message) client,
    required TResult Function(String message) timeout,
    required TResult Function(String message) generic,
  }) {
    return generic(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? server,
    TResult? Function(String message)? client,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? generic,
  }) {
    return generic?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? server,
    TResult Function(String message)? client,
    TResult Function(String message)? timeout,
    TResult Function(String message)? generic,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) server,
    required TResult Function(ClientError value) client,
    required TResult Function(TimeOutError value) timeout,
    required TResult Function(GenericError value) generic,
  }) {
    return generic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? server,
    TResult? Function(ClientError value)? client,
    TResult? Function(TimeOutError value)? timeout,
    TResult? Function(GenericError value)? generic,
  }) {
    return generic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? server,
    TResult Function(ClientError value)? client,
    TResult Function(TimeOutError value)? timeout,
    TResult Function(GenericError value)? generic,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(this);
    }
    return orElse();
  }
}

abstract class GenericError extends Failure {
  const factory GenericError({final String message}) = _$GenericErrorImpl;
  const GenericError._() : super._();

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$GenericErrorImplCopyWith<_$GenericErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
