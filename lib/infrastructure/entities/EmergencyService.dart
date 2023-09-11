
class EmergencyService {

  late String emergencyServiceId;
  late String name;
  late String cityName;
  late String departmentName;
  late String countryName;
  late bool deleted;

  EmergencyService({
    required this.emergencyServiceId,
    required this.name,
    required this.cityName,
    required this.departmentName,
    required this.countryName,
    required this.deleted,
  });

  factory EmergencyService.fromJson(Map<String, dynamic> json) {
    return EmergencyService(
      emergencyServiceId: json['emergencyServiceId'],
      name: json['name'],
      cityName: json['cityName'],
      countryName: json['countryName'],
      departmentName: json['departmentName'],
      deleted: json['deleted'],
    );
  }
}
