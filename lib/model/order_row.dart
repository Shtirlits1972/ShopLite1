// ignore_for_file: unnecessary_this

class OrderRow {
  int id = 0;
  int ProductId = 0;
  String ProductName = '';
  double ProductPrice = 0;
  int qty = 0;

  double total() {
    return ProductPrice * qty;
  }

  OrderRow(
      this.id, this.ProductId, this.ProductName, this.ProductPrice, this.qty);

  OrderRow.empty() {
    this.id = 0;
    this.ProductId = 0;
    this.ProductName = '';
    this.ProductPrice = 0;
    this.qty = 0;
  }

  @override
  String toString() {
    return 'id = $id, ProductId = $ProductId, ProductName = $ProductName, ProductPrice = $ProductPrice, qty = $qty';
  }
}
