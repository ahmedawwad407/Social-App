

abstract class SocialLoginStates{

}

class SocialLoginInitialStates extends SocialLoginStates{

}

class SocialLoginLoadingState extends SocialLoginStates{

}

class SocialLoginSuccessState extends SocialLoginStates{

  final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}
class changeShowPasswordIconState extends SocialLoginStates{

}

