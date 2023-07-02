import 'package:auto_size_text/auto_size_text.dart';
import 'package:clone_banco_inter/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BancoInterApp());
}

const primaryColor = Color(0xffff7a00);
//const primaryColor = Colors.red;
const spacing = 8.0;
const padding = EdgeInsets.all(spacing);

var brFlag = Image.asset(
  'assets/br.png',
  filterQuality: FilterQuality.high,
  isAntiAlias: true,
);
var usFlag = Image.asset(
  'assets/us.png',
  filterQuality: FilterQuality.high,
  isAntiAlias: true,
);

class BancoInterApp extends StatelessWidget {
  const BancoInterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
  bool take3 = true;
  bool showBrazil = true;

  var sections = [
    Section('Cartões', Icons.credit_card),
    Section('Pix', Icons.pix),
    Section('Investir', Icons.trending_up),
    Section('Meu Porquinho', Icons.savings),
    Section('Pagamentos', CupertinoIcons.barcode),
    Section('Transferências', Icons.currency_exchange),
    Section('Depósito por boleto', Icons.receipt_long_outlined),
    Section('Antecipação do FGTS', Icons.savings),
    Section('Indique e Ganhe', Icons.card_giftcard),
    Section('Depósito por cheque', Icons.local_atm),
    Section('Recarga', Icons.phone_android),
    Section('Financiamento Imobiliário', Icons.real_estate_agent),
  ];

  var sections2 = [
    Section('Gift Cards', Icons.card_giftcard),
    Section('Recarga', Icons.phone_android),
    Section('Delivery', Icons.delivery_dining),
    Section('Todos', Icons.more_horiz),
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
            activeThumbImage: brFlag.image,
            inactiveThumbImage: usFlag.image,
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
          child: Container(
            padding: padding,
            child: Row(
              children: [
                Text(
                  'R\$ 7531,59 ',
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
      body: Padding(
        padding: padding,
        child: ListView(
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
            Expanded(
              flex: 0,
              child: GridView.builder(
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
            ),
            Expanded(
              child: Column(
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
            ),
            Expanded(
              flex: 0,
              child: GridView.builder(
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
            )
          ],
        ),
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
