import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/model/login_model.dart';
import 'package:untitled/modules/shop_login/cubit/states.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() :super(LoginInitialState());

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  LoginModel? loginModel;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password})
  {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {'email' : email, 'password' : password}
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }
}

