import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/cubit.dart';
import 'package:untitled/modules/search/search_screen.dart';
import 'package:untitled/modules/shop_login/shop_login.dart';
import 'package:untitled/shared/components/components.dart';

import '../shared/network/local/cache_helper.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Sallah',
            ),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            onTap: (index) {
              cubit.changeBottomNavBarState(index);
            },
          ),
        );
      },
    );
  }
}
