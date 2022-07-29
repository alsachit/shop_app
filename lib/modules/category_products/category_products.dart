import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/cubit.dart';
import 'package:untitled/layout/cubit/states.dart';
import 'package:untitled/model/home_model.dart';
import 'package:untitled/shared/components/ShowToast.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../../model/category_model.dart';
import '../../model/category_products_model.dart';

class CategoryProducts extends StatelessWidget {
  final String? name;
   const CategoryProducts({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          name!.toUpperCase()
        ),
      ),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){
          if (state is ShopSuccessChangeFavoritesDataState){
            if (!state.favoritesModel!.status){
              ShowToast.showToast(state: ToastState.error, message: state.favoritesModel!.message!);
            }
          }
        },
        builder: (context, state){
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.categoryProductsModel != null && cubit.categoryModel != null  ,
            builder: (context) => homeBuilder(cubit.homeModel, cubit.categoryModel , context),
            fallback: (context) => const Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }

  Widget homeBuilder(HomeModel? model, CategoryModel? categoryModel , context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                 SizedBox(height: 20,),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey.shade200,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10 ,
              childAspectRatio: 1 / 1.75,
              crossAxisCount: 2,
              children: List.generate(model!.data.products.length, (index)
              => buildGridProduct(model.data.products[index], context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model, context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage('${model.image}'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              if(model.discount != 0)
                Container(
                  padding: const EdgeInsets.all(3),
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 5,),
          Text(
            '${model.name}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Text(
                '${model.price}',
                style: TextStyle(
                    color: defaultColor
                ),
              ),
              const SizedBox(width: 5,),
              if (model.discount != 0)
                Text(
                  '${model.oldPrice}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough
                  ),
                ),
              const Spacer(),
              IconButton(
                onPressed: (){
                  ShopCubit.get(context).changeFavorites(model.id);
                  debugPrint('${model.id}');
                },
                icon: CircleAvatar(
                  backgroundColor: (ShopCubit.get(context).favorites[model.id])! ? defaultColor : Colors.grey ,
                  radius: 15,
                  child: const Icon(
                    Icons.favorite_border,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}
