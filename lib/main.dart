import 'package:bloc/bloc.dart';
import 'package:f_project/layout/news_app/cubit/cubit.dart';
import 'package:f_project/layout/news_app/cubit/states.dart';
import 'package:f_project/layout/shope_app/cubit/cubit.dart';
import 'package:f_project/layout/shope_app/cubit/states.dart';
import 'package:f_project/layout/social_app/cubit/states.dart';
import 'package:f_project/layout/social_app/home_layout.dart';
import 'package:f_project/modules/shope_app/login/Shop_login_screen.dart';
import 'package:f_project/modules/social_app/register/Shop_register_screen.dart';
import 'package:f_project/shared/bloc_observer.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:f_project/shared/components/constant.dart';
import 'package:f_project/shared/network/local/cache_helper.dart';
import 'package:f_project/shared/network/remote/dio_helper.dart';
import 'package:f_project/shared/styles/Themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/news_app/home_layout.dart';
import 'layout/shope_app/home_layout.dart';
import 'layout/social_app/cubit/cubit.dart';
import 'modules/shope_app/on_boarding/Shop_onboarding_screen.dart';
import 'modules/social_app/login/social_login_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print(message.data.toString());

  showToast(message: 'notify in background', state: ToastStates.SUCCESS);

}
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var tokenMesseage = await FirebaseMessaging.instance.getToken();

        print(tokenMesseage);

//Opened App Message
FirebaseMessaging.onMessage.listen((event) {
  print(event.data.toString());

    showToast(message: 'On messaging', state: ToastStates.SUCCESS);

});

//notify in background  but onPressed notify app Open
FirebaseMessaging.onMessageOpenedApp.listen((event) {
  print(event.data.toString());
});

//notify in background
// FirebaseMessaging.onBackgroundMessage((message) =>
//  _firebaseMessagingBackgroundHandler(message));



  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  //SharedPreferences
 await CachHelper.init();

 CachHelper.saveData(key: 'token', value: 'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV');

    //SharedPreferences
  var isDark = CachHelper.getData(key: 'isDark');
  var onBoarding = CachHelper.getData(key: 'OnBoarding');
   token = CachHelper.getData(key: 'token');

    uId = CachHelper.getData(key: 'uId');

  Widget widget;

  //   if(onBoarding != null){
  //     if(token != null) widget = ShopLayout();
  //     else  widget = ShopLoginScreen();
  //   }else{
  //     widget = ShopOnBoardingScreen();
  // }

  if(uId != null){
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }

  runApp(MyApp(isDark: isDark,startWidget: widget));


  // MyApp m = MyApp();
  // Widget w = MyApp();
}

class MyApp extends StatelessWidget {
   var  isDark;
   Widget  startWidget;
   MyApp({this.isDark, required this.startWidget});



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialAppCubit()..getUserData()..getPosts()..changeAppMode(fromSahred: isDark)),
      //  BlocProvider(create: (context) => ShopAppCubit()..getHomeData()..getCategoriesData()..getProfileData()..changeAppMode(fromSahred: isDark)),
      //  BlocProvider(create: (context) => NewAppCubit()..getBusiness()..changeAppMode(fromSahred: isDark)),
      //  BlocProvider(create: (context) => NewAppCubit()..getBusiness()..getSports()..getScience()),
   /*     BlocProvider(create: (context) => NewAppCubit()..getBusiness()),
        BlocProvider(create: (context) => NewAppCubit()..getSports()),
        BlocProvider(create: (context) => NewAppCubit()..getScience()),*/
      ],
      child: BlocConsumer<SocialAppCubit,SocialAppStates>(
        listener: (context, states) {},
        builder: (context, states) {

          // var isDark = NewAppCubit.getHomeCubit(context).isDark;
          //var isDark = ShopAppCubit.getHomeCubit(context).isDark;
          var isDark = SocialAppCubit.getHomeCubit(context).isDark;


          return MaterialApp(
            //disable banner
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:  isDark ? ThemeMode.dark :  ThemeMode.light,
            home: Directionality(
                textDirection: TextDirection.ltr,
                child:startWidget),
          );
        },
      ),
    );
  }
}
