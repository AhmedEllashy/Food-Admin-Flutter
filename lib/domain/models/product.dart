class Product{
   String? id;
  String ? name;
  String ?category;
  String ?price;
  String ?discount;
  String ?status;
  Product(this.id,this.name,this.category,this.price,this.discount,this.status);

  Product.formJson(Map<String,dynamic> snapshot){
    id = snapshot['id'];
    name = snapshot['name'];
    category = snapshot['category'];
    price = snapshot['price'];
    discount = snapshot['discount'];
    status = snapshot['status'];
  }
}