import 'package:bloc/bloc.dart';
import 'package:f_project/modules/social_app/login/cubit/states.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialStates());

  static SocialLoginCubit getHomeCubit(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility;
  bool isShow = true;

  void userLogin({required email,required password}){
    emit(SocialLoginLoadingState());
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password:password
      ).then((value){
        showToast(message: '${value.user!.email}', state: ToastStates.SUCCESS);
        emit(SocialLoginSuccessState(value.user!.uid));
      }).catchError((error) {
        emit(SocialLoginErrorState(onError.toString()));

      });
  }

  void changeShowPasswordIcon() {
    isShow = !isShow;
    suffix = isShow ? Icons.visibility:Icons.visibility_off;
    emit(changeShowPasswordIconState());

  }


}
