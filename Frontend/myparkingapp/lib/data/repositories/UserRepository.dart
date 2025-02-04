// ignore_for_file: avoid_print, non_constant_identifier_names, file_names



import 'dart:convert';

import 'package:myparkingapp/data/models/User.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  
  /// Lấy danh sách các giao dịch dựa trên `userID`


Future<User?> getUserByID(String userID, String bearerToken) async {
  final String apiUrl = 'http://10.0.2.2:8080/myparkingapp/users/$userID';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $bearerToken',  // Thêm token vào header
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      // Lấy dữ liệu từ "result"
      if (responseData.containsKey("result")) {
        return User.fromJson(responseData["result"]);
      } else {
        print("Error: 'result' key not found in response.");
        return null;
      }
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      return null;
    }
  } catch (e) {
    print('Exception occurred: $e');
    return null;
  }
}
  // Future<List<User>> getUserByUserName(String userName) async {
  //   try {
  //     final allUser = await getAllUser();
  //     // Lọc các ParkingSpotModel chứa chuỗi tìm kiếm
  //     final filteredUser = allUser
  //         .where((user) => user.username.toLowerCase().contains(userName.toLowerCase()))
  //         .toList();
  //     print('Filtered spots: $filteredUser');
  //     return filteredUser;

  //   } catch (e) {
  //     print('Users does not exist.');
  //     print(e);
  //     return [];
  //   }
  // }

  // Future<List<UserModel>> getUserBySpotID(String spotID) async {
  //   try {
  //     List<ParkingSpotModel> spots = await ParkingSpotRepository().getAllParkingSpotsBySearchSpotId(spotID);
  //     String SpotName = spots[0].spotName;
  //     List<TransactionModel> transaction = await TransactionRepository().getAllTransactions();
  //     List<String> userUsedSpotName = transaction
  //         .where((tran) => tran.spotName.toLowerCase().contains(SpotName.toLowerCase()))
  //         .map((tran) =>tran.userID).toList();

  //     // Lọc các ParkingSpotModel chứa chuỗi tìm kiếm
  //     final List<UserModel> ListUser = [];
  //     for(int i=0;i<userUsedSpotName.length;i++){
  //       UserModel? userModel = await getUserByID(userUsedSpotName[i]);
  //       ListUser.add(userModel!);
  //     }
  //     print('Filtered spots: $ListUser');
  //     Set<String> seenIds = {}; // Set để lưu trữ ID đã thấy
  //     List<UserModel> uniqueList = ListUser.where((user) {
  //       final isNew = !seenIds.contains(user.userID);
  //       if (isNew) {
  //         seenIds.add(user.userID);
  //       }
  //       return isNew;
  //     }).toList();
  //     return uniqueList;

  //   } catch (e) {
  //     print(e);
  //     print('Users does not exist.');
  //     return [];
  //   }
  // }

  // Future<List<UserModel>> getAllUser() async {
  //   try {
  //     print('requered');
  //     QuerySnapshot querySnapshot = await _firestore
  //         .collection('users') // Tên collection trong Firestore
  //         .get();
  //     print(querySnapshot.docs);

  //     // Chuyển đổi danh sách `QueryDocumentSnapshot` thành danh sách `TransactionModel`
  //     List<UserModel> user = querySnapshot.docs
  //         .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
  //         .toList();
  //     print(user);

  //     return user;
  //   } catch (e) {
  //     print('User does not exist.');
  //     print(e);
  //     return [];
  //   }
  // }

  // Future<void> updateUserByID( String userID, String userName, String email, String phone, String userImg, String country, String userAddress, String vehicle,) async {
  //   try {
  //     DocumentReference docRef =
  //     FirebaseFirestore.instance.collection('users').doc(userID);
  //     Map<String, dynamic> updatedData = {
  //       'username': userName,
  //       'email': email,
  //       'phone': phone,
  //       'userImg': userImg,
  //       'country': country,
  //       'userAddress': userAddress,
  //       'vehicle': vehicle,
  //     };
  //     // Cập nhật tài liệu Firestore
  //     await docRef.update(updatedData);
  //   } catch (e) {
  //     print('Lỗi khi cập nhật thông tin người dùng: $e');
  //   }

  // }

  // Future<void> updateStateUserByUsername(String username, bool isActive) async {
  //   try {
  //     print("Tìm kiếm người dùng với username: $username");

  //     // Truy vấn tài liệu có username trùng khớp
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('username', isEqualTo: username)
  //         .get();

  //     // Kiểm tra nếu tài liệu tồn tại
  //     if (querySnapshot.docs.isNotEmpty) {
  //       for (var doc in querySnapshot.docs) {
  //         String userID = doc.id; // Lấy documentID
  //         print("UserID tìm thấy: $userID");

  //         // Tham chiếu tài liệu và cập nhật
  //         await FirebaseFirestore.instance.collection('users').doc(userID).update({
  //           'isActive': isActive,
  //         });

  //         print("Trạng thái isActive của người dùng '$username' đã được cập nhật thành $isActive");
  //       }
  //     } else {
  //       print("Không tìm thấy người dùng với username: $username");
  //     }
  //   } catch (e) {
  //     print('Lỗi khi cập nhật trạng thái người dùng: $e');
  //   }
  // }

}
