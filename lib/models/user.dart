class User {
  int id;
  String? nombre;
  String? apellido;
  String? telefono;
  String? email;
  String? password;
  String? token;
  String? image;

  User({
    required this.id,
    this.nombre,
    this.apellido,
    this.telefono,
    this.email,
    this.password,
    this.token,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        nombre: json['user']['nombre'],
        apellido: json['user']['apellido'],
        telefono: json['user']['telefono'],
        email: json['user']['email'],
        password: json['user']['password'],
        token: json['token'],
        image: json['image']);
  }
}
