import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_office/models/building_model.dart';
import 'package:the_office/models/office_model.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class FirebaseFirestoreFunctions {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> createBuilding(
      {required String buildingName,
      required int floorsCount,
      required String buildingAddress}) async {
    String statusMessage = 'Some error occured';
    if (buildingName.isNotEmpty &&
        floorsCount != "" &&
        buildingAddress.isNotEmpty) {
      try {
        String uuid = Uuid().v1();
        BuildingModel _building = BuildingModel(
            name: buildingName,
            floorsCount: floorsCount,
            buildingAdress: buildingAddress,
            id: uuid);

        var reff = await _firebaseFirestore
            .collection('Buildings')
            .doc(uuid)
            .set(_building.toJson());
        statusMessage = 'success';
      } catch (e) {
        statusMessage = e.toString();
      }
    } else {
      statusMessage = "Please enter all the fields";
    }

    return statusMessage;
  }

  Future<String> createOffice({
    required String name,
    required int floorNumber,
    required int totalDeskCount,
    required int usableDeskCount,
    required String idAdmin,
    required String idBuilding,
  }) async {
    String statusMessage = 'Some error occured';
    try {
      if (name.isNotEmpty &&
          floorNumber != -1 &&
          totalDeskCount != -1 &&
          usableDeskCount != -1 &&
          idAdmin.isNotEmpty) {

        if (totalDeskCount < usableDeskCount)
          return 'Total desk count can\'t be less than total desk count';

          

        String uuid = Uuid().v1();

        OfficeModel _office = OfficeModel(
          name: name,
          floorNumber: floorNumber,
          totalDeskCount: totalDeskCount,
          usableDeskCount: usableDeskCount,
          id: uuid,
          idAdmin: idAdmin,
          idBuilding: idBuilding,
          numberOfOccupiedDesks: 0,
          usersId: []
        );

        var reff = await _firebaseFirestore
            .collection('Buildings')
            .doc(idBuilding)
            .collection('Offices')
            .doc(uuid)
            .set(_office.toJson());

        statusMessage = 'success';
      } else {
        statusMessage = "Please enter all the fields";
      }
    } catch (e) {
      statusMessage = e.toString();
    }

    return statusMessage;
  }

Future<String> updateOffice({
    required String name,
    required int floorNumber,
    required int totalDeskCount,
    required int usableDeskCount,
    required String idAdmin,
    required String idBuilding,
    required String idOffice,
    required int occupiedDeskCount,
  }) async {
    String statusMessage = 'Some error occured';
    try {
      if (name.isNotEmpty &&
          floorNumber != -1 &&
          totalDeskCount != -1 &&
          usableDeskCount != -1 &&
          occupiedDeskCount != -1) {


        if (totalDeskCount < usableDeskCount)
          return 'Total desk count can\'t be less than total desk count';

         if (occupiedDeskCount > usableDeskCount)
          return 'Number of usable desks count can\'t be less than the number of occupied desks (${occupiedDeskCount})';  

      
          Map<String,dynamic> officeMap = {
          'name': name,
          'floorNumber': floorNumber,
          'totalDeskCount': totalDeskCount,
          'usableDeskCount': usableDeskCount,
          'id': idOffice,
          'idAdmin': idAdmin,
          'idBuilding': idBuilding,
         };

        var reff = await _firebaseFirestore
            .collection('Buildings')
            .doc(idBuilding)
            .collection('Offices')
            .doc(idOffice)
            .update(officeMap);

        statusMessage = 'success';
      } else {
        statusMessage = "Please enter all the fields";
      }
    } catch (e) {
      statusMessage = e.toString();
    }

    return statusMessage;
  }
  
}
