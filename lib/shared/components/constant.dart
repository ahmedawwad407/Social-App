// List<Map> record= [];

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=49eb501f30aa4a279ece145de1a12542
//https://newsapi.org/v2/everything?q=tesla&apiKey=49eb501f30aa4a279ece145de1a12542
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=49eb501f30aa4a279ece145de1a12542

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_project/modules/shope_app/login/Shop_login_screen.dart';
import 'package:f_project/modules/social_app/login/social_login_screen.dart';
import 'package:f_project/shared/network/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'components.dart';

void signOut(context){
  CachHelper.removeData(key: 'token').then((value){
    if(value) {
      navigationAndFinish(context, ShopLoginScreen());
    }});
}

void signOutFirebase(context){
//   CachHelper.removeData(key: 'uId').then((value){
//     if(value) {
//  FirebaseAuth.instance.signOut();
//     showToast(message: 'signOutFirebaseSuccess', state: ToastStates.SUCCESS);
//     navigationAndFinish(context, SocialLoginScreen());
//     }});

FirebaseAuth.instance.signOut();
    showToast(message: 'signOutFirebaseSuccess', state: ToastStates.SUCCESS);
    navigationAndFinish(context, SocialLoginScreen());
}


var token = '';

var uId = '';

