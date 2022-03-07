import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreFunctions{

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  Future<String> createBuilding({
  required String buildingName,
  required String floorsCount,
  required String buildingAddress
  }) async{
    String statusMessage = 'Some error occured';
    try{
      
      var reff = await _firebaseFirestore.collection('buildings').doc().set({
        'buildingName' : buildingName,
        'floorsCount' : floorsCount,
        'buildingAddress' : buildingAddress,
      });
      statusMessage = 'success';
      
      
    }catch(e){
      statusMessage = e.toString();
    };
    

    return statusMessage;
  }

}