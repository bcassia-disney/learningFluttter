import 'model.dart';

class NetworkingResponse {}

class NetworkingException extends NetworkingResponse {
  String message;
  NetworkingException(this.message);
}

class NetworkingResponseData extends NetworkingResponse {
  Model apiResponseModel;
  NetworkingResponseData(this.apiResponseModel);
}