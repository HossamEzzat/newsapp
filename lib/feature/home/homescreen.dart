import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_controller.dart';

class Homescreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, provider, child) {
          return Scaffold(
            body: (provider.errorMessage?.isNotEmpty ?? false)
                ? Center(child: Text(provider.errorMessage.toString()))
                : provider.everythingLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: provider.newsEverythingList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              provider.newsEverythingList[index].title,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
