import 'package:ez_english/core/constants.dart';
import 'package:ez_english/features/account/account.dart';
import 'package:ez_english/features/auth/view_model/auth_view_model.dart';
import 'package:ez_english/features/result/Results.dart';
import 'package:ez_english/theme/palette.dart';
import 'package:ez_english/theme/text_styles.dart';
import 'package:ez_english/widgets/selectable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LevelSelection extends StatefulWidget {
  const LevelSelection({Key? key}) : super(key: key);

  @override
  State<LevelSelection> createState() => _LevelSelectionState();
}

class _LevelSelectionState extends State<LevelSelection> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();
  final _pages = const [
    LevelSelection(),
    Results(),
    Account(),
  ];
  @override
  void initState() {
    super.initState();
    changeColor();
  }

  void changeColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Palette.secondary);
  }

  void navigateToLevel({required String levelId}) {
    context.push('/level/$levelId');
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    changeColor();
    return Scaffold(
      appBar: AppBar(
        // TODO remove this icon after implementing signout in account screen
        actions: [
          IconButton(
              onPressed: () {
                authViewModel.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Assigned Levels',
          style: TextStyle(color: Palette.primaryText),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              // First row
              Constants.gapH36,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    _buildCard(
                        headerText: 'A1',
                        cardText:
                            "learn common everyday expressions and simple phrases",
                        onTap: (levelId) {
                          navigateToLevel(levelId: "1");
                        }),
                    Constants.gapW10,
                    _buildCard(
                      headerText: 'A1',
                      cardText:
                          "learn common everyday expressions and simple phrases",
                      onTap: (levelId) {
                        navigateToLevel(levelId: "1");
                      },
                    ),
                  ],
                ),
              ),
              // Second row
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    _buildCard(
                      headerText: 'A1',
                      cardText:
                          "learn common everyday expressions and simple phrases",
                      onTap: (levelId) {
                        navigateToLevel(levelId: "1");
                      },
                    ),
                    Constants.gapW10,
                    _buildCard(
                      headerText: 'A1',
                      cardText:
                          "learn common everyday expressions and simple phrases",
                      onTap: (levelId) {
                        navigateToLevel(levelId: "1");
                      },
                    ),
                  ],
                ),
              ),
              // Third row
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard(
                      headerText: 'A1',
                      cardText:
                          "learn common everyday expressions and simple phrases",
                      onTap: (levelId) {
                        navigateToLevel(levelId: "1");
                      },
                    ),
                  ],
                ),
              ),
              Constants.gapH36,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      {required String headerText,
      required String cardText,
      required Function(int) onTap}) {
    return SelectableCard(
      onPressed: () {
        onTap(1);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            headerText,
            style: TextStyles.cardHeader,
            textAlign: TextAlign.center,
          ),
          Constants.gapH20,
          Text(
            cardText,
            style: TextStyles.cardText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
