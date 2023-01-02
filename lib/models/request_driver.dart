class RequestDriver {
  bool sendRequest;
  String estado;

  RequestDriver({required this.sendRequest, required this.estado});

  factory RequestDriver.fromJson(Map<String, dynamic> json) {
    return RequestDriver(
        sendRequest: json['sendRequest'], estado: json['estado']);
  }
}
