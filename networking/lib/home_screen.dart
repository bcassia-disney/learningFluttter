import 'package:flutter/material.dart';
import 'package:networking/model.dart';
import 'package:provider_architecture/provider_architecture.dart';

import 'home_screen_view_model.dart';
import 'notification_service.dart';

class HomeScreen extends StatelessWidget {
  // final NotificationService _notificationService = NotificationService();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeScreenViewModel>.withConsumer(
        builder: (context, viewModel, child) {
          return Container(
              color: Colors.white,
              child: SafeArea(
                  child: Scaffold(
                appBar: buildAppBar(),
                body: buildBody(viewModel),
                floatingActionButton: buildFloatingActionButton(viewModel),
              )));
        },
        viewModelBuilder: () => HomeScreenViewModel());
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Member"),
    );
  }

  Widget buildBody(viewModel) {
    return Center(child: buildDataWidget(viewModel));
  }

  FloatingActionButton buildFloatingActionButton(viewModel) {
    return FloatingActionButton(
      tooltip: "Get Data from API",
      onPressed: () async {
        viewModel.getDataFromAPI();
        // await _notificationService.showNotifications();
      },
      child: viewModel.isLoading
          ? const CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
          : const Icon(Icons.cloud_download),
    );
  }

  buildDataWidget(viewModel) {
    Model? apiResponseModel = viewModel.apiResponseModel;

    if (apiResponseModel == null) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Loading",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Text(
        "Title: ${apiResponseModel.results?[0].name?.title}\n"
        "Gender: ${apiResponseModel.results?[0].gender}\n"
        "First Name : ${apiResponseModel.results?[0].name?.first}\n"
        "Last Name : ${apiResponseModel.results?[0].name?.last}\n"
        "Email: ${apiResponseModel.results?[0].email}\n"
        "Country: ${apiResponseModel.results?[0].location?.country}\n"
        "City: ${apiResponseModel.results?[0].location?.city}\n"
        "Street: ${apiResponseModel.results?[0].location?.street?.name}\n"
        "Number: ${apiResponseModel.results?[0].location?.street?.number}\n",
        style: const TextStyle(fontSize: 18),
      );
    }
  }
}