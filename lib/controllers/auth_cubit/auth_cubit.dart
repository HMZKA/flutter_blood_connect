import 'package:bloc/bloc.dart';
import 'package:flutter_blood_connect/models/profile_model.dart';
import 'package:flutter_blood_connect/utils/app_cache.dart';
import 'package:flutter_blood_connect/utils/dio_helper.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthCubit get(context) => BlocProvider.of(context);
  ProfileModel? profileModel;
  login({required String phone, required String password}) {
    emit(LoginLoadingState());
    DioHelper.post(
        path: "auth/login",
        data: {"phone": phone, "password": password}).then((value) {
      profileModel = ProfileModel.fromJson(value?.data);
      AppCache.setString(key: "token", value: "${profileModel?.token}");
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginFailureState());
    });
  }

  register(
      {required String firstName,
      required String lastName,
      required String phone,
      required String identityNumber,
      required String password}) {
    emit(RegisterLoadingState());
    DioHelper.post(path: "auth/register", data: {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "identity_number": identityNumber,
      "password": password
    }).then((value) {
      profileModel = ProfileModel.fromJson(value?.data);
      AppCache.setString(key: "token", value: "${profileModel?.token}");
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterFailureState());
      print(error.toString());
    });
  }

  logout() {
    emit(LogoutLoadingState());
    DioHelper.get(path: "auth/logout").then(
      (value) {
        AppCache.clear();
        emit(LogoutSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(LogoutFailureState());
    });
  }
}
