import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:http/http.dart';
import 'package:portfolio/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data.dart';
import 'item_view.dart';
import 'main.dart';
import 'multi_select.dart';
import 'theming.dart';

final allTags = List<String>.from(tagIcons.keys);

final scrollController = ScrollController();
final shadowColor = Colors.black.withOpacity(0.25);

void animateToTop() {
  scrollController.animateTo(
    0,
    duration: const Duration(seconds: 1),
    curve: Curves.ease,
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final _selectedTags = <String>[];
  final _selectedItems = List.from(apps);

  @override
  Widget build(BuildContext context) {
    final constraints = BoxConstraints(
      maxHeight: min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 2,
      maxWidth: MediaQuery.of(context).size.width - 16,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Portfolio | Breno Rangel'),
          centerTitle: true,
          toolbarHeight: kMinInteractiveDimension,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8).add(const EdgeInsets.only(bottom: 8)),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Tooltip(
                          message: "Direitos de uso",
                          child: GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return BackdropFilter(
                                    filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
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
                          child: GestureDetector(
                            onTap: () async {
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
                          child: GestureDetector(
                            onTap: () async {
                              final results = await showDialog(
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
                            child: const Icon(
                              Icons.filter_alt_sharp,
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
                    Tooltip(
                      message: 'AWS Certified Cloud Practitioner',
                      child: InkWell(
                        onTap: () {
                          launchUrl(
                            Uri.parse('https://www.credly.com/badges/25e3c826-d0e6-407c-8b41-29d482da4e3f/public_url'),
                          );
                        },
                        child: const SizedBox(
                          width: kTextTabBarHeight / 2,
                          height: kTextTabBarHeight / 2,
                          child: Image(
                            image: AssetImage('assets/images/badges/00634f82-b07f-4bbd-a6bb-53de397fc3a6.png'),
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: 'AWS Cloud Quest: Cloud Practitioner',
                      child: InkWell(
                        onTap: () {
                          launchUrl(
                            Uri.parse('https://www.credly.com/badges/af3779a4-e15b-4097-926d-ef8912bc5401'),
                          );
                        },
                        child: const SizedBox(
                          width: kTextTabBarHeight / 2,
                          height: kTextTabBarHeight / 2,
                          child: Image(
                            image: AssetImage('assets/images/badges/2784d0d8-327c-406f-971e-9f0e15097003.png'),
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: 'Oracle Cloud Infrastructure 2023 Certified Foundations Associate',
                      child: InkWell(
                        onTap: () {
                          launchUrl(
                            Uri.parse('https://catalog-education.oracle.com/pls/certview/sharebadge?id=F3E1145ADDF7C8322BE5B65C822B901FDC8B9D3C7DE46621062FB81D3A8C5915'),
                          );
                        },
                        child: const SizedBox(
                          width: kTextTabBarHeight / 2,
                          height: kTextTabBarHeight / 2,
                          child: Image(
                            image: AssetImage('assets/images/badges/OCIF2023CA.png'),
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(),
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
                            child: SizedBox(
                              width: kTextTabBarHeight / 2,
                              height: kTextTabBarHeight / 2,
                              child: Image.network(
                                'https://logopng.com.br/logos/linkedin-83.svg',
                                filterQuality: FilterQuality.high,
                                isAntiAlias: true,
                              ),
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: animateToTop,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: const Icon(
            Icons.keyboard_arrow_up,
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
        body: Scaffold(
          appBar: true
              ? null
              : AppBar(
                  elevation: 0,
                  toolbarHeight: 0,
                  bottom: TabBar(
                    isScrollable: true,
                    controller: TabController(length: 3, vsync: this),
                    padding: EdgeInsets.zero,
                    indicator: const BoxDecoration(),
                    onTap: (index) {
                      switch (index) {
                        case 0:
                          break;

                        case 1:
                          break;
                        case 2:
                          break;
                      }
                    },
                    tabs: const [
                      //const Text("Minhas Certificações: "),
                      Tab(
                        icon: Tooltip(
                          message: 'AWS Certified Cloud Practitioner',
                          child: Image(
                            image: AssetImage('assets/images/badges/00634f82-b07f-4bbd-a6bb-53de397fc3a6.png'),
                          ),
                        ),
                      ),
                      Tab(
                        icon: Tooltip(
                          message: 'AWS Cloud Quest: Cloud Practitioner',
                          child: Image(
                            image: AssetImage('assets/images/badges/2784d0d8-327c-406f-971e-9f0e15097003.png'),
                          ),
                        ),
                      ),
                      Tab(
                        icon: Tooltip(
                          message: 'Oracle Cloud Infrastructure 2023 Certified Foundations Associate',
                          child: Image(
                            image: AssetImage('assets/images/badges/OCIF2023CA.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          body: ScrollShadow(
            color: shadowColor,
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Scrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              gap
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
      ),
    );
  }
}

Future<ui.Image> _loadUiImage(String url) async {
  final response = await get(Uri.parse(url));
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(response.bodyBytes, completer.complete);
  return completer.future;
}
