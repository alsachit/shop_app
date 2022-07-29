import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/cubit.dart';
import 'package:untitled/layout/cubit/states.dart';
import 'package:untitled/modules/category_products/category_products.dart';
import 'package:untitled/shared/components/components.dart';

import '../../model/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(cubit.categoryModel!.data.data[index], context),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cubit.categoryModel!.data.data.length
        );
      },
    );
  }

  Widget buildCatItem(CategoryDetailModel model, context) => GestureDetector(
    onTap: (){
      ShopCubit.get(context).getCategoryProducts(categoryId: model.id);
      navigateTo(context, CategoryProducts(name: model.name,));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20,),
          Text(
            model.name!.toUpperCase(),
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
