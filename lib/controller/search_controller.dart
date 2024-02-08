import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SearchGetController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> searchResults = <DocumentSnapshot>[].obs;
    

  void search(String query) async {
    if (query.isNotEmpty) {
      try {
        final snapshot = await _firestore
            .collection('approvedOne')
            .where('itemName', isGreaterThanOrEqualTo: query.toLowerCase())
            .where('itemName', isLessThan: query.toLowerCase() + 'z')
            .get();
        searchResults.assignAll(snapshot.docs);
      } catch (e) {
        print('Error searching: $e');
        searchResults.clear();
      }
    } else {
      searchResults.clear();
    }
  }
}
