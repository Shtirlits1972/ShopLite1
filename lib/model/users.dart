class users {
  int id = 0;
  String Login = '';
  String Password = '';
  bool IsRemember = false;

  users(this.id, this.Login, this.Password, this.IsRemember);

  users.empty() {
    this.id = 0;
    this.Login = '';
    this.Password = '';
    this.IsRemember = false;
  }

  @override
  String toString() {
    return 'id = $id, Login = $Login, Password = $Password, IsRemember = $IsRemember';
  }
}
