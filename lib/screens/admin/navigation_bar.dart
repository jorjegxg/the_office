import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_office/screens/admin/user_profile.dart';
import 'building_search _screen.dart';
import 'user_search _screen.dart';
import 'remote_requests_screen.dart';

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
        _currentTab = pageKeys[index];
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
        print("SUNt aici");
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex]!.currentState!.maybePop();
        print(isFirstRouteInCurrentTab.toString());
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

class TabNavigator extends StatelessWidget {
  final String tabItem;
  final GlobalKey<NavigatorState> navigatorKey;
  const TabNavigator(
      {Key? key, required this.tabItem, required this.navigatorKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const UserSearchScreen();

    switch (tabItem) {
      case "Page1":
        child = const UserSearchScreen();
        break;
      case "Page2":
        child = const BuildingSearchScreen();
        break;
      case "Page3":
        child = const RemoteRequestScreen();
        break;
      case "Page4":
        child = const UserProfile();
        break;
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
