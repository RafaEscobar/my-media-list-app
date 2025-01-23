class CategoryModel {
  CategoryModel({
    this.id = 0,
    this.category = '',
    this.imageUrl = '',
    this.subtype = ''
  });
  final int id;
  final String category;
  final String imageUrl;
  final String subtype;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    category: json['category'],
    imageUrl: json['image'],
    subtype: json['subtype']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'imageUrl': imageUrl,
    'subtype': subtype
  };
}