part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class PickedImageState extends AppState {}

class DonateLoadingState extends AppState {}

class DonateSuccessState extends AppState {}

class DonateErrorState extends AppState {}

class OrderLoadingState extends AppState {}

class OrderSuccessState extends AppState {}

class OrderErrorState extends AppState {}

class GetDoctorsLoadingState extends AppState {}

class GetDoctorsSuccessState extends AppState {}

class GetDoctorsErrorState extends AppState {}

class GetProfileLoadingState extends AppState {}

class GetProfileSuccessState extends AppState {}

class GetProfileErrorState extends AppState {}
