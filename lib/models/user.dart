class User {
  String id;
  String? nombre;
  String? apellido;
  String? telefono;
  String? email;
  String? password;
  String? image;
  List<String>? role;
  String? token;

  User({
    required this.id,
    this.nombre,
    this.apellido,
    this.telefono,
    this.email,
    this.password,
    this.token,
    this.role,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> rolesStr = [];
    List roles = json['user']['role'];

    for (var elem in roles) {
      rolesStr.add(elem.toString());
    }

    return User(
        id: json['user']['id'].toString(),
        nombre: json['user']['nombre'],
        apellido: json['user']['apellido'],
        telefono: json['user']['telefono'],
        email: json['user']['email'],
        role: rolesStr,
        token: json['token'],
        image: json['image'] ?? '');
  }
}
