// ignore_for_file: avoid_print, file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/userRepository.dart';
import '../../repository/authRepository.dart';
import 'main_app_event.dart';
import 'main_app_state.dart';

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  MainAppBloc() : super(MainInitial()) {
    on<initializationEvent>(_getUserByUserName);
    on<LogoutEvent>(_logout);
    on<UpdatesUserInforEvent>(_updatesUserInfo);
    on<UpdatesPassEvent>(_updatesPass);
  }

  void _getUserByUserName(initializationEvent event, Emitter<MainAppState> emit) async{
    try {
      // final UserRepository userRepository = UserRepository();
      // ApiResult userResult = await userRepository.getUserByUserName(event.userName);
      // String message = userResult.message;
      // int code = userResult.code;
      // if(code == 200){
      //   emit(
      //       MainAppLoadedState(userResult.result)
      //   );
      // }
      // else{
      //   emit(MainAppErrorState(message));
      // }
      
      emit(
      MainAppLoadedState(users[0])
      );

    }
    catch(e){
      print("_updatedUserInfo $e");
    }
  }
  
  void  _updatesUserInfo(UpdatesUserInforEvent event, Emitter<MainAppState> emit) async{
    try {
      final UserRepository userRepository = UserRepository();
      ApiResult userResult = await userRepository.updatedUser(event.request, event.userId);
      String message = userResult.message;
      int code = userResult.code;
      if(code == 200){
        emit(
            MainAppSuccessState(message)
        );
      }
      
      else{
        emit(MainAppErrorState(message));
      }

    }
    catch(e){
      print("_updatedUserInfo $e");
    }
  }
  
  void _updatesPass(UpdatesPassEvent event, Emitter<MainAppState> emit) async{
    try {
      final UserRepository userRepository = UserRepository();
      ApiResult userResult = await userRepository.changePassWord(event.userId,event.oldderPass,event.newPass);
      String message = userResult.message;
      int code = userResult.code;
      if(code == 200){
        emit(
            MainAppSuccessState(message)
        );
      }
      else{
        emit(MainAppErrorState(message));
      }

    }
    catch(e){
      print("_updatesPass $e");
    }
  }
  void _logout(LogoutEvent event, Emitter<MainAppState> emit) async{
    final AuthRepository userRepository = AuthRepository();
    userRepository.logout();
    emit(
      LogoutSuccess()
    );
  }
} 


