class NetworkResponse<T> {
  T? body;
  int? statusCode;

  NetworkResponse({this.body, this.statusCode});
}