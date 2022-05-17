import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/widgets/dialog_widget.dart';
import 'package:pokemon_project/widgets/scroll_view_widget.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/version.dart';

class HomeWidget extends StatelessWidget {
  final void Function(int) action;
  final ControllerApi? controllerApi;
  final ControllerJson? controllerJson;
  final ProjectVersion version;
  const HomeWidget({Key? key, this.controllerApi, this.controllerJson, required this.action, required this.version})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: PopupMenuButton<int>(
            position: PopupMenuPosition.under,
            onSelected: action,
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(version == ProjectVersion.first ? Label.titleSecond : Label.titleFirst),
                ),
              ];
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(version == ProjectVersion.first ? Label.titleFirst : Label.titleSecond),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (version == ProjectVersion.first) {
                    Navigator.of(context).pushNamed('/v1/search/');
                  } else {
                    Navigator.of(context).pushNamed('/v2/search/');
                  }
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () => infoDialog(
                      context: context,
                      version: version,
                    ),
                icon: const Icon(Icons.info_outline)),
          ],
        ),
        body: Column(
          children: [ScrollViewWidget(controllerApi: controllerApi, controllerJson: controllerJson)],
        ),
      ),
    );
  }
}
