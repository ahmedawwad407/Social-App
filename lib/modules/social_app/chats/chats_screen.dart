import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_project/layout/social_app/cubit/cubit.dart';
import 'package:f_project/layout/social_app/cubit/states.dart';
import 'package:f_project/models/social_app/social_create_user/socail_user_model.dart';
import 'package:f_project/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserChat_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var cubit = SocialAppCubit.getHomeCubit(context);
        
        return ConditionalBuilder(
          condition: cubit.users.length > 0,
          builder: (context) =>  ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=> builtCahtItem(cubit.users[index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.users.length,
            ),
            fallback:(context) => Center(child: CircularProgressIndicator()),
          
        );
      },
    );
  }


  Widget builtCahtItem(model,context) => InkWell(
    onTap: (){
        print(model.name);
        print(model.uId);

         navigationTo(context, ChatDetails_Screen(userModel: model,));
    },
    child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '${model.name}',
                  style:
                      Theme.of(context).textTheme.headline6!.copyWith(height: 1.4),
                ),
              ],
            ),
          ),
  );
}
