class Request {
  bool sendRequest;
  String estado;

  Request({required this.sendRequest, required this.estado});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(sendRequest: json['sendRequest'], estado: json['estado']);
  }
}
