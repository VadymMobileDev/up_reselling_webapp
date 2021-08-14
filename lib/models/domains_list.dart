class DomainItem {
  late String label;
  late String extension;
  late int price;

  DomainItem({required this.label, required this.extension, required this.price});

  DomainItem.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    extension = json['extension'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['extension'] = this.extension;
    data['price'] = this.price;
    return data;
  }
}
