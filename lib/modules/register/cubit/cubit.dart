import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/register/cubit/state.dart';
import '../../../model/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  LoginModel? loginModel;

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name' : name,
          'phone' : phone,
          'email' : email,
          'password' : password
        }
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error){
      debugPrint(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }
}