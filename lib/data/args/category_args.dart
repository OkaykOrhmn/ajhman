class CategoryArgs {
  List<int>? categoriesId;

  CategoryArgs({this.categoriesId});

  CategoryArgs.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categoriesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoriesId'] = this.categoriesId;
    return data;
  }
}