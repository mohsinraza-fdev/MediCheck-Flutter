class Appointment {
  final String id;
  final String fromId;
  final String fromName;
  final String toId;
  final String toName;
  final String toSpecializations;
  final DateTime dateTime;
  final String status;

  Appointment({
    required this.id,
    required this.fromId,
    required this.fromName,
    required this.toId,
    required this.toName,
    required this.toSpecializations,
    required this.dateTime,
    required this.status,
  });

  bool isExpired() {
    if (dateTime.isAfter(DateTime.now())) {
      return false;
    } else {
      return true;
    }
  }
}
