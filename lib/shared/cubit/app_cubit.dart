import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

}