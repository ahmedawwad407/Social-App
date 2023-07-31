import 'package:f_project/layout/social_app/cubit/cubit.dart';
import 'package:f_project/layout/social_app/cubit/states.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:f_project/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class NewPost_Screen extends StatelessWidget {
  var postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.getHomeCubit(context);
        return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(
                    function: () {
                      var date = DateTime.now();
                      if (cubit.postImage == null) {
                        cubit.createPost(
                            dateTime: date.toString(),
                            postText: postController.text);
                      } else {
                        cubit.uploadNewPost(
                            dateTime: date.toString(),
                            postText: postController.text);
                      }
                    },
                    text: 'Post'),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  if (state is SocialCreatePostLoadingStates)
                    LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingStates)
                    SizedBox(
                      height: 10,
                    ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          '${cubit.model!.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        cubit.model!.name!,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(height: 1.4),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.blue),
                      autocorrect: true,
                      controller: postController,
                      keyboardType: TextInputType.text,
                      scrollController: ScrollController(),
                      maxLength: 250,
                      maxLines: 7,
                      scrollPhysics: BouncingScrollPhysics(),
                      decoration: InputDecoration(
                          hintText: 'whate is on your mind... ',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (cubit.postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: FileImage(cubit.postImage!),
                                  //   NetworkImage('${cubit.model!.coverImage}'),
                                  // image: coverImage == null
                                  //      ? NetworkImage('${cubit.model!.coverImage}')
                                  //     : FileImage(coverImage),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              cubit.removePostImage();
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              cubit.getPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconlyBroken.image,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('add photo'),
                              ],
                            )),
                      ),
                      Expanded(
                        child:
                            TextButton(onPressed: () {}, child: Text('# tags')),
                      ),
                    ],
                  ),
                ])));
      },
    );
  }
}
