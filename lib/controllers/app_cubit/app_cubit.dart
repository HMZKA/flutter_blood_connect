import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blood_connect/models/doctor_model.dart';
import 'package:flutter_blood_connect/models/profile_model.dart';
import 'package:flutter_blood_connect/utils/dio_helper.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  AppCubit get(context) => BlocProvider.of(context);

  String? imagePicked;
  String? imageBytes;
  pickImage() async {
    await ImagePickerWeb.getImageInfo.then((value) {
      imagePicked = value?.fileName;
      imageBytes = value?.base64;
      emit(PickedImageState());
    });
  }

  donate(
      {required String age,
      required String weight,
      required String lastTime,
      required String bloodType}) {
    emit(DonateLoadingState());
    DioHelper.post(path: "donate", data: {
      "age": age,
      "weight": weight,
      "last_time": lastTime,
      "blood_type": bloodType
    }).then((value) {
      print(value?.data);
      emit(DonateSuccessState());
    }).catchError((error) {
      emit(DonateErrorState());
      print(error.toString());
    });
  }

  order({required String bloodType, required String image}) async {
    emit(OrderLoadingState());

    DioHelper.post(
        path: "order",
        data: FormData.fromMap({
          "blood_type": bloodType,
          "image": MultipartFile.fromString(image)
        })).then((value) {
      print(value?.data);

      emit(OrderSuccessState());
    }).catchError((error) {
      print(error.toString());
      print(error.response.data);
      emit(OrderErrorState());
    });
  }

  DoctorModel? doctorModel;
  getDoctors() {
    emit(GetDoctorsLoadingState());
    DioHelper.get(path: "doctors").then((value) {
      print(value?.data);
      doctorModel = DoctorModel.fromJson(value?.data);
      emit(GetDoctorsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDoctorsErrorState());
    });
  }

  User? user;
  getProfile() {
    emit(GetProfileLoadingState());
    DioHelper.get(path: "profile").then((value) {
      user = User.fromJson(value?.data);
      emit(GetDoctorsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileErrorState());
    });
  }
}
