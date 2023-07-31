

abstract class SocialAppStates{

}

class SocialAppInitialStates extends SocialAppStates{

}

class SocialGetUserLoadingStates extends SocialAppStates{

}

class SocialGetUserSuccessStates extends SocialAppStates{

}

class SocialGetUserErrorStates extends SocialAppStates{

final String error;
SocialGetUserErrorStates(this.error);
}

class SocialAppChangeBottomNavBarState extends SocialAppStates{


}

class SocialNewPostSuccessStates extends SocialAppStates{

}

class SocialGetImageProfileSuccessStates extends SocialAppStates{

}

class SocialGetImageProfileErrorStates extends SocialAppStates{

}

class SocialGetImageCoverSuccessStates extends SocialAppStates{

}

class SocialGetImageCoverErrorStates extends SocialAppStates{

}
class SocialUploadImageProfileSuccessStates extends SocialAppStates{

}

class SocialUploadImageProfileErrorStates extends SocialAppStates{

}

class SocialUploadImageCoverSuccessStates extends SocialAppStates{

}

class SocialUploadImageCoverErrorStates extends SocialAppStates{

}

class SocialUpdateUserLoadingStates extends SocialAppStates{

}

class SocialUpdateUserSuccessStates extends SocialAppStates{

}

class SocialUpdateUserErrorStates extends SocialAppStates{


}


class SocialGetImagePostSuccessStates extends SocialAppStates{

}

class SocialGetImagePostErrorStates extends SocialAppStates{

}

//CREATE_POST

class SocialCreatePostLoadingStates extends SocialAppStates{

}

class SocialCreatePostSuccessStates extends SocialAppStates{

}

class SocialCreatePostErrorStates extends SocialAppStates{


}

class SocialRemovePostImageSuccessStates extends SocialAppStates{

}


class SocialGetPostsLoadingStates extends SocialAppStates{

}

class SocialGetPostsSuccessStates extends SocialAppStates{

}

class SocialGetPostsErrorStates extends SocialAppStates{


}


class SocialLikePostSuccessStates extends SocialAppStates{

}

class SocialLikePostErrorStates extends SocialAppStates{


}


class SocialCommentPostSuccessStates extends SocialAppStates{

}

class SocialCommentPostErrorStates extends SocialAppStates{


}

class SocialGetAllUserCahtLoadingStates extends SocialAppStates{

}

class SocialGetAllUserCahtSuccessStates extends SocialAppStates{

}

class SocialGetAllUserCahtErrorStates extends SocialAppStates{

final String error;
SocialGetAllUserCahtErrorStates(this.error);
}

class SocialSendMessageSuccessStates extends SocialAppStates{

}

class SocialSendMessageErrorStates extends SocialAppStates{


}

class SocialGetMessageSuccessStates extends SocialAppStates{

}

class SocialGetMessageErrorStates extends SocialAppStates{


}

class changeAppModeState extends SocialAppStates{

}


