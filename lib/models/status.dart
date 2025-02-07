class Status {
  Status({
    this.id = 0,
    this.status = '',
    this.iconPath = ''
  });

  int id;
  String status;
  String iconPath;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json['id'] ?? 0,
    status: json['status'] ?? '',
    iconPath: json['iconPath'] ?? ''
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
    'iconPath': iconPath
  };
}