import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/shop_layout.dart';
import 'package:untitled/modules/register/register.dart';
import 'package:untitled/modules/shop_login/cubit/cubit.dart';
import 'package:untitled/modules/shop_login/cubit/states.dart';
import 'package:untitled/shared/components/ShowToast.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/components/default_text_form_field.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state){
          if (state is LoginSuccessState){
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                            'Login now to see our hot offers',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 16,
                                color: Colors.grey.shade600
                            )
                        ),
                        const SizedBox(height: 40,),
                        DefaultTextFormField(
                            controller: emailController,
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                            label: const Text('Email Address'),
                            prefixIcon: Icons.email
                        ),
                        const SizedBox(height: 15,),
                        DefaultTextFormField(
                            controller: passwordController,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixIcon: LoginCubit.get(context).suffix,
                            suffixPressed: (){
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                          onSubmit: (value){
                            if (formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          type: TextInputType.text,
                          label: const Text('Password'),
                            prefixIcon: Icons.lock,
                        ),
                        const SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState ,
                          builder: (context) {
                            return defaultButton(
                              background: defaultColor,
                              function: (){
                                if (formKey.currentState!.validate()){
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              label: 'login',
                            );
                          },
                          fallback:(context) => const Center(child: CircularProgressIndicator()) ,
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, RegisterScreen() );
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                  fontSize: 12,

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
      )
    );
  }
}
