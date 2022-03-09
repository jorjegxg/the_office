import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_user.dart';
import 'package:the_office/widgets/user_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_office/widgets/text_field_input.dart';

class OfficeSearchScreen extends StatefulWidget {
  const OfficeSearchScreen({Key? key}) : super(key: key);

  @override
  State<OfficeSearchScreen> createState() => _OfficeSearchScreenState();
}

class _OfficeSearchScreenState extends State<OfficeSearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late TabController _tabController;

  final List<Widget> office_list = [
    UserListWidget(nume: "1gg", imagine: "imagini/office.jpeg"),
    UserListWidget(nume: "TACE", imagine: "imagini/office.jpeg"),
  ];

  final int numarSali = 30;
  final int numarBirouri = 300;
  final int birouriLibere = 100;
  final int birouriOcupate = 90;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  _handleTabChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Offices")),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              child: FaIcon(
                FontAwesomeIcons.building,
              ),
            ),
            Tab(child: Icon(Icons.info)),
          ],
        ),
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              child: const Icon(Icons.person_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateUser()),
                );
              },
            )
          : null,
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextFieldInput(
                  textEditingController: _textController,
                  hintText: "Search office",
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 30),
                  child: ListView.builder(
                    itemCount: office_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return office_list[index];
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Number of offices: $numarSali",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Number of desks: $numarBirouri",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Number of usable desks: $birouriLibere",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Number of ocupied desks: $birouriOcupate",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Total free desks: ${birouriLibere - birouriOcupate}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: const Text("Assign office"),
                        onPressed: () {
                          ///TODO assign office
                        },
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: const Text("De-assign office"),
                        onPressed: () {
                          ///TODO deassign office
                        },
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
