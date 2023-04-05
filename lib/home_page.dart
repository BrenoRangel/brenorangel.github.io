import 'dart:ui';

import 'package:basement/basement.dart';
import 'package:clone_banco_inter/main.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/app_card.dart';
import 'components/header.dart';
import 'components/item_view.dart';
import 'constants.dart';
import 'data.dart';
import 'item.dart';
import 'main.dart';
import 'multi_select.dart';
import 'theming.dart';

var allTags = List<String>.from(tagIcons.keys);
ScrollController controller = ScrollController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _selectedTags = [];
  var _selectedItems = apps;

  @override
  Widget build(BuildContext context) {
    final constraints = getConstraints(context);
    final interApp = ConstrainedBox(
      constraints: constraints,
      child: DeviceFrame(
        screen: const InterApp(),
        device: Devices.ios.iPhone13,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Portifólio | Breno Rangel'),
        centerTitle: true,
        toolbarHeight: kTextTabBarHeight,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: Container(
            height: kTextTabBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ...[
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
                          PortifolioApp.of(context).changeTheme(ThemeMode.light);
                        } else {
                          PortifolioApp.of(context).changeTheme(ThemeMode.dark);
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
                ].map(
                  (element) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: element,
                  ),
                ),
                const Spacer(),
                Tooltip(
                  message: 'LinkedIn',
                  child: InkWell(
                    onTap: () {
                      launchUrl(
                        Uri.parse('https://www.linkedin.com/in/brenorangel/'),
                      );
                    },
                    child: Image.network(
                      'https://logopng.com.br/logos/linkedin-83.svg',
                      height: kMinInteractiveDimension / 2,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: kTextTabBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Criado com "),
            Tooltip(message: "Flutter", child: FlutterLogo(size: 20)),
          ],
        ),
      ),
      body: ScrollShadow(
        color: Colors.black.withOpacity(0.25),
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Scrollbar(
            controller: controller,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: controller,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  buildRow(
                    AppCard(
                      children: [
                        Header(
                          Item(
                            title: "Clone Banco Inter",
                            tags: [
                              'Celular',
                              'Flutter',
                              'Dart'
                            ],
                          ),
                        ),
                        gap,
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: IgnorePointer(child: interApp),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: LayoutBuilder(
                                    builder: (context, snapshot) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                        child: AlertDialog(
                                          elevation: 0,
                                          contentPadding: EdgeInsets.zero,
                                          insetPadding: const EdgeInsets.all(8),
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          content: SizedBox(width: snapshot.maxWidth, height: snapshot.maxHeight, child: interApp),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  ..._selectedItems.map(
                    (item) => buildRow(ItemView(item: item)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildRow(Widget child) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 16,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
