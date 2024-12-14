import 'package:meta/meta.dart';
import '../utils/model/userdm.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {}

class UserDeleted extends UserState {}


class UserError extends UserState {
  final String message;
  UserError(this.message);
}
