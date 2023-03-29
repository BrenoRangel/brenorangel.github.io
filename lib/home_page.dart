import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:portifolio/constants.dart';
import 'package:portifolio/theming.dart';

import 'data.dart';
import 'item_view.dart';
import 'main.dart';
import 'multi_select.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var allTags = List<String>.from(tagIcons.keys);
ScrollController controller = ScrollController();

class _HomePageState extends State<HomePage> {
  List<String> _selectedTags = [];
  var _selectedItems = apps;

  @override
  Widget build(BuildContext context) {
    var constraints = BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height / 2,
      maxWidth: MediaQuery.of(context).size.width - 16,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Portifólio | Breno Rangel'),
        centerTitle: true,
        bottom: AppBar(
          title: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.end,
            spacing: 8,
            runSpacing: 8,
            children: [
              Tooltip(
                message: "Direitos de uso",
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: AlertDialog(
                              content: ConstrainedBox(
                                constraints: constraints,
                                child: const Text("Não possuo direitos de distribuição/venda de nenhum dos aplicativos a seguir. Todos os direitos reservados às suas respectivas distribuidoras"),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.copyright,
                  ),
                ),
              ),
              Tooltip(
                message: "Tema",
                child: ElevatedButton(
                  onPressed: () async {
                    if (Theme.of(context).brightness == Brightness.dark) {
                      MyApp.of(context).changeTheme(ThemeMode.light);
                    } else {
                      MyApp.of(context).changeTheme(ThemeMode.dark);
                    }
                  },
                  child: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode),
                ),
              ),
              Tooltip(
                message: "Filtros",
                child: ElevatedButton(
                  onPressed: () async {
                    var results = await showDialog(
                      context: context,
                      builder: (BuildContext context) => MultiSelect(
                        title: const Text('Filtros'),
                        selectedItems: _selectedTags,
                        items: allTags,
                      ),
                    );

                    if (results is List<String> && results.isNotEmpty) {
                      setState(() {
                        _selectedTags = results;
                        _selectedItems = apps
                            .where(
                              (e) => e.tags.any(
                                (t) => _selectedTags.contains(t),
                              ),
                            )
                            .toList();
                      });
                    } else {
                      setState(() {
                        _selectedTags.clear();
                        _selectedItems = apps;
                      });
                    }
                  },
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: const [
                      Icon(Icons.filter_alt_sharp),
                      /*
                      if (_selectedTags.isNotEmpty) ...[
                        ..._selectedTags.map(
                          (tag) {
                            //var length = apps.where((e) => e.tags.contains(tag)).length;
                            return Image.network(
                              "${tagIcons[tag]}",
                              width: 20,
                              height: 20,
                            );
                          },
                        ),
                        Text(
                          "(${_selectedItems.length} ${_selectedItems.length == 1 ? 'app' : 'apps'})",
                        ),
                      ] else
                        Text("Todos (${apps.length} ${apps.length == 1 ? 'app' : 'apps'})"),
                        */
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: kToolbarHeight / 2,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Criado com "),
            Tooltip(message: "Firebase", child: Image.network(tagIcons["Firebase"]!, height: 20)),
            const Text(" e "),
            const Tooltip(message: "Flutter", child: FlutterLogo(size: 20))
          ],
        ),
      ),
      body: ScrollShadow(
        color: Colors.black.withOpacity(0.25),
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Scrollbar(
            thumbVisibility: true,
            controller: controller,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: controller,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ..._selectedItems
                      .map(
                        (item) => Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 16,
                                ),
                                child: ItemView(item: item),
                              ),
                            ),
                          ],
                        ),
                      )
                      .expand(
                        (e) => [
                          e,
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      )
                      .toList()
                    ..removeLast(),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
