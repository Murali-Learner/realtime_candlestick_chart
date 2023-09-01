import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realtime_pie/models/data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../services/price_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PriceService _priceService = PriceService();
  late TrackballBehavior _trackballBehavior;
  List<CandlestickData> chartData = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    _priceService.startFetching();
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
  }

  @override
  void dispose() {
    _priceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Candlestick Chart'),
      ),
      body: StreamBuilder<CandlestickData>(
        stream: _priceService.priceStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            chartData.add(snapshot.data!);
            return SfCartesianChart(
              title: ChartTitle(text: 'Candlestick Chart'),
              trackballBehavior: _trackballBehavior,
              series: <CandleSeries>[
                CandleSeries<CandlestickData, DateTime>(
                    dataSource: chartData,
                    xValueMapper: (CandlestickData sales, _) => sales.timestamp,
                    lowValueMapper: (CandlestickData sales, _) => sales.low,
                    highValueMapper: (CandlestickData sales, _) => sales.high,
                    openValueMapper: (CandlestickData sales, _) => sales.open,
                    closeValueMapper: (CandlestickData sales, _) => sales.close)
              ],
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.yMd(),
              ),
              primaryYAxis: NumericAxis(
                minimum: 70,
                maximum: 130,
                interval: 10,
                numberFormat:
                    NumberFormat.compactSimpleCurrency(decimalDigits: 0),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
