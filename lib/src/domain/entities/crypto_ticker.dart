import 'dart:convert';

class CryptoTicker {
  final String topic;
  final String symbol;
  final int sequence;
  final String side;
  final double price;
  final int size;
  final String tradeId;
  final int bestBidSize;
  final double bestBidPrice;
  final double bestAskPrice;
  final int bestAskSize;
  final int ts;
  CryptoTicker({
    required this.topic,
    required this.symbol,
    required this.sequence,
    required this.side,
    required this.price,
    required this.size,
    required this.tradeId,
    required this.bestBidSize,
    required this.bestBidPrice,
    required this.bestAskPrice,
    required this.bestAskSize,
    required this.ts,
  });

  CryptoTicker copyWith({
    String? topic,
    String? symbol,
    int? sequence,
    String? side,
    double? price,
    int? size,
    String? tradeId,
    int? bestBidSize,
    double? bestBidPrice,
    double? bestAskPrice,
    int? bestAskSize,
    int? ts,
  }) {
    return CryptoTicker(
      topic: topic ?? this.topic,
      symbol: symbol ?? this.symbol,
      sequence: sequence ?? this.sequence,
      side: side ?? this.side,
      price: price ?? this.price,
      size: size ?? this.size,
      tradeId: tradeId ?? this.tradeId,
      bestBidSize: bestBidSize ?? this.bestBidSize,
      bestBidPrice: bestBidPrice ?? this.bestBidPrice,
      bestAskPrice: bestAskPrice ?? this.bestAskPrice,
      bestAskSize: bestAskSize ?? this.bestAskSize,
      ts: ts ?? this.ts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topic': topic,
      'symbol': symbol,
      'sequence': sequence,
      'side': side,
      'price': price,
      'size': size,
      'tradeId': tradeId,
      'bestBidSize': bestBidSize,
      'bestBidPrice': bestBidPrice,
      'bestAskPrice': bestAskPrice,
      'bestAskSize': bestAskSize,
      'ts': ts,
    };
  }

  factory CryptoTicker.fromMap(Map<String, dynamic> map) {
    return CryptoTicker(
      topic: map['topic'] as String,
      symbol: map['data']['symbol'] as String,
      sequence: map['data']['sequence'] as int,
      side: map['data']['side'] as String,
      price: map['data']['price'] as double,
      size: map['data']['size'] as int,
      tradeId: map['data']['tradeId'] as String,
      bestBidSize: map['data']['bestBidSize'] as int,
      bestBidPrice: map['data']['bestBidPrice'] as double,
      bestAskPrice: map['data']['bestAskPrice'] as double,
      bestAskSize: map['data']['bestAskSize'] as int,
      ts: map['data']['ts'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoTicker.fromJson(String source) =>
      CryptoTicker.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CryptoTicker(topic: $topic, symbol: $symbol, sequence: $sequence, side: $side, price: $price, size: $size, tradeId: $tradeId, bestBidSize: $bestBidSize, bestBidPrice: $bestBidPrice, bestAskPrice: $bestAskPrice, bestAskSize: $bestAskSize, ts: $ts)';
  }

  @override
  bool operator ==(covariant CryptoTicker other) {
    if (identical(this, other)) return true;

    return other.topic == topic &&
        other.symbol == symbol &&
        other.sequence == sequence &&
        other.side == side &&
        other.price == price &&
        other.size == size &&
        other.tradeId == tradeId &&
        other.bestBidSize == bestBidSize &&
        other.bestBidPrice == bestBidPrice &&
        other.bestAskPrice == bestAskPrice &&
        other.bestAskSize == bestAskSize &&
        other.ts == ts;
  }

  @override
  int get hashCode {
    return topic.hashCode ^
        symbol.hashCode ^
        sequence.hashCode ^
        side.hashCode ^
        price.hashCode ^
        size.hashCode ^
        tradeId.hashCode ^
        bestBidSize.hashCode ^
        bestBidPrice.hashCode ^
        bestAskPrice.hashCode ^
        bestAskSize.hashCode ^
        ts.hashCode;
  }
}