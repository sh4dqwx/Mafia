class GameStart {
  final String role;

  GameStart({
    required this.role
  });

  factory GameStart.fromJson(Map<String, dynamic> json) {
    return GameStart(
      role: json['role']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role
    };
  }
}