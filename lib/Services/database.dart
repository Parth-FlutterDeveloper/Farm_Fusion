import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {

  Future<void> addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future<void> addFarmDetails(Map<String, dynamic> farmInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("farms")
        .doc(id)
        .set(farmInfoMap);
  }

  Future<void> updateFarmDetails(Map<String, dynamic> farmInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("farms")
        .doc(id)
        .update(farmInfoMap);
  }

  Future<void> deleteFarm(String id) async {
    return await FirebaseFirestore.instance
        .collection("farms")
        .doc(id)
        .delete();
  }

}
