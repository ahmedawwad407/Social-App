import 'package:bloc/bloc.dart';
import 'package:f_project/models/social_app/social_create_chat/social_chat_model.dart';
import 'package:f_project/models/social_app/social_create_post/social_post_model.dart';
import 'package:f_project/shared/components/components.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_project/layout/social_app/cubit/states.dart';
import 'package:f_project/models/social_app/social_create_user/socail_user_model.dart';
import 'package:f_project/modules/social_app/chats/chats_screen.dart';
import 'package:f_project/modules/social_app/feeds/feeds_screen.dart';
import 'package:f_project/modules/social_app/settings/setting_screen.dart';
import 'package:f_project/modules/social_app/users/users_screen.dart';
import 'package:f_project/shared/components/constant.dart';
import 'package:f_project/shared/network/local/cache_helper.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_storage/firebase_storage.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialStates());

  static SocialAppCubit getHomeCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;
  var isDark = true;

  SocialUserModel? model;

  List<Widget> screens = [
    Feeds_Screen(),
    UserChat_Screen(),
    Users_Screen(),
    Setting_Screen()
  ];

  List<String> titles = ['Feeds', 'Chats', 'Users', 'Settings'];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(IconlyBroken.home), label: 'Feeds'),
    BottomNavigationBarItem(icon: Icon(IconlyBroken.chat), label: 'Chats'),
    BottomNavigationBarItem(icon: Icon(IconlyBroken.location), label: 'Users'),
    BottomNavigationBarItem(icon: Icon(IconlyBroken.setting), label: 'Setting'),
  ];

  void getUserData() {
    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance.collection('User').doc(uId).get().then((value) {
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      emit(SocialGetUserErrorStates(onError.toString()));
    });
  }

  void changeBottomNav(int index) {
    
    if (index == 1) {
      getAllUserChat();
    }

    currentIndex = index;
    emit(SocialAppChangeBottomNavBarState());
  }

  void changeAppMode({bool? fromSahred}) {
    if (fromSahred != null) {
      isDark = fromSahred;
      emit(changeAppModeState());
    } else {
      isDark = !isDark;
      emit(changeAppModeState());
      CachHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(changeAppModeState());
      });
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialGetImageProfileSuccessStates());
      showToast(
          message: 'Image Selected Successfully.', state: ToastStates.SUCCESS);
    } else {
      showToast(message: 'No Image Selected.', state: ToastStates.ERROR);
      emit(SocialGetImageProfileErrorStates());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialGetImageCoverSuccessStates());
      showToast(
          message: 'Image Selected Successfully.', state: ToastStates.SUCCESS);
    } else {
      showToast(message: 'No Image Selected.', state: ToastStates.ERROR);
      emit(SocialGetImageCoverErrorStates());
    }
  }

  //{Uri.file(profileImage!.path).pathSegments.last => get last path image
  //value.ref.getDownloadURL() => get url image in storage
  void uploadProfileImage({
    required name,
    required phone,
    required bio,
  }) {
    emit(SocialUpdateUserLoadingStates());
    final storage = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadImageProfileSuccessStates());
        showToast(
            message: 'Image Uploded Successfully.', state: ToastStates.SUCCESS);
        print(value);

        updateUser(name: name, phone: phone, bio: bio, profileImage: value);
      }).catchError((onError) {
        showToast(message: 'No Image Uploded.', state: ToastStates.ERROR);

        emit(SocialUploadImageProfileErrorStates());
      });
    }).catchError((onError) {
      emit(SocialUploadImageProfileErrorStates());
    });
  }

  void uploadCoverImage({
    required name,
    required phone,
    required bio,
  }) {
    emit(SocialUpdateUserLoadingStates());
    final storage = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadImageCoverSuccessStates());
        showToast(
            message: 'Image Uploded Successfully.', state: ToastStates.SUCCESS);
        print(value);

        updateUser(name: name, phone: phone, bio: bio, coverImage: value);
      }).catchError((onError) {
        showToast(message: 'No Image Uploded.', state: ToastStates.ERROR);

        emit(SocialUploadImageCoverErrorStates());
      });
    }).catchError((onError) {
      emit(SocialUploadImageCoverErrorStates());
    });
  }

  void updateUser({
    required name,
    required phone,
    required bio,
    String? profileImage,
    String? coverImage,
  }) {
    SocialUserModel modell = SocialUserModel(
        name: name,
        email: model!.email,
        phone: phone,
        bio: bio,
        uId: model!.uId,
        image: profileImage ?? model!.image,
        coverImage: coverImage ?? model!.coverImage,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('User')
        .doc(model!.uId)
        .update(modell.toMap())
        .then((value) {
      emit(SocialUpdateUserSuccessStates());
      getUserData();
      showToast(
          message: 'Update data Successfully.', state: ToastStates.SUCCESS);
    }).catchError((onError) {
      emit(SocialUpdateUserErrorStates());
      print(model!.uId);
      print(onError.toString());
      showToast(message: 'Update data Error.', state: ToastStates.ERROR);
    });
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialGetImagePostSuccessStates());
      showToast(
          message: 'Image Selected Successfully.', state: ToastStates.SUCCESS);
    } else {
      showToast(message: 'No Image Selected.', state: ToastStates.ERROR);
      emit(SocialGetImagePostErrorStates());
    }
  }

  void uploadNewPost({
    required dateTime,
    required postText,
  }) {
    emit(SocialCreatePostLoadingStates());
    final storage = FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialCreatePostSuccessStates());

        createPost(dateTime: dateTime, postText: postText, postImage: value);
        showToast(
            message: 'post Uploded Successfully.', state: ToastStates.SUCCESS);
      }).catchError((onError) {
        showToast(message: 'No post Uploded.', state: ToastStates.ERROR);

        emit(SocialCreatePostErrorStates());
      });
    }).catchError((onError) {
      emit(SocialCreatePostErrorStates());
    });
  }

  void createPost({
    required dateTime,
    required postText,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingStates());

    SocialPostModel postModel = SocialPostModel(
      name: model!.name,
      uId: model!.uId,
      profileImage: model!.image,
      postText: postText,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessStates());
      showToast(
          message: 'Create Post Successfully.', state: ToastStates.SUCCESS);
    }).catchError((onError) {
      emit(SocialCreatePostErrorStates());
      print(model!.uId);
      print(onError.toString());
      showToast(message: 'Create Post Error.', state: ToastStates.ERROR);
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessStates());
  }

  List<SocialPostModel> posts = [];
  List<String> postsId = [];

  void getPosts() {
    emit(SocialGetPostsLoadingStates());
    FirebaseFirestore.instance.collection('posts')
    .orderBy('dateTime')
    .get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length); //number of likes
          postsId.add(element.id);
          posts.add(SocialPostModel.fromJson(element.data()));

          element.reference.collection('comments').get().then((value) {
            comment.add(value.docs.length);
          });
        }).catchError((onError) {});
      });

      emit(SocialGetPostsSuccessStates());
      showToast(message: 'Get Post Successfully.', state: ToastStates.SUCCESS);
    }).catchError((onError) {
      emit(SocialGetPostsErrorStates());
      showToast(message: 'Get Post Error.', state: ToastStates.ERROR);
    });
  }

  List<int> likes = [];

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessStates());
      showToast(message: 'Like Post Successfully.', state: ToastStates.SUCCESS);
    }).catchError((onError) {
      emit(SocialLikePostErrorStates());
      showToast(message: 'Like Post Error.', state: ToastStates.ERROR);
    });
  }

  List<int> comment = [];

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uId)
        .set({'comment': true}).then((value) {
      emit(SocialCommentPostSuccessStates());
      showToast(
          message: 'comment Post Successfully.', state: ToastStates.SUCCESS);
    }).catchError((onError) {
      emit(SocialCommentPostErrorStates());
      showToast(message: 'comment Post Error.', state: ToastStates.ERROR);
    });
  }

  List<SocialUserModel> users = [];

  void getAllUserChat() {
    users = []; //sure list zero
    //or
    //if(users.length == 0)
    emit(SocialGetAllUserCahtLoadingStates());
    FirebaseFirestore.instance.collection('User').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != model!.uId)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUserCahtSuccessStates());
    }).catchError((error) {
      emit(SocialGetAllUserCahtErrorStates(onError.toString()));
    });
  }


void sendMessage({
 required String receiverId,
 required String dateTime,
 required String text,
}){

  SocialMessageModel messageModel =SocialMessageModel(
    senderId: model!.uId,
    receiverId: receiverId,
    dateTime: dateTime,
    text: text
  );

  //my chat
  FirebaseFirestore.instance
  .collection('User')
  .doc(model!.uId)
  .collection('chats')
  .doc(receiverId)
  .collection('messages')
  .add(messageModel.toMap())
  .then((value) {
emit(SocialSendMessageSuccessStates());
  }).catchError((onError){
emit(SocialSendMessageErrorStates());

  });

// other chat
  FirebaseFirestore.instance
  .collection('User')
  .doc(receiverId)
  .collection('chats')
  .doc(model!.uId)
  .collection('messages')
  .add(messageModel.toMap())
  .then((value) {
emit(SocialSendMessageSuccessStates());
  }).catchError((onError){
emit(SocialSendMessageErrorStates());

  });



  
}

List<SocialMessageModel> messages = [];
  void getMessage({
    required String receiverId,
  }){

FirebaseFirestore.instance
  .collection('User')
  .doc(model!.uId)
  .collection('chats')
  .doc(receiverId)
  .collection('messages')
  .orderBy('dateTime')
  .snapshots()//Query of snapshot future (stream open every send (RealTime)) 
  .listen((event) {
    messages = [];
    event.docs.forEach((element) {
      messages.add(SocialMessageModel.fromJson(element.data()));
     });
emit(SocialGetMessageSuccessStates());
  });


  FirebaseFirestore.instance
  .collection('User')
  .doc(receiverId)
  .collection('chats')
  .doc(model!.uId)
  .collection('messages')
  .get()
  .then((value) {
emit(SocialGetMessageSuccessStates());
  }).catchError((onError){
emit(SocialGetMessageErrorStates());

  });


  }



}
