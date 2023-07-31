import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_project/layout/social_app/cubit/cubit.dart';
import 'package:f_project/layout/social_app/cubit/states.dart';
import 'package:f_project/models/social_app/social_create_post/social_post_model.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:f_project/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class Feeds_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialAppCubit.getHomeCubit(context);
          return ConditionalBuilder(
            condition: cubit.posts.length > 0 && cubit.model !=  null,
            builder: (context) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    elevation: 15,
                    margin: EdgeInsets.all(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/photo-thoughtful-woman-with-curly-afro-hair-keeps-hand-chin-has-calm-pensive-expression-wears-casual-green-t-shirt-isolated-rosy-wall_273609-39739.jpg?w=900&t=st=1690085933~exp=1690086533~hmac=c79e8f3696fc3ddf7a9bd26eb25fcaaee5d29c1208376ac7ec79f9169002f3b1'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'Commuincate With Friends',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPostItem(cubit.posts[index], context,index),
                    separatorBuilder: (context, index) => SizedBox(height: 5),
                    itemCount: cubit.posts.length,
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildPostItem(SocialPostModel model, context,index) => Card(
      elevation: 15,
      margin: EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.profileImage}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(height: 1.4),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.postText}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 5),
                    height: 20,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        '#software',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 5),
                    height: 20,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        '#software',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 5),
                    height: 20,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        '#software',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 5),
                    height: 20,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        '#software',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 5),
                    height: 20,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        '#software',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
                spacing: 5,
              ),
            ),
            if(model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10),
              child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              IconlyBroken.heart,
                              size: 16,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${SocialAppCubit.getHomeCubit(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconlyBroken.chat,
                              size: 16,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${SocialAppCubit.getHomeCubit(context).comment[index]} comment',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          SocialAppCubit.getHomeCubit(context).commentPost(SocialAppCubit.getHomeCubit(context).postsId[index]);
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            '${SocialAppCubit.getHomeCubit(context).model!.image}'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('write a comment ...',
                          style: Theme.of(context).textTheme.caption!),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialAppCubit.getHomeCubit(context).likePost(SocialAppCubit.getHomeCubit(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconlyBroken.heart,
                        size: 16,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ));
}
