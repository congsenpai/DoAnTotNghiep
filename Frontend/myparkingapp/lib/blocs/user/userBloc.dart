
// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/data/response/apiResponse.dart';
import 'package:myparkingapp/blocs/user/userEvent.dart';
import 'package:myparkingapp/blocs/user/userState.dart';
import 'package:myparkingapp/repository/userRepository.dart';

import '../../data/model/user.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  UserBloc():super(UserInitialState()){
    on<UpdateUser>(_updateUser);

  }
  void _updateUser(UpdateUser event, Emitter<UserState> emit) async{
    UserRepository userRepository = UserRepository();
    try{
      APIResult result = await userRepository.updatedUser(event.user, event.token);
      int code = result.code;
      String message = result.message;
      User user = result.result;
      if(code == 200 ){
        emit(UserLoadedState(user));
      }
      else{
        emit(UserErrorState(message));
      }
    }
    catch(e){
      throw Exception("_updateUser $e");
    }
  }
}
