abstract class Authstate {}

class AuthInitial extends Authstate {}

class ShowPassword extends Authstate {}

class logInvalidate extends Authstate {}

class logInLoading extends Authstate {}

class logInsucess extends Authstate {}

class logInError extends Authstate {}

class logInErrorConnection extends Authstate {}

////   log out
class LogOutLoading extends Authstate {}

class LogOutSuccess extends Authstate {}

class LogOutError extends Authstate {
  final String message;
  LogOutError(this.message);

  @override
  List<Object?> get props => [message];
}

class IsEmail extends Authstate {}
class IsNotEmail extends Authstate {}


// Signup states

class signUpLoading extends Authstate {}

class signUpSuccess extends Authstate {
  final String message;
  signUpSuccess({required this.message});
}

class signUpError extends Authstate {
  final String message;
  signUpError({required this.message});
}
