// ignore_for_file: camel_case_types, file_names

abstract class MainAppEvent{}

class initializationEvent extends MainAppEvent{
  final String token;
  initializationEvent(this.token);
}
class LogoutEvent extends MainAppEvent{
}


