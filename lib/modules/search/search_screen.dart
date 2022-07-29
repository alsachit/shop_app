import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/search/cubit/cubit.dart';
import 'package:untitled/modules/search/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  var fromKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: fromKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    defaultTextFormField(
                        controller: searchController,
                        validate: (String? value){
                          if (value!.isEmpty){
                            return 'Enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String? value) {
                          if (fromKey.currentState!.validate()){
                            SearchCubit.get(context).search(value!);
                            debugPrint(value.toString());
                          }
                        },
                        keyboardType: TextInputType.text,
                        label: 'Search',
                        prefixIcon: Icons.search
                    ),
                    const SizedBox(height: 10,),
                    if (state is SearchLoadingState)
                     const LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index], context,isOldPrice: false),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: SearchCubit.get(context).model!.data!.data!.length
                        )
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
