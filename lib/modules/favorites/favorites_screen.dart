import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/cubit.dart';
import 'package:untitled/model/favorites_model.dart';
import 'package:untitled/shared/components/components.dart';

import '../../layout/cubit/states.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
          condition: state is !ShopLoadingGetFavoritesDataState ,
          builder: (context) {
            if (ShopCubit.get(context).favoritesModel.data!.data!.isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.do_not_disturb_alt, color: Colors.grey, size: 35,),
                    SizedBox(height: 15,),
                    Text(
                      'No Favorite Item Add Some',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildListProduct(ShopCubit.get(context).favoritesModel.data!.data![index], context);
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: ShopCubit.get(context).favoritesModel.data!.data!.length,
            );
          } ,
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
