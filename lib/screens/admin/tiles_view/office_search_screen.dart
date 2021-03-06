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

  String valoareSearch = "";
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
  void didChangeDependencies() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: Divider.createBorderSide(context),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Building ${widget.buildingName}"),
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
                    builder: (context) => CreateOffice(buildingId: widget.idBuilding),
                  ),
                );
              },
            )
          : null,
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        ///fa hint textul sa se duca sus dupa ce e apasat
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Search office",
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        onChanged: (value){
                          setState(() {
                          valoareSearch = value;
                          });
                        },
                        onEditingComplete: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                        }
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: GestureDetector(
                    //     child: Icon(
                    //       Icons.filter_list,
                    //     ),
                    //     onTap: () {
                    //       // showDialog(
                    //       //     barrierDismissible: false,
                    //       //     context: context,
                    //       //     builder: (BuildContext context) {
                    //       //       return AlertDialog(
                    //       //         shape: RoundedRectangleBorder(
                    //       //             borderRadius: BorderRadius.circular(30)),
                    //       //         backgroundColor: Theme.of(context).primaryColor,
                    //       //         title: const Center(
                    //       //             child: Text(
                    //       //           "Search filters",
                    //       //           style: TextStyle(
                    //       //               color: Colors.white, fontSize: 30),
                    //       //         )),
                    //       //         actions: [
                    //       //           Column(
                    //       //             children: [
                    //       //               DropdownButton(
                    //       //                 isExpanded: true,
                    //       //                 focusColor: Colors.grey,
                    //       //                 value: selectedGender,
                    //       //                 items: genderItems,
                    //       //                 onChanged: (String? value) {
                    //       //                   setState(() {
                    //       //                     selectedGender = value!;
                    //       //                   });
                    //       //                 },
                    //       //               ),
                    //       //               DropdownButton(
                    //       //                 isExpanded: true,
                    //       //                 focusColor: Colors.grey,
                    //       //                 value: selectedGender,
                    //       //                 items: genderItems,
                    //       //                 onChanged: (String? value) {
                    //       //                   setState(() {
                    //       //                     selectedGender = value!;
                    //       //                   });
                    //       //                 },
                    //       //               ),
                    //       //             ],
                    //       //           ),
                    //       //           Row(
                    //       //             children: [
                    //       //               Expanded(
                    //       //                 child: TextButton(
                    //       //                   onPressed: () {
                    //       //                     Navigator.pop(context);
                    //       //                   },
                    //       //                   child: const Text(
                    //       //                     "Deactivate account",
                    //       //                     style: TextStyle(color: Colors.black),
                    //       //                   ),
                    //       //                   style: ButtonStyle(
                    //       //                     backgroundColor:
                    //       //                         MaterialStateProperty.resolveWith(
                    //       //                             (state) => Colors.white),
                    //       //                     shape: MaterialStateProperty.all<
                    //       //                         RoundedRectangleBorder>(
                    //       //                       RoundedRectangleBorder(
                    //       //                         borderRadius:
                    //       //                             BorderRadius.circular(18.0),
                    //       //                       ),
                    //       //                     ),
                    //       //                   ),
                    //       //                 ),
                    //       //               ),
                    //       //               const SizedBox(
                    //       //                 width: 5,
                    //       //               ),
                    //       //               Expanded(
                    //       //                 child: TextButton(
                    //       //                   onPressed: () {
                    //       //                     Navigator.pop(context);
                    //       //                   },
                    //       //                   child: const Text(
                    //       //                     "Cancel",
                    //       //                     style: TextStyle(color: Colors.black),
                    //       //                   ),
                    //       //                   style: ButtonStyle(
                    //       //                     backgroundColor:
                    //       //                         MaterialStateProperty.resolveWith(
                    //       //                             (state) => Colors.white),
                    //       //                     shape: MaterialStateProperty.all<
                    //       //                         RoundedRectangleBorder>(
                    //       //                       RoundedRectangleBorder(
                    //       //                         borderRadius:
                    //       //                             BorderRadius.circular(18.0),
                    //       //                       ),
                    //       //                     ),
                    //       //                   ),
                    //       //                 ),
                    //       //               ),
                    //       //             ],
                    //       //           ),
                    //       //         ],
                    //       //       );)};
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: _firebaseFirestore
                        .collection('Buildings')
                        .doc(widget.idBuilding)
                        .collection("Offices")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator(),);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: Column(
                            children: snapshot.data!.docs
                                .map(
                                  (element) {
                                    if(valoareSearch == ""){
                                      return OfficeListWidget(
                                        buildingName: widget.buildingName,
                                        idBuilding: widget.idBuilding,
                                        nume: element['name'],
                                        imagine: element['pictureUrl'],
                                        id: element['id'],
                                        building: widget.buildingName,
                                      );
                                    }else{
                                      if((element['name'] as String).toLowerCase().contains(valoareSearch.toLowerCase())){
                                        return OfficeListWidget(
                                          buildingName: widget.buildingName,
                                          idBuilding: widget.idBuilding,
                                          nume: element['name'],
                                          imagine: element['pictureUrl'],
                                          id: element['id'],
                                          building: widget.buildingName,
                                        );
                                      }else{
                                        return Container();
                                      }
                                    }
                                  }
                                )
                                .toList(),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: _firebaseFirestore
                        .collection("Buildings")
                        .doc(widget.idBuilding)
                        .collection("Offices")
                        .get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      int numberOfOffices = 0;
                      double totalNumberOfDesks = 0;
                      double numberOfUsableDesks = 0;
                      double totalNumberOfOcupiedDesks = 0;
                      double totalFreeDesks = 0;

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        numberOfOffices = snapshot.data!.docs.length;

                        snapshot.data!.docs.forEach((element) {
                          totalNumberOfDesks += element['totalDeskCount'];
                        });

                        snapshot.data!.docs.forEach((element) {
                          numberOfUsableDesks += element['usableDeskCount'];
                        });

                        snapshot.data!.docs.forEach((element) {
                          totalNumberOfOcupiedDesks +=
                              element['numberOfOccupiedDesks'];
                        });

                        snapshot.data!.docs.forEach((element) {
                          totalFreeDesks += element['usableDeskCount'] -
                              element['numberOfOccupiedDesks'];
                        });

                        return Column(
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
                              "Number of ocupied desks:  ${totalNumberOfOcupiedDesks.toInt()}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Total free desks: ${totalFreeDesks.toInt()}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }
                    }),
                
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
