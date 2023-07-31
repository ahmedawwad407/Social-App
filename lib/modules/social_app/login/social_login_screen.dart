import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_project/layout/social_app/home_layout.dart';
import 'package:f_project/modules/social_app/login/cubit/cubit.dart';
import 'package:f_project/modules/social_app/login/cubit/states.dart';
import 'package:f_project/modules/social_app/register/Shop_register_screen.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:f_project/shared/components/constant.dart';
import 'package:f_project/shared/network/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginSuccessState){
            
             CachHelper.saveData(key: 'uId', value:state.uId).then((value){
                navigationAndFinish(context, SocialLayout());
             });
          }
        },
        builder: (context, state) {

          var cubit = SocialLoginCubit.getHomeCubit(context);
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
                        Text('LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.black)),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultTextFormField(
                          style: TextStyle(
                          color: Colors.blue
                        ),
                            prefixIcon: Icons.email,
                            label: 'email',
                            type: TextInputType.emailAddress,
                            controller: emailController),
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
                        state is! SocialLoginLoadingState
                            ? defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'login')
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(color: Colors.grey),
                              ),
                              defaultTextButton(
                                  function: () {
                                    navigationTo(context, SocialRegisterScreen());
                                  },
                                  text: "RegisterNow")
                            ],
                          ),
                        )
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
