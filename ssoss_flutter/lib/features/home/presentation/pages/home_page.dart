import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/home/presentation/widgets/home_tab_pages.dart';

/// 로그인 성공 후 진입하는 메인 셸 화면. 하단 네비게이션으로 탭을 전환한다.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = 'home';
  static const String routePath = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SsossNavigationItem _currentItem = SsossNavigationItem.contentCreation;

  static const List<Widget> _tabs = [
    ContentCreationTab(),
    DashboardTab(),
    PlaceDiagnosisTab(),
    MyPageTab(),
  ];

  static final List<HomeTabAppBarBuilder> _appBarBuilders = [
    ContentCreationTab.buildAppBar,
    DashboardTab.buildAppBar,
    PlaceDiagnosisTab.buildAppBar,
    MyPageTab.buildAppBar,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: IndexedStack(
              index: _currentItem.index,
              sizing: StackFit.passthrough,
              children: List.generate(
                _appBarBuilders.length,
                (index) => _appBarBuilders[index](context),
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentItem.index,
              children: _tabs,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SsossNavigationBar(
        currentItem: _currentItem,
        onItemSelected: (item) {
          setState(() => _currentItem = item);
        },
      ),
    );
  }
}
