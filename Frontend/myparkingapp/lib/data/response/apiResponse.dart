// ignore_for_file: file_names

class APIResult {
  final int code;
  final String message;
  final dynamic result;
  final int pageAmount;
  final int page;

  APIResult(this.pageAmount, this.page, {required this.code, required this.message, required this.result});
}