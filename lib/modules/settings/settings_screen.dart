import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/cubit.dart';
import 'package:untitled/layout/cubit/states.dart';
import 'package:untitled/model/login_model.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        var model = ShopCubit.get(context).loginModel;
        nameController.text = (model!.data!.name)!;
        emailController.text = (model.data!.email)!;
        phoneController.text = (model.data!.phone)!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel!.data != null,
          builder: (context){
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserDataState)
                     const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextFormField(
                      controller: nameController,
                      validate: (String? value){
                        if (value!.isEmpty){
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      label: 'Name',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextFormField(
                      controller: emailController,
                      validate: (String? value){
                        if (value!.isEmpty){
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      label: 'Email Address',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextFormField(
                      controller: phoneController,
                      validate: (String? value){
                        if (value!.isEmpty){
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      label: 'Phone Number',
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                      label: 'Logout',
                      background: defaultColor,
                      isUpper: false,
                      function: (){
                        signOut(context);
                      }
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        label: 'Update',
                        background: defaultColor,
                        isUpper: false,
                        function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        }
                    )
                  ],
                ),
              ),
            );
          },
          fallback: (context){
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
