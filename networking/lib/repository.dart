import 'dart:ui';
import 'networking_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class Repository {
  /// ViewModel calls its Repository to getLatestStatsData
  /// The Repository will take care of getting the data from thr right source
  /// Only HomeRepository knows that it has to call NetworkRepo()
  /// ViewModel doesn't care if its coming from API or Offline Cache
  Future<NetworkingResponse> getLatestStatsData() {
    return _NetworkRepo().getLatestDataFromAPI();
  }
}

/// Network Repo will do the networking for you
/// And will also take care of parsing
/// and exception handling
/// will simply return you data model or the exception message
class _NetworkRepo {
  static const String API_END_POINT_URL = "https://randomuser.me/api/";

  /// Instead of returning ApiResponseModel
  /// We have created a parent class called NetworkingResponse
  /// Which takes care of Successful and Failed response
  /// So we either send a successful or failed response wrapped in NetworkingResponse

  Future<NetworkingResponse> getLatestDataFromAPI() async {
    try {
      var response = await http.get(Uri.parse(API_END_POINT_URL));
      var parsedJson = await json.decode(response.body);
      Model apiResponseModel = Model.fromJson(parsedJson);
      return NetworkingResponseData(apiResponseModel);
    } catch (exception) {
      return NetworkingException(exception.toString());
    }
  }
}