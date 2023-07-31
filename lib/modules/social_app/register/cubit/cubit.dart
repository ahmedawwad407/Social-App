import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_project/models/social_app/social_create_user/socail_user_model.dart';
import 'package:f_project/modules/social_app/register/cubit/states.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:f_project/shared/components/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit getHomeCubit(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility;
  bool isShow = true;

  void userRegister(
      {required name, required email, required phone, required password}) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(SocialRegisterSuccessState());
      userCreate(name: name, email: email, phone: phone, id: value.user!.uid);
    }).catchError((error) {
      emit(SocialRegisterErrorState(onError.toString()));
    });
  }

  void userCreate(
      {required name,
       required email,
        required phone,
         required id,
        }) {
   
   SocialUserModel model = SocialUserModel(
    name: name,
    email: email,
    phone:phone,
    uId: id,
    bio: 'write you bio ...',
    image: 'https://img.freepik.com/free-photo/joyful-curly-young-woman-raises-arms-makes-fit-pump-smiles-joyfully-dressed-casual-wear-being-high-spirit-laughs-out-loudly-poses-against-pink-pastel-wall-feels-like-winner_273609-42703.jpg?t=st=1690191944~exp=1690192544~hmac=3d36dd2110eeb97246b9b74f479caf7796e9a72f5c3d05494fb46ac9252108bc',
    coverImage: 'https://img.freepik.com/free-photo/joyful-curly-young-woman-raises-arms-makes-fit-pump-smiles-joyfully-dressed-casual-wear-being-high-spirit-laughs-out-loudly-poses-against-pink-pastel-wall-feels-like-winner_273609-42703.jpg?t=st=1690191944~exp=1690192544~hmac=3d36dd2110eeb97246b9b74f479caf7796e9a72f5c3d05494fb46ac9252108bc',
    isEmailVerified: false
   );
    FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .set(model.toMap())
        .then((value) {
      showToast(message: 'Create_User_Success', state: ToastStates.SUCCESS);
      emit(SocialCreateUserSuccessState(id));
    }).catchError((error) {
      emit(SocialCreateUserErrorState(onError.toString()));
    });
  }

  void changeShowPasswordIcon() {
    isShow = !isShow;
    suffix = isShow ? Icons.visibility : Icons.visibility_off;
    emit(changeShowPasswordIconRegisterState());
  }
}
