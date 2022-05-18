import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/widgets/dialog_widget.dart';
import 'package:pokemon_project/widgets/scroll_view_widget.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/constants/constants.dart';

class HomeWidget extends StatelessWidget {
  final ControllerApi? controllerApi;
  final ControllerJson? controllerJson;
  const HomeWidget({Key? key, this.controllerApi, this.controllerJson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: controllerApi != null
              ? PopupMenuButton<String>(
                  position: PopupMenuPosition.under,
                  onSelected: (value) => Navigator.pushNamed(context, value),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<String>(
                        value: '/v2/',
                        child: Text(Label.titleSecond),
                      ),
                    ];
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(Label.titleFirst),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                )
              : const Text(Label.titleSecond),
          actions: [
            IconButton(
                onPressed: () {
                  if (controllerApi != null) {
                    Navigator.of(context).pushNamed('/v1/search/');
                  } else {
                    Navigator.of(context).pushNamed('/v2/search/');
                  }
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () => infoDialog(context: context, isFirstVersion: controllerApi != null),
                icon: const Icon(Icons.info_outline)),
          ],
        ),
        body: ScrollViewWidget(controllerApi: controllerApi, controllerJson: controllerJson),
      ),
    );
  }
}
