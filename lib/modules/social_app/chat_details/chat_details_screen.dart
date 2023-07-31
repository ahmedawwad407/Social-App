import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_project/layout/social_app/cubit/cubit.dart';
import 'package:f_project/layout/social_app/cubit/states.dart';
import 'package:f_project/models/social_app/social_create_chat/social_chat_model.dart';
import 'package:f_project/models/social_app/social_create_user/socail_user_model.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:f_project/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ChatDetails_Screen extends StatelessWidget {
  SocialUserModel userModel;
  var textChatController = TextEditingController();
  ChatDetails_Screen({
    required this.userModel, //reciiver_id
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      //build things before run consumer
      builder: (context) {
        SocialAppCubit.getHomeCubit(context)
            .getMessage(receiverId: userModel.uId!);

        return BlocConsumer<SocialAppCubit, SocialAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialAppCubit.getHomeCubit(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${userModel.name}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message = cubit.messages[index];
                              if (SocialAppCubit.getHomeCubit(context)
                                      .model!
                                      .uId ==
                                  message.senderId) {
                                //senderId
                                return buildEndMessage(message);
                              } else {
                                //reciiver_id
                                return buildStartMessage(message);
                              }
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: cubit.messages.length),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(color: Colors.blue),
                              autocorrect: true,
                              controller: textChatController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: 'Type your Message... ',
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: MaterialButton(
                              onPressed: () {
                                var date = DateTime.now();

                                cubit.sendMessage(
                                    receiverId: userModel.uId!,
                                    dateTime: date.toString(),
                                    text: textChatController.text);
                              },
                              minWidth: 0.5,
                              child: Icon(
                                IconlyBroken.send,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(color: Colors.blue),
                              autocorrect: true,
                              controller: textChatController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: 'Type your Message... ',
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: MaterialButton(
                              onPressed: () {
                                var date = DateTime.now();

                                cubit.sendMessage(
                                    receiverId: userModel.uId!,
                                    dateTime: date.toString(),
                                    text: textChatController.text);
                              },
                              minWidth: 0.5,
                              child: Icon(
                                IconlyBroken.send,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),

                      ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildStartMessage(SocialMessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
            color: Colors.green[300],
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(model.text!)),
    );

Widget buildEndMessage(SocialMessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
            color: defaultColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(model.text!)),
    );
