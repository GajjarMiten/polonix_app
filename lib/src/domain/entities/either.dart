class Either<L, R> {
  final L? left;
  final R? right;

  Either(this.left, this.right);

  bool get isLeft => left != null;
  bool get isRight => right != null;

  Either<L, R> leftValue(L value) => Either(value, null);
  Either<L, R> rightValue(R value) => Either(null, value);

  factory Either.left(L value) => Either(value, null);
  factory Either.right(R value) => Either(null, value);

  L get leftValueOrNull => left!;
  R get rightValueOrNull => right!;

  void fold(Function(L) leftFunction, Function(R) rightFunction) {
    if (isLeft) {
      leftFunction(leftValueOrNull);
    } else {
      rightFunction(rightValueOrNull);
    }
  }

  @override
  String toString() {
    return 'Either{left: $left, right: $right}';
  }
}
