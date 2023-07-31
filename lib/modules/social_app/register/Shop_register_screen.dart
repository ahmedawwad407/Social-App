import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_project/layout/social_app/home_layout.dart';
import 'package:f_project/modules/social_app/register/cubit/states.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:f_project/shared/components/constant.dart';
import 'package:f_project/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class SocialRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
          listener: (context, state) {
        if (state is SocialCreateUserSuccessState) {
CachHelper.saveData(key: 'uId', value:state.uId).then((value){
                navigationAndFinish(context, SocialLayout());
             });        }
      }, builder: (context, state) {
        var cubit = SocialRegisterCubit.getHomeCubit(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Social App'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,// not apply -> solution center widget
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register',
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(
                        height: 40.0,
                      ),
                      defaultTextFormField(
                        style: TextStyle(
                          color: Colors.blue
                        ),
                          prefixIcon: Icons.person,
                          label: 'User Name',
                          type: TextInputType.text,
                          controller: nameController),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultTextFormField(
                            style: TextStyle(
                          color: Colors.blue
                        ),
                          prefixIcon: Icons.email,
                          label: 'Email',
                          type: TextInputType.emailAddress,
                          controller: emailController),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultTextFormField(
                            style: TextStyle(
                          color: Colors.blue
                        ),
                          prefixIcon: Icons.phone,
                          label: 'Phone',
                          type: TextInputType.phone,
                          controller: phoneController),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultTextFormField(
                          style: TextStyle(
                          color: Colors.blue
                        ),
                        prefixIcon: Icons.lock,
                        suffixIcon: cubit.suffix,
                        label: 'password',
                        type: TextInputType.visiblePassword,
                        isObscure: cubit.isShow,
                        suffixPressed: () {
                          cubit.changeShowPasswordIcon();
                        },
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'REGISTER'),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
