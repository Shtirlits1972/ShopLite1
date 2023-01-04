class order_head {
  int id = 0;
  int user_id = 0;
  DateTime data_order = DateTime.now();
  double total_sum = 0;

  @override
  String toString() {
    return 'id = $id, user_id = $user_id, data_order = $data_order, total_sum = $total_sum ';
  }

  order_head(this.id, this.user_id, this.data_order, this.total_sum);
  order_head.empty() {
    id = 0;
    user_id = 0;
    data_order = DateTime.now();
    total_sum = 0;
  }
}
