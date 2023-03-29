class Parking {
  final String pbtName;
  final String plateNo;
  final int duration;
  final DateTime endTime;
  final double amount;

  const Parking(
      {required this.pbtName,
      required this.plateNo,
      required this.duration,
      required this.endTime,
      required this.amount});
}
