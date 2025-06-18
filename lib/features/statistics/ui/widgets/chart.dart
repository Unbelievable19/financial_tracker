import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/features/statistics/domain/chart_segment.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide ChartSegment;

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.segments,
    required this.totalValue,
    required this.isIncome,
  });
  final List<ChartSegment> segments;
  final int totalValue;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sizeScreen.width * 0.5,
      height: context.sizeScreen.width * 0.5,
      child: SfCircularChart(
        margin: const EdgeInsets.all(0),
        series: [
          DoughnutSeries<ChartSegment, String>(
            xValueMapper: (_, _) => "",
            yValueMapper:
                (segment, _) =>
                    totalValue != 0 ? (segment.valueKopecks / totalValue) : 0,
            pointColorMapper:
                (segment, _) => segment.color ?? context.theme.cardColor,
            dataSource: segments,
            radius: '90%',
            innerRadius: "80%",
            animationDuration: 500,
          ),
        ],
        annotations: [
          CircularChartAnnotation(
            widget: Icon(
              isIncome ? Icons.download : Icons.upload,
              size: context.sizeScreen.width * 0.17,
              color:
                  isIncome
                      ? context.colors.incomeGradient.colors.first
                      : context.colors.expenseGradient.colors.first,
            ),
          ),
        ],
      ),
    );
  }
}
