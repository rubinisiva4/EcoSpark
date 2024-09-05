// state_manager.dart
class StateManager {
  // Private constructor
  StateManager._privateConstructor();

  // Singleton instance
  static final StateManager _instance = StateManager._privateConstructor();

  // Factory constructor to return the same instance
  factory StateManager() {
    return _instance;
  }

  // List to hold bids
  final List<Map<String, dynamic>> _bids = [];

  // Getter for bids
  List<Map<String, dynamic>> get bids => _bids;

  // Method to add a new bid
  void addBid(Map<String, dynamic> bid) {
    _bids.add(bid);
  }

  // Optionally, you can add methods to clear or update bids
  void clearBids() {
    _bids.clear();
  }
}
