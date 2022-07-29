import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/model/search_model.dart';
import 'package:untitled/modules/search/cubit/states.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../shared/components/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,
        data: {
      'text' : text,
        },
      token: token
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState(error));
      debugPrint(error.toString());
    });
  }
}