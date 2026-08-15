import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';

enum ContentManagementSection {
  generated,
  templates,
}

class HomeRouteExtra {
  const HomeRouteExtra({
    this.tab = SsossNavigationItem.contentCreation,
    this.managementSection = ContentManagementSection.generated,
  });

  final SsossNavigationItem tab;
  final ContentManagementSection managementSection;
}
