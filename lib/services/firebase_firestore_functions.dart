import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_office/models/building_model.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class FirebaseFirestoreFunctions {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> createBuilding(
      {required String buildingName,
      required String floorsCount,
      required String buildingAddress}) async {
    String statusMessage = 'Some error occured';
    try {
      String uuid = Uuid().v1();
      BuildingModel _building = BuildingModel(
          name: buildingName,
          floorsCount: floorsCount,
          buildingAdress: buildingAddress,
          id: uuid
      );

      var reff = await _firebaseFirestore
          .collection('buildings')
          .doc(uuid)
          .set(_building.toJson());
      statusMessage = 'success';
    } catch (e) {
      statusMessage = e.toString();
    }
    ;

    return statusMessage;
  }
}
