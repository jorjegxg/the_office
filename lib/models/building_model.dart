class BuildingModel {
  BuildingModel({
    required this.name,
    required this.floorsCount,
    required this.buildingAdress,
    this.pictureUrl = "https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/default_building.jpg?alt=media&token=59cfa57f-7b88-4363-abfc-2e526bdd17b3",
    required this.id,
  });

  String name;
  int floorsCount;
  String buildingAdress;
  String pictureUrl;
  String id;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'floorsCount': floorsCount,
      'buildingAdress': buildingAdress,
      'pictureUrl': pictureUrl,
      'id' : id,
    };
  }
}
