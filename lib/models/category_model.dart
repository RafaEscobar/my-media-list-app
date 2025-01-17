class CategoryModel {
  CategoryModel({
    this.id = 0,
    this.category = '',
    this.imageUrl = ''
  });
  final int id;
  final String category;
  final String imageUrl;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    category: json['category'],
    imageUrl: json['image']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'imageUrl': imageUrl
  };
}