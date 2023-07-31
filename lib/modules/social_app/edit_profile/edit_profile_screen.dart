import 'package:f_project/layout/social_app/cubit/cubit.dart';
import 'package:f_project/layout/social_app/cubit/states.dart';
import 'package:f_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class EditProfile_Screen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.getHomeCubit(context);
        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;

        nameController.text = cubit.model!.name!;
        bioController.text = cubit.model!.bio!;
        phoneController.text = cubit.model!.phone!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      cubit.updateUser(
                          name: nameController.text,
                          bio: bioController.text,
                          phone: phoneController.text);
                    }
                  },
                  text: 'Update'),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (state is SocialUpdateUserLoadingStates)
                      LinearProgressIndicator(),
                    if (state is SocialUpdateUserLoadingStates)
                      SizedBox(
                        height: 10,
                      ),
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      image: DecorationImage(
                                        image:
                                            // FileImage(coverImage!),
                                            NetworkImage(
                                                '${cubit.model!.coverImage}'),
                                        // image: coverImage == null
                                        //      ? NetworkImage('${cubit.model!.coverImage}')
                                        //     : FileImage(coverImage),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    cubit.getCoverImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Icon(
                                        IconlyBroken.camera,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: //FileImage(profileImage!),
                                      NetworkImage('${cubit.model!.image}'),
                                  // backgroundImage: profileImage == null
                                  //      ? NetworkImage('${cubit.model!.image}')
                                  //     : FileImage(profileImage),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.getProfileImage();
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: Icon(
                                      IconlyBroken.camera,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (cubit.profileImage != null || cubit.coverImage != null)
                      Row(
                        children: [
                          if (cubit.profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      function: () {
                                        cubit.uploadProfileImage(
                                            name: nameController.text,
                                            bio: bioController.text,
                                            phone: phoneController.text);
                                      },
                                      text: 'upload profile image'),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          if (cubit.coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      function: () {
                                        cubit.uploadCoverImage(
                                            name: nameController.text,
                                            bio: bioController.text,
                                            phone: phoneController.text);
                                      },
                                      text: 'upload cover image'),
                                ],
                              ),
                            )
                        ],
                      ),
                    if (cubit.profileImage != null || cubit.coverImage != null)
                      SizedBox(
                        height: 20,
                      ),
                    defaultTextFormField(
                      style: TextStyle(
                        color: Colors.blue,
                       ),
                      prefixIcon: IconlyBroken.user_2,
                      label: 'User Name',
                      type: TextInputType.name,
                      controller: nameController,

                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                        style: TextStyle(color: Colors.blue),
                        prefixIcon: IconlyBroken.info_circle,
                        label: 'Bio',
                        type: TextInputType.text,
                        controller: bioController),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultTextFormField(
                        style: TextStyle(color: Colors.blue),
                        prefixIcon: IconlyBroken.call,
                        label: 'Phone',
                        type: TextInputType.number,
                        controller: phoneController),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
