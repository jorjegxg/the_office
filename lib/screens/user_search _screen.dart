import 'package:flutter/material.dart';
import 'package:the_office/widgets/user_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserSearchScreen extends StatefulWidget {
  UserSearchScreen({Key? key}) : super(key: key);

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  int _selectedIndex = 0;
  final List<Widget> user_list = [
    UserListWidget(corp: 'corp', etaj: 1, nume: 'nume', sala: 321),
    UserListWidget(corp: 'corp', etaj: 2, nume: 'nume', sala: 321),
    UserListWidget(corp: 'corp', etaj: 3, nume: 'nume', sala: 321),
    UserListWidget(corp: 'corp', etaj: 4, nume: 'nume', sala: 321),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            print("greu");
            user_list.add(
              const UserListWidget(
                  corp: 'corp', etaj: 1, nume: 'nume', sala: 321),
            );
          });
        },
      ),
      appBar: AppBar(
        title: const Center(child: Text("Users")),
      ),
      body: Column(
        children: [
          TextField(),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 30),
              child: ListView(
                children: user_list,
              ),
            ),
          ),
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
