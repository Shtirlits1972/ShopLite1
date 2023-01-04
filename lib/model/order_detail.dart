class order_detail {
  int id = 0;
  int order_id = 0;
  int tovar_id = 0;
  String NameProduct = '';
  double PriceProduct = 0;
  int qty = 0;
  double sum_row = 0;

  @override
  String toString() {
    return 'id = $id, order_id = $order_id, tovar_id = $tovar_id, NameProduct = $NameProduct, PriceProduct = $PriceProduct, PriceProduct = $PriceProduct, qty = $qty, sum_row = $sum_row ';
  }

  order_detail(this.id, this.order_id, this.tovar_id, this.NameProduct,
      this.PriceProduct, this.qty, this.sum_row);

  order_detail.empty() {
    this.id = 0;
    this.order_id = 0;
    this.tovar_id = 0;
    this.NameProduct = '';
    this.PriceProduct = 0;
    this.qty = 0;
    this.sum_row = 0;
  }
}
