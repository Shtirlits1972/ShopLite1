class Product {
  int id = 0;
  String NameProduct = '';
  double PriceProduct = 0;

  Product(this.id, this.NameProduct, this.PriceProduct);

  Product.empty() {
    this.id = 0;
    this.NameProduct = '';
    this.PriceProduct = 0;
  }

  @override
  String toString() {
    return 'id = $id, NameProduct = $NameProduct, PriceProduct = $PriceProduct ';
  }
}
