import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_state.dart';
class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitial());
  bool isObscure = true;
  bool isConfirmObscure = true;
  void changePassVis(){
    isObscure = !isObscure;
    emit(ChangeVisibility());
  }
  void changeConfirmPassVis(){
    isConfirmObscure = !isConfirmObscure;
    emit(ChangeVisibility());
  }
}
