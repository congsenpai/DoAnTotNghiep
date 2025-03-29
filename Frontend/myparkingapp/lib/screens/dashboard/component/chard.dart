import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';

class DailyTotals {
  int number;
  double budget;
  String times;
  DailyTotals(this.number, this.budget, this.times);
}

class BarChartWidget extends StatelessWidget {
  final List<TransactionResponse> data;
  final bool type;

  const BarChartWidget({super.key, required this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    Map<int, DailyTotals> dailyMap = {}; // Lưu tổng tiền theo ngày

    for (var transaction in data) {
      int dayKey = transaction.createAt.year * 10000 + 
                   transaction.createAt.month * 100 + 
                   transaction.createAt.day;
      double budget = transaction.currentBalance;
      String time = "${transaction.createAt.day}/${transaction.createAt.month}";

      if (dailyMap.containsKey(dayKey)) {
        dailyMap[dayKey]!.budget += budget; // Cộng dồn budget nếu trùng ngày
      } else {
        dailyMap[dayKey] = DailyTotals(dayKey, budget, time);
      }
    }

    List<DailyTotals> timedata = dailyMap.values.toList()..sort((a, b) => a.number.compareTo(b.number));

    List<BarChartGroupData> barGroups = timedata.map((e) {
      return BarChartGroupData(
        x: e.number, // Sử dụng ngày làm trục X
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: e.budget,
            color: type ? Colors.amber : Colors.red,
            width: 10,
            borderRadius: BorderRadius.circular(4),
          )
        ],
      );
    }).toList();

    return BarChart(
            BarChartData(
              barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
            tooltipPadding: EdgeInsets.all(8), // Thêm padding
            tooltipRoundedRadius: 8, // Bo góc cho tooltip
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                ' ${AppLocalizations.of(context).translate("budget")} : ${rod.toY.toInt()} VNĐ', // Giá trị hiển thị
                const TextStyle(
                  color: Colors.white, // Màu chữ
                  fontSize: 14, // Kích thước chữ
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                String item = timedata.firstWhere((e) => e.number == value.toInt()).times;
                return Text(item, style: const TextStyle(color: Colors.white, fontSize: 10));
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
      ),
    );
  }
}
