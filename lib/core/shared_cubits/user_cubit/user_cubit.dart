import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/flutter_secure/flutter_secure.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:library_app/core/shared_cubits/user_cubit/user_state.dart';
import '../../utils/model/userdm.dart';




class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final  _storage = getIt<SecureStorageManager>();
  UserModel? userModel;
  Future<void> loadUser()async{
    try {
      emit(UserLoading());
       userModel = await _storage.readData("user"); // Load user from secure storage
      if (userModel != null) {
        emit(UserLoaded());
      } else {
        emit(UserError("User not found"));
      }
    } catch (e) {
      emit(UserError("Failed to load user"));
    }
  }
  Future<void> updateUser(UserModel newUser) async {
    try {
      await _storage.saveData("user", newUser);
      userModel = newUser;
      emit(UserLoaded());
    } catch (e) {
      emit(UserError("Failed to update user"));
    }
  }
  Future<void> deleteUser() async {
    try {
      emit(UserLoading());
     await _storage.deleteData("user");
      userModel = null;
        emit(UserDeleted());
    } catch (e) {
      emit(UserError("Failed to load user"));
    }
  }
}
