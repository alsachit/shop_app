import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_layout.dart';
import 'package:untitled/modules/register/cubit/cubit.dart';
import 'package:untitled/modules/register/cubit/state.dart';
import 'package:untitled/modules/shop_login/shop_login.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../../shared/components/ShowToast.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state){
          if (state is RegisterSuccessState){
            if (state.loginModel.status){
              debugPrint(state.loginModel.data!.token);
              debugPrint(state.loginModel.message);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, const HomeLayout());
              });
            }else {
              debugPrint(state.loginModel.message);
              ShowToast.showToast(
                  state: ToastState.error,
                  message: state.loginModel.message!
              );
            }
          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                            'Register new account',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 16,
                                color: Colors.grey.shade600
                            )
                        ),
                        const SizedBox(height: 40,),
                        defaultTextFormField(
                            controller: nameController,
                            validate: (value){
                              if (value!.isEmpty) {
                                return 'Your name is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            label: 'Full Name',
                            prefixIcon: Icons.person
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: emailController,
                            validate: (value){
                              if (value!.isEmpty) {
                                return 'Email address is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefixIcon: Icons.email
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: passwordController,
                            validate: (value){
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            label: 'Password',
                            prefixIcon: Icons.lock,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixIcon: RegisterCubit.get(context).suffix,
                            suffixPressed: (){
                              RegisterCubit.get(context).changePasswordVisibility();
                            }
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: phoneController,
                            validate: (value){
                              if (value!.isEmpty) {
                                return 'Phone number is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            label: 'Phone Number',
                            prefixIcon: Icons.phone_android
                        ),
                        const SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition: state is !RegisterLoadingState,
                          builder: (context) => defaultButton(
                            background: defaultColor,
                            function: (){
                              if (formKey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
                              }
                            },
                            label: 'register',
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator(),),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            TextButton(onPressed: (){
                              navigateTo(ShopLoginScreen(), context);
                            },
                              child: const Text(
                                'Login Now',
                                style: TextStyle(
                                  fontSize: 14,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
