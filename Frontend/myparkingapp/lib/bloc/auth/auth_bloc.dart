import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_event.dart';
import 'package:myparkingapp/bloc/auth/auth_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/auth_repository.dart';
import 'package:myparkingapp/data/repository/user_repository.dart';
import 'package:myparkingapp/data/request/register_user_request.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc():super(AuthInitialState()){
    on<LoginEvent>(_login);
    on<GetUserEvent>(_giveUserByUserName);
    on<RegisterEvent>(_register);
    on<giveEmail>(_giveEmail);
    on<giveRePassWord>(_giveRePassWord);
  }
}

void _login(LoginEvent event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  AuthRepository auth = AuthRepository();
  ApiResult apiResult = await auth.login(event.userName, event.passWord);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    emit(AuthSuccessState(mess));
  }
  else{
    emit(AuthErrorState(mess));
  }
}
void _giveUserByUserName(GetUserEvent event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  UserRepository user = UserRepository();
  ApiResult apiResult = await user.getUserByUserName(event.userName);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    UserResponse user = apiResult.result;
    emit(GotoAcceptLocationScreenState(user));
  }
  else{
    emit(AuthErrorState(mess));
  }

  
} 
void _register(RegisterEvent event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  AuthRepository auth = AuthRepository();
  RegisterUserRequest request = RegisterUserRequest(
    username: event.userName,
    password: event.passWord,
    firstName: 'firstName', 
    lastName: 'lastName', 
    email: event.email, 
    phone: event.phoneNumber, 
    homeAddress: 'homeAddress', 
    companyAddress: 'companyAddress');
  ApiResult apiResult = await auth.register(request);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    emit(AuthSuccessState(mess));
  }
  else{
    emit(AuthErrorState(mess));
  }
}

void _giveEmail(giveEmail event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  AuthRepository auth = AuthRepository();
  ApiResult apiResult = await auth.giveEmail(event.email);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    emit(AuthSuccessState(mess));
  }
  else{
    emit(AuthErrorState(mess));
  }
}

  void _giveRePassWord(giveRePassWord event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  AuthRepository auth = AuthRepository();
  ApiResult apiResult = await auth.giveRePassWord(event.password, event.token);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    emit(AuthSuccessState(mess));
  }
  else{
    emit(AuthErrorState(mess));
  }
}