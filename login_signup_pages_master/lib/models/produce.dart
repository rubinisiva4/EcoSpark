// // lib/models/produce.dart

class Produce {
  final String name;
  final String variety;
  final String harvestDate;
  final int quantity;
  final int biddingPrice;
  final int pricePerUnit;
  double currentBid; // Track the latest bid
  String unit; // Add unit for the quantity

  Produce({
    required this.name,
    required this.variety,
    required this.harvestDate,
    required this.quantity,
    required this.biddingPrice,
    required this.pricePerUnit,
    this.currentBid = 0.0, // Initialize currentBid
    required this.unit, // Add unit
  });
}
