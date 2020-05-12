class Trans {
  final int id;
  final String transDate;
  final String transName;
  final String transType;
  final int amount;

  Trans({ this.id, this.transDate, this.transName, this.transType, this.amount });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': transDate,
      'name': transName,
      'type': transType,
      'amount': amount
    };
  }

  @override
  String toString() {
    return 'Trans{id: $id, transName: $transName, amount: $amount}';
  }

}