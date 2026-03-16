import 'package:book_app/views/app/home_view.dart';
import 'package:flutter/cupertino.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CupertinoTabController _tabController = CupertinoTabController();

    final backgroundColour = Color.fromARGB(255, 47, 48, 78);
    final activeColour = CupertinoColors.white;
    final inactiveColour = CupertinoColors.inactiveGray;

    List<BottomNavigationBarItem> _buildNavBarItems() {
      return [
        BottomNavigationBarItem(
          icon: _NavBarIcon(icon: CupertinoIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _NavBarIcon(icon: CupertinoIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: _NavBarIcon(icon: CupertinoIcons.heart),
          label: 'Favourites',
        ),
      ];
    }

    final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
      5,
      (index) => GlobalKey<NavigatorState>(),
    );

    Widget _buildTabView(int index) {
      switch (index) {
        case 0:
          return HomeView();
        /*case 1:
          return SearchView();
        case 2:
          return FavoritesView();*/
        default:
          return HomeView();
      }
    }

    void _resetTabNavigation(int index) {
      final navigator = _navigatorKeys[index].currentState;
      if (navigator != null) {
        navigator.popUntil((route) => route.isFirst);
      }
    }

    return CupertinoTabScaffold(
        controller: _tabController,
        tabBar: CupertinoTabBar(
            items: _buildNavBarItems(),
            backgroundColor: backgroundColour,
            activeColor: activeColour,
            inactiveColor: inactiveColour,
            iconSize: 28,
            height: 57,
            onTap: _resetTabNavigation),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: _navigatorKeys[index],
            builder: (context) => _buildTabView(index),
          );
        });
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;

  const _NavBarIcon({required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 2),
      child: Icon(icon),
    );
  }
}
