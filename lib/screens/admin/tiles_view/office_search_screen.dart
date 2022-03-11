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
  const OfficeSearchScreen(
      {Key? key, required this.id, required this.numeBulding})
      : super(key: key);

  final String id;
  final String numeBulding;

  @override
  State<OfficeSearchScreen> createState() => _OfficeSearchScreenState();
}

class _OfficeSearchScreenState extends State<OfficeSearchScreen>
    with TickerProviderStateMixin {
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
  String selectedFree = ">";
  final List<DropdownMenuItem<String>> freeOffices = [
    const DropdownMenuItem(child: Text(">"), value: ">"),
    const DropdownMenuItem(
      child: Text("<"),
      value: "<",
    ),
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

  // Future<int> getNumberOfDesks() async{
  //   int nr = 0, nr2;
  //   var ref = await _firebaseFirestore.collection("Buildings").doc(widget.id).collection("Offices").get();
  //   ref.docs.forEach((element) async{
  //      nr2 = await int.parse(element['totalDeskCount']);
  //      nr += nr2;
  //
  //      print(nr);
  //   });
  //   return nr;
  // }

  // Future<int> getTotalDesks(AsyncSnapshot snapshot) async{
  //
  //     int nr = 0, nr2;
  //
  //     snapshot.data.docs.forEach((element) async{
  //        nr2 = await int.parse(element['totalDeskCount']);
  //        nr += nr2;
  //
  //        print(nr);
  //     });
  //     return nr;
  //
  //
  // }
  ///TODO DETALII OFFICE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Offices from ${widget.numeBulding}"),
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
                    builder: (context) => CreateOffice(id: widget.id),
                  ),
                );
              },
            )
          : null,
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldInput(
                        textEditingController: _textController,
                        hintText: "Search office",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        child: Icon(
                          Icons.filter_list,
                        ),
                        onTap: () {
                          // showDialog(
                          //     barrierDismissible: false,
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(30)),
                          //         backgroundColor: Theme.of(context).primaryColor,
                          //         title: const Center(
                          //             child: Text(
                          //           "Search filters",
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 30),
                          //         )),
                          //         actions: [
                          //           Column(
                          //             children: [
                          //               DropdownButton(
                          //                 isExpanded: true,
                          //                 focusColor: Colors.grey,
                          //                 value: selectedGender,
                          //                 items: genderItems,
                          //                 onChanged: (String? value) {
                          //                   setState(() {
                          //                     selectedGender = value!;
                          //                   });
                          //                 },
                          //               ),
                          //               DropdownButton(
                          //                 isExpanded: true,
                          //                 focusColor: Colors.grey,
                          //                 value: selectedGender,
                          //                 items: genderItems,
                          //                 onChanged: (String? value) {
                          //                   setState(() {
                          //                     selectedGender = value!;
                          //                   });
                          //                 },
                          //               ),
                          //             ],
                          //           ),
                          //           Row(
                          //             children: [
                          //               Expanded(
                          //                 child: TextButton(
                          //                   onPressed: () {
                          //                     Navigator.pop(context);
                          //                   },
                          //                   child: const Text(
                          //                     "Deactivate account",
                          //                     style: TextStyle(color: Colors.black),
                          //                   ),
                          //                   style: ButtonStyle(
                          //                     backgroundColor:
                          //                         MaterialStateProperty.resolveWith(
                          //                             (state) => Colors.white),
                          //                     shape: MaterialStateProperty.all<
                          //                         RoundedRectangleBorder>(
                          //                       RoundedRectangleBorder(
                          //                         borderRadius:
                          //                             BorderRadius.circular(18.0),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 5,
                          //               ),
                          //               Expanded(
                          //                 child: TextButton(
                          //                   onPressed: () {
                          //                     Navigator.pop(context);
                          //                   },
                          //                   child: const Text(
                          //                     "Cancel",
                          //                     style: TextStyle(color: Colors.black),
                          //                   ),
                          //                   style: ButtonStyle(
                          //                     backgroundColor:
                          //                         MaterialStateProperty.resolveWith(
                          //                             (state) => Colors.white),
                          //                     shape: MaterialStateProperty.all<
                          //                         RoundedRectangleBorder>(
                          //                       RoundedRectangleBorder(
                          //                         borderRadius:
                          //                             BorderRadius.circular(18.0),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       );)};
                        },
                      ),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: _firebaseFirestore
                        .collection('Buildings')
                        .doc(widget.id)
                        .collection("Offices")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 30),
                              child: ListView(
                                children: snapshot.data!.docs
                                    .map(
                                      (element) => OfficeListWidget(
                                        nume: element['name'],
                                        imagine: element['pictureUrl'],
                                        id: element['id'],
                                        building: widget.numeBulding,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: _firebaseFirestore
                        .collection('Buildings')
                        .doc(widget.id)
                        .collection("Offices")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Number of offices: ${snapshot.data!.docs.length}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Number of desks:",
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
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
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

  AlertDialog OfficeSearchFilters(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Theme.of(context).primaryColor,
      title: const Center(
          child: Text(
        "Search filters",
        style: TextStyle(color: Colors.white, fontSize: 30),
      )),
      actions: [
        Column(
          children: [
            Row(
              children: [
                DropdownButton(
                  isExpanded: true,
                  focusColor: Colors.grey,
                  value: selectedFree,
                  items: freeOffices,
                  onChanged: (String? value) {
                    setState(() {
                      selectedFree = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Deactivate account",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (state) => Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (state) => Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
