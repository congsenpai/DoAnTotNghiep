

import 'package:myparkingapp/data/response/discount_response.dart';

List<String> bannerHomeScreen = [
  "assets/images/big_1.png",
  "assets/images/big_2.png",
  "assets/images/big_3.png",
  "assets/images/big_4.png",
];

List<Map<String, dynamic>> demoMediumCardData = [
  {
    "name": "Daylight Coffee",
    "image": "assets/images/medium_1.png",
    "location": "Colarodo, San Francisco",
    "rating": 4.6,
    "delivertTime": 25,
  },
  {
    "name": "Mario Italiano",
    "image": "assets/images/medium_2.png",
    "location": "Colarodo, San Francisco",
    "rating": 4.3,
    "delivertTime": 30,
  },
  {
    "name": "McDonald’s",
    "image": "assets/images/medium_3.png",
    "location": "Colarodo, San Francisco",
    "rating": 4.8,
    "delivertTime": 25,
  },
  {
    "name": "The Halal Guys",
    "image": "assets/images/medium_4.png",
    "location": "Colarodo, San Francisco",
    "rating": 4.6,
    "delivertTime": 25,
  },
];

DiscountResponse emptyDiscount = DiscountResponse(
    discountId: "",
    discountCode: "",
    discountType: DiscountType.FIXED,
    discountValue: 0,
    description: "",
    parkingLotId: '', expiredAt: '');
List<Map<int, String>> month = [
  {1: "January"},
  {2: "February"},
  {3: "March"},
  {4: "April"},
  {5: "May"},
  {6: "June"},
  {7: "July"},
  {8: "August"},
  {9: "September"},
  {10: "October"},
  {11: "November"},
  {12: "December"},
];


class MonthInfo {
  String monthName;
  DateTime start;
  DateTime end;

  MonthInfo(this.monthName, this.start, this.end);

  /// Method để tạo danh sách các tháng còn lại trong năm từ thời điểm startDatetime
  static Future<List<MonthInfo>> renderMonthList(DateTime startDatetime) async {
    List<MonthInfo> months = [];
    int startMonth = startDatetime.month;
    int year = startDatetime.year;

    for (int i = startMonth; i <= 12; i++) {
      // Ngày bắt đầu tháng
      DateTime monthStart = DateTime(year, i, 1);
      // Ngày kết thúc tháng: ngày 0 của tháng tiếp theo
      DateTime monthEnd = DateTime(year, i + 1, 0);

      // Lấy tên tháng
      String monthName = month.firstWhere(
            (element) => element.containsKey(i),
        orElse: () => {0: "Unknown"},
      )[i]!;

      months.add(MonthInfo(monthName, monthStart, monthEnd));
    }

    return months;
  }

  @override
  String toString() => '$monthName: ${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}';
}