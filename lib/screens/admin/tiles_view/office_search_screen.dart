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
      {Key? key, required this.idBuilding, required this.buildingName})
      : super(key: key);

  final String idBuilding;
  final String buildingName;

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
        centerTitle: true,
        title: Text("Offices from ${widget.buildingName}"),
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
                    builder: (context) => CreateOffice(id: widget.idBuilding),
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
                        .doc(widget.idBuilding)
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
                                        buildingName: widget.buildingName,
                                        idBuilding: widget.idBuilding,
                                        nume: element['name'],
                                        imagine: element['pictureUrl'],
                                        id: element['id'],
                                        building: widget.buildingName,
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
                FutureBuilder(
                    future: _firebaseFirestore
                        .collection("Buildings")
                        .doc(widget.idBuilding)
                        .collection("Offices")
                        .get(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      int numberOfOffices = 0;
                      double totalNumberOfDesks = 0;
                      double numberOfUsableDesks = 0;
                      double totalNumberOfOcupiedDesks = 0;
                      double totalFreeDesks = 0;
                      if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData) {

                          numberOfOffices = snapshot.data!.docs.length;

                          snapshot.data!.docs.forEach((element) {
                            totalNumberOfDesks +=
                            element['totalDeskCount'];
                          });

                          snapshot.data!.docs.forEach((element) {
                            numberOfUsableDesks +=
                            element['usableDeskCount'];
                          });


                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Number of offices: ${numberOfOffices}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                                Text(
                                'Number of desks : ${totalNumberOfDesks.toInt()}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Number of usable desks: ${numberOfUsableDesks.toInt()}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Number of ocupied desks: REZOLVAAAAAAA",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Total free desks: birouriLibere - birouriOcupate REZOLVAAAAAAA",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );

                        } else if (snapshot.hasError) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            child: Center(
                              child: Text("Eroare"),
                            ),
                          );
                        }
                      }
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
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
