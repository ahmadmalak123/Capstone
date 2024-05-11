class MedicalRecord {
  final int recordId;
  final int? petId;
  final String? description;
  final String? service;
  final List<int>? testResults; // Uint8List for image data
  final DateTime? date;
  final String? status;

  MedicalRecord({
    required this.recordId,
    this.petId,
    this.description,
    this.service,
    this.testResults,
    this.date,
    this.status,
  });

  // From JSON (deserialization)
  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      recordId: json['RecordId'] ?? 0,
      petId: json['PetId'],
      description: json['Description'],
      service: json['Service'],
      testResults: json['TestResults'] != null
          ? List<int>.from(json['TestResults'])
          : null,
      date: json['Date'] != null ? DateTime.parse(json['Date']) : null,
      status: json['Status'],
    );
  }

  // To JSON (serialization)
  Map<String, dynamic> toJson() {
    return {
      'RecordId': recordId,
      'PetId': petId,
      'Description': description,
      'Service': service,
      'TestResults': testResults,
      'Date': date?.toIso8601String(),
      'Status': status,
    };
  }
}