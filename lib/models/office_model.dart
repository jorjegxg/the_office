class OfficeModel {
  final String name;
  final int floorNumber;
  final int totalDeskCount;
  final int usableDeskCount;
  final String id;
  final String pictureUrl;
  final String idAdmin;
  final String idBuilding;

  OfficeModel({
    required this.name,
    required this.floorNumber,
    required this.totalDeskCount,
    required this.usableDeskCount,
    required this.id,
    this.pictureUrl = 'https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/istockphoto-1177487069-612x612.jpg?alt=media&token=dd5bdcae-ca21-4dd3-81fc-8ffe90dfe2c8',
    required this.idAdmin,
    required this.idBuilding
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'floorsCount': floorNumber,
      'totalDeskCount': totalDeskCount,
      'usableDeskCount': usableDeskCount,
      'id': id,
      'pictureUrl': pictureUrl,
      'idAdmin': idAdmin,
      'idBuilding' : idBuilding
    };
  }
}
