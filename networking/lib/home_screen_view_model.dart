import 'package:flutter/cupertino.dart';
import '/networking_response.dart';
import 'repository.dart';
import 'model.dart';

class HomeScreenViewModel extends ChangeNotifier {
  Model? apiResponseModel;
  String messageToShow = "";
  bool isLoading = false;

  HomeScreenViewModel() {
    getDataFromAPI();
  }

  void getDataFromAPI() async {
    /// Start showing the loader
    isLoading = true;
    notifyListeners();

    /// Wait for response
    NetworkingResponse networkingResponse =
    await Repository().getLatestStatsData();

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      /// Updating the APIResponseModel when success
      apiResponseModel = networkingResponse.apiResponseModel;
    } else if (networkingResponse is NetworkingException) {
      /// Updating the errorMessage when fails
      messageToShow = networkingResponse.message;
    }

    /// Stop the loader
    isLoading = false;
    notifyListeners();
  }
}