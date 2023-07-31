import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_project/modules/social_app/new_post/new_post_screen.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:f_project/shared/components/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (BuildContext context, SocialAppStates state) {},
        builder: (BuildContext context, SocialAppStates state) {
          var cubit = SocialAppCubit.getHomeCubit(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
          IconButton(onPressed:(){

          }, icon: Icon(
              IconlyBroken.search
          )),
          IconButton(onPressed:(){
          }, icon: Icon(
              IconlyBroken.notification
          )),
          IconButton(onPressed:(){

            cubit.changeAppMode();

          }, icon: cubit.isDark ?Icon(Icons.brightness_4_outlined):Icon(Icons.brightness_4)
          ),
        ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigationTo(context, NewPost_Screen());
              },
              child: Icon(IconlyBroken.paper_upload),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 20,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: cubit.bottomItems,
            ),
             body: cubit.screens[cubit.currentIndex],
            // body: ConditionalBuilder(
            //   condition: cubit.model != null,
            //   builder: (context) {

            //     var model = cubit.model;
            //     return  Column(
            //     children: [
            //       if(!model!.isEmailVerified!)
            //     Container(
            //       color: Colors.amber.withOpacity(.6),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20),
            //         child: Row(
            //           children: [
            //             Icon(
            //               Icons.info_outline,
            //             ),
            //             SizedBox(
            //               width: 12,
            //             ),
            //             Expanded(
            //               child: Text('Plaese verify your email')
            //               ),
            //             SizedBox(
            //               width: 15,
            //             ),
            //             defaultTextButton(
            //               function: () {
            //                   FirebaseAuth.instance.currentUser?.sendEmailVerification()
            //                   .then((value){
            //                     model.isEmailVerified = true;
            //                     showToast(message: 'Check your mail', state: ToastStates.SUCCESS);
            //                   }).catchError((onError){
            //                     showToast(message: onError.toString(), state: ToastStates.ERROR);

            //                   });
            //               },
            //                text: 'Send')
            //           ],
            //         ),
            //       ),
            //     )
            //   ]);

            //   },
              
            // fallback: (context) => Center(child: CircularProgressIndicator()),
             
            // ),
          );
        });
  }
}
