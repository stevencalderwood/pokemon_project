import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/widgets/dialog_widget.dart';

/// Only for the Home View
class ScaffoldWidget extends StatelessWidget {
  final Widget body;
  final bool isFirstVersion;
  const ScaffoldWidget({Key? key, required this.body, required this.isFirstVersion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: isFirstVersion
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
                if (isFirstVersion) {
                  Navigator.of(context).pushNamed('/v1/search/');
                } else {
                  Navigator.of(context).pushNamed('/v2/search/');
                }
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () => infoDialog(context: context, isFirstVersion: isFirstVersion),
              icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: body,
    );
  }
}
