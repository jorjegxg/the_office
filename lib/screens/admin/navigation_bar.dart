import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/role_provider.dart';
import 'main_screens/building_search _screen.dart';
import 'main_screens/user_search _screen.dart';
import 'main_screens/remote_requests_screen.dart';
import 'package:the_office/screens/admin/main_screens/user_profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  String _currentTab = "Page1";

  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentTab) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        tabItem: tabItem,
        navigatorKey: _navigatorKeys[tabItem]!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != "Page1") {
            _selectTab("Page1", 0);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator("Page1"),
            _buildOffstageNavigator("Page2"),
            _buildOffstageNavigator("Page3"),
            _buildOffstageNavigator("Page4"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.users),
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Buildings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_to_queue),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
        ),
      ),
    );
  }
}

class TabNavigator extends StatefulWidget {
  final String tabItem;
  final GlobalKey<NavigatorState> navigatorKey;
  const TabNavigator(
      {Key? key, required this.tabItem, required this.navigatorKey})
      : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    Widget child = const UserSearchScreen();

    switch (widget.tabItem) {
      case "Page1":
        child = const UserSearchScreen();
        break;
      case "Page2":
        child =Provider.of<RoleProvider>(context).getRole()!='Employee'? BuildingSearchScreen():;
        break;
      case "Page3":
        child = RemoteRequestScreen();
        break;
      case "Page4":
        child = UserProfile();
        break;
    }
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
