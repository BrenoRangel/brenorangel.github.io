import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:portfolio/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data.dart';
import 'item_view.dart';
import 'main.dart';
import 'multi_select.dart';
import 'theming.dart';

var allTags = List<String>.from(tagIcons.keys);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _selectedTags = [];
  final _selectedItems = apps;
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var constraints = BoxConstraints(
      maxHeight: min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 2,
      maxWidth: MediaQuery.of(context).size.width - 16,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Portfolio | Breno Rangel'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8).add(const EdgeInsets.only(bottom: 8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Tooltip(
                        message: "Direitos de uso",
                        child: ElevatedButton(
                          style: roundButtonStyle,
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
                          style: roundButtonStyle,
                          onPressed: () async {
                            if (Theme.of(context).brightness == Brightness.dark) {
                              PortfolioApp.of(context).changeTheme(ThemeMode.light);
                            } else {
                              PortfolioApp.of(context).changeTheme(ThemeMode.dark);
                            }
                          },
                          child: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode),
                        ),
                      ),
                      Tooltip(
                        message: "Filtros",
                        child: ElevatedButton(
                          style: roundButtonStyle,
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
                                _selectedTags
                                  ..clear()
                                  ..addAll(results);
                                _selectedItems
                                  ..clear()
                                  ..addAll(
                                    apps.where(
                                      (app) => app.tags.any(
                                        (tag) => _selectedTags.contains(tag),
                                      ),
                                    ),
                                  );
                              });
                            } else {
                              setState(() {
                                _selectedTags.clear();
                                _selectedItems
                                  ..clear()
                                  ..addAll(apps);
                              });
                            }
                          },
                          child: const Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
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
                    ]
                        .map(
                          (element) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: element,
                          ),
                        )
                        .toList(),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const SizedBox(
          height: kTextTabBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        height: kMinInteractiveDimension,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 0,
                              child: Tooltip(
                                message: 'AWS Certified Cloud Practitioner',
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse('https://www.credly.com/badges/25e3c826-d0e6-407c-8b41-29d482da4e3f/public_url'),
                                      );
                                    },
                                    child: Image.network(
                                      'https://images.credly.com/size/256x256/images/00634f82-b07f-4bbd-a6bb-53de397fc3a6/image.png',
                                      filterQuality: FilterQuality.high,
                                      isAntiAlias: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Tooltip(
                                message: 'AWS Cloud Quest: Cloud Practitioner',
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse('https://www.credly.com/badges/af3779a4-e15b-4097-926d-ef8912bc5401/public_url'),
                                      );
                                    },
                                    child: Image.network(
                                      'https://images.credly.com/size/256x256/images/2784d0d8-327c-406f-971e-9f0e15097003/image.png',
                                      filterQuality: FilterQuality.high,
                                      isAntiAlias: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Tooltip(
                                message: 'Oracle Cloud Infrastructure 2023 Certified Foundations Associate',
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse('https://catalog-education.oracle.com/pls/certview/sharebadge?id=F3E1145ADDF7C8322BE5B65C822B901FDC8B9D3C7DE46621062FB81D3A8C5915'),
                                      );
                                    },
                                    child: Image.network(
                                      'https://brm-workforce.oracle.com/pdf/certview/images/OCIF2023CA.png',
                                      filterQuality: FilterQuality.high,
                                      isAntiAlias: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                              .expand((element) => [
                                    element,
                                    element,
                                    element,
                                    element
                                  ])
                              .toList(),
                        ),
                      ),
                    ),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
