class Counter {
  final dynamic id;
  final int value;

  Counter({this.id = 0, this.value = 0});
  Counter.copy(Counter from) : this(value: from.value, id: from.id);
  Counter copyWith({dynamic id, int? value}) =>
      Counter(id: id ?? this.id, value: value ?? this.value);

  Counter.fromJson(Map<String, dynamic> json)
      : this(value: json['value'], id: json['id']);

  Map<String, dynamic> toJson() => {'value': value, 'id': id};
}
