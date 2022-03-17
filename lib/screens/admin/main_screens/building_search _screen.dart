import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_building.dart';
import 'package:the_office/widgets/tiles/building_list_widget.dart';
import 'package:the_office/widgets/text_field_input.dart';

class BuildingSearchScreen extends StatefulWidget {
  @override
  State<BuildingSearchScreen> createState() => _BuildingSearchScreenState();
}

class _BuildingSearchScreenState extends State<BuildingSearchScreen> {
  String valoareSearch = "";
  final TextEditingController _textController = TextEditingController();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: Divider.createBorderSide(context),
    );

    return Scaffold(
      appBar: AppBar(
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
         title: const Center(child: Text("Buildings")),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnBuilding",
        child: const Icon(Icons.domain_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreateBuilding()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left : 10,right: 10,top: 20),
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
                      hintText: "Search building",
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
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore.collection('Buildings').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        if(valoareSearch == ""){
                          return BuildingListWidget(
                            nume: doc['name'],
                            imagine: doc['pictureUrl'],
                            adress: doc['buildingAdress'],
                            id: doc['id'],
                          );
                        }else{
                          if((doc['name'] as String).toLowerCase().contains(valoareSearch.toLowerCase())){
                            return BuildingListWidget(
                              nume: doc['name'],
                              imagine: doc['pictureUrl'],
                              adress: doc['buildingAdress'],
                              id: doc['id'],
                            );
                          }else{
                            return Container();
                          }
                        }

                      }).toList(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
