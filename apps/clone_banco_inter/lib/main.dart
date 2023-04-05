import 'package:auto_size_text/auto_size_text.dart';
import 'package:clone_banco_inter/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const InterApp());
}

const primaryColor = Color(0xffff7a00);
//const primaryColor = Colors.red;
const spacing = 8.0;
const padding = EdgeInsets.all(spacing);

const brFlag = AssetImage(
  'assets/br.png',
  package: 'clone_banco_inter',
);
const usFlag = AssetImage(
  'assets/us.png',
  package: 'clone_banco_inter',
);

class InterApp extends StatelessWidget {
  const InterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: primaryColor,
          outline: Colors.transparent,
        ).copyWith(
          primary: primaryColor,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool take3 = false;
  bool showBrazil = true;

  var sections = [
    Section('Cartões', Icons.credit_card_outlined),
    Section('Pix', Icons.pix_outlined),
    Section('Investir', Icons.trending_up_outlined),
    Section('Meu Porquinho', Icons.savings_outlined),
    Section('Pagamentos', CupertinoIcons.barcode),
    Section('Transferências', Icons.currency_exchange_outlined),
    Section('Depósito por boleto', Icons.receipt_long_outlined),
    Section('Antecipação do FGTS', Icons.savings_outlined),
    Section('Indique e Ganhe', Icons.card_giftcard_outlined),
    Section('Depósito por cheque', Icons.local_atm_outlined),
    Section('Recarga', Icons.phone_android_outlined),
    Section('Financiamento Imobiliário', Icons.real_estate_agent_outlined),
  ];

  var sections2 = [
    Section('Gift Cards', Icons.card_giftcard_outlined),
    Section('Recarga', Icons.phone_android_outlined),
    Section('Delivery', Icons.delivery_dining_outlined),
    Section('Todos', Icons.more_horiz_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'banco',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          Switch(
            onChanged: (a) {
              setState(() {
                showBrazil = a;
              });
            },
            value: showBrazil,
            activeThumbImage: brFlag,
            inactiveThumbImage: usFlag,
            trackColor: MaterialStatePropertyAll(showBrazil ? const Color(0xff6da544) : const Color(0xffd80027)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: spacing),
            child: Row(
              children: [
                Text(
                  'R\$ 7.531,59 ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Icon(
                  Icons.remove_red_eye_outlined,
                  color: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: padding,
        shrinkWrap: true,
        children: <Widget>[
          Row(
            children: [
              Text(
                'Ver extrato',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          GridView.builder(
            itemCount: take3 ? 3 : sections.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              crossAxisCount: 3,
            ),
            shrinkWrap: true,
            itemBuilder: (c, i) => SectionView(sections[i]),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    take3 = !take3;
                  });
                },
                child: Transform.scale(
                  scaleX: 2,
                  child: Icon(
                    take3 ? Icons.expand_more_rounded : Icons.expand_less_rounded,
                  ),
                ),
              ),
            ],
          ),
          GridView.builder(
            itemCount: sections2.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              crossAxisCount: 4,
            ),
            shrinkWrap: true,
            itemBuilder: (c, i) => SectionView2(sections2[i]),
          ),
        ],
      ),
    );
  }
}

class SectionView extends StatelessWidget {
  final Section section;

  const SectionView(
    this.section, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(padding),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(
              spacing,
            ),
          ),
        ),
      ),
      onPressed: () {},
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        iconColor: Theme.of(context).colorScheme.primary,
        title: Icon(section.iconData),
        dense: true,
        subtitle: AutoSizeText(
          section.title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }
}

class SectionView2 extends StatelessWidget {
  final Section section;

  const SectionView2(
    this.section, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              spacing,
            ),
          ),
        ),
      ),
      onPressed: () {},
      child: ListTile(
        iconColor: Theme.of(context).colorScheme.primary,
        contentPadding: EdgeInsets.zero,
        title: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            section.iconData,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        dense: true,
        subtitle: AutoSizeText(
          section.title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }
}
