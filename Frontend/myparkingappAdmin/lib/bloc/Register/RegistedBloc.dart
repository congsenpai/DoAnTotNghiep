// ignore_for_file: avoid_print, non_constant_identifier_names, file_names, unused_local_variable



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';


import '../../repository/authRepository.dart';
import 'RegistedEvent.dart';
import 'RegistedState.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  RegisterBloc():super(RegisterInitial()){
    on<RegisteredEvent>(_Register);
  }
  // ignore: unused_element
  Future<void> _Register(RegisteredEvent event,Emitter<RegisterState> emit) async{
    try{
      AuthRepository userRepository = AuthRepository();
        if(event.password == event.repass){
          UserResponse user = UserResponse(
              username: event.username,
              password: event.password,
              phoneNumber: event.phoneNumber,
              homeAddress: event.homeAddress,
              companyAddress: event.companyAddress,
              lastName: event.lastname,
              firstName: event.firstname,
              avatar: "",
              email: "",
              userId: "",
              status: true, roles: [],
          );
          String mess = await userRepository.Register_MPA(user);
          if(mess == "200"){
            emit(RegisterSuccess(true));
          }
          else{
            emit(RegisterError("Register fail"));
          }

        }
        else{
          emit(RegisterError("Password non match"));
        }
    }
    catch(e){
      print("_Resister $e");
    }
  }
}