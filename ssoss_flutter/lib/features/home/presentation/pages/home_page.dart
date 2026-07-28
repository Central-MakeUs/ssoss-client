import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/home/presentation/widgets/home_tab_pages.dart';

/// 로그인 성공 후 진입하는 메인 셸 화면. 하단 네비게이션으로 탭을 전환한다.
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.initialTab = SsossNavigationItem.contentCreation,
  });

  static const String routeName = 'home';
  static const String routePath = '/home';

  final SsossNavigationItem initialTab;

  /// 이미 홈 셸 안에 있을 때 탭만 전환한다. 없으면 false.
  static bool selectTab(BuildContext context, SsossNavigationItem tab) {
    final scope = HomeTabScope.maybeOf(context, listen: false);
    if (scope == null) {
      return false;
    }
    scope.selectTab(tab);
    return true;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SsossNavigationItem _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.initialTab;
  }

  void _selectTab(SsossNavigationItem item) {
    if (_currentItem == item) {
      return;
    }
    setState(() => _currentItem = item);
  }

  @override
  Widget build(BuildContext context) {
    return HomeTabScope(
      currentTab: _currentItem,
      selectTab: _selectTab,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            if (_currentItem != SsossNavigationItem.myPage)
              SafeArea(
                bottom: false,
                child: IndexedStack(
                  index: _currentItem.index,
                  sizing: StackFit.passthrough,
                  children: _buildAppBars(context),
                ),
              ),
            Expanded(
              child: IndexedStack(
                index: _currentItem.index,
                children: _buildTabs(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SsossNavigationBar(
          currentItem: _currentItem,
          onItemSelected: _selectTab,
        ),
      ),
    );
  }

  List<Widget> _buildAppBars(BuildContext context) {
    return [
      ContentCreationTab.buildAppBar(context),
      DashboardTab.buildAppBar(context),
      PlaceDiagnosisTab.buildAppBar(context),
      MyPageTab.buildAppBar(context),
    ];
  }

  List<Widget> _buildTabs() {
    return [
      ContentCreationTab(
        isActive: _currentItem == SsossNavigationItem.contentCreation,
      ),
      DashboardTab(
        isActive: _currentItem == SsossNavigationItem.dashboard,
      ),
      const PlaceDiagnosisTab(),
      const MyPageTab(),
    ];
  }
}

/// 홈 셸의 탭 전환 API.
class HomeTabScope extends InheritedWidget {
  const HomeTabScope({
    required this.currentTab,
    required this.selectTab,
    required super.child,
    super.key,
  });

  final SsossNavigationItem currentTab;
  final ValueChanged<SsossNavigationItem> selectTab;

  static HomeTabScope? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<HomeTabScope>();
    }
    return context.getInheritedWidgetOfExactType<HomeTabScope>();
  }

  @override
  bool updateShouldNotify(HomeTabScope oldWidget) {
    return currentTab != oldWidget.currentTab;
  }
}
