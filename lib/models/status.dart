class Status {
  Status({
    this.id = 0,
    this.status = ''
  });

  int id;
  String status;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json['id'] ?? 0,
    status: json['status'] ?? ''
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status
  };
}