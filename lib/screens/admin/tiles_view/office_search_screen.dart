import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_office.dart';
import 'package:the_office/screens/admin/create_screens/create_user.dart';
import 'package:the_office/widgets/tiles/office_list_widget.dart';
import 'package:the_office/widgets/tiles/user_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_office/widgets/text_field_input.dart';

import '../../../widgets/tiles/building_list_widget.dart';

class OfficeSearchScreen extends StatefulWidget {
  const OfficeSearchScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<OfficeSearchScreen> createState() => _OfficeSearchScreenState();
}

class _OfficeSearchScreenState extends State<OfficeSearchScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController _textController = TextEditingController();
  late TabController _tabController;

  // ListView(
  // children: snapshot.data!.docs.map((doc) {
  // return UserListWidget(
  // nume: '${doc['name']} ${doc['lastName']}',
  // imagine: doc['pictureUrl'],
  // rol: doc['role'],
  // id: doc['id'],
  // );
  // }).toList(),
  // ),

  final int numarSali = 30;
  final int numarBirouri = 300;
  final int birouriLibere = 100;
  final int birouriOcupate = 90;

  @override
  void initState() {
    print(widget.id);
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
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.collection('Buildings').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("Offices"),
                  bottom: TabBar(
                    indicatorColor: Colors.white,
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
                        child: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateOffice(),
                            ),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: TextFieldInput(
                            textEditingController: _textController,
                            hintText: "Search office",
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 30),
                            child: ListView(
                              children: [
                                OfficeListWidget(nume: "nume", imagine: "https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/istockphoto-1177487069-612x612.jpg?alt=media&token=dd5bdcae-ca21-4dd3-81fc-8ffe90dfe2c8",id: 'id', building: 'building'),
                                OfficeListWidget(nume: "nume", imagine: "https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/istockphoto-1177487069-612x612.jpg?alt=media&token=dd5bdcae-ca21-4dd3-81fc-8ffe90dfe2c8",id: 'id', building: 'building'),
                                OfficeListWidget(nume: "nume", imagine: "https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/istockphoto-1177487069-612x612.jpg?alt=media&token=dd5bdcae-ca21-4dd3-81fc-8ffe90dfe2c8",id: 'id', building: 'building'),
                               ///TODO Fa un widget tile pentru office
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
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
            } else if (snapshot.hasError) {
              return Text("Error");
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Text("Sigur ai net?");
        });
  }
}
