import 'dart:async';
import 'dart:math';

import '../models/data_model.dart';

class PriceService {
  final StreamController<CandlestickData> _controller =
      StreamController<CandlestickData>();

  Stream<CandlestickData> get priceStream => _controller.stream;
  List<CandlestickData> chartData = [];
  void startFetching() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final randomOpen = Random().nextDouble() * 100;
      final randomHigh = randomOpen + Random().nextDouble() * 10;
      final randomLow = randomOpen - Random().nextDouble() * 10;
      final randomClose =
          randomLow + Random().nextDouble() * (randomHigh - randomLow);

      final candlestickData = CandlestickData(
        open: randomOpen,
        high: randomHigh,
        low: randomLow,
        close: randomClose,
        timestamp: DateTime.now(),
      );

      _controller.add(candlestickData);
    });
  }

  // List<CandlestickData> fetchData() {
  //   // dev.log("data $data");
  //   // return data;
  // }

  void dispose() {
    _controller.close();
  }
}
