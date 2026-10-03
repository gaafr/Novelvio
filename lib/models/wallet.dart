// Wallet model for Supabase
class Wallet {
  final String userId;
  final int points;
  final bool verified;
  final DateTime createdAt;
  final DateTime updatedAt;

  Wallet({
    required this.userId,
    required this.points,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'points': points,
        'verified': verified,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        userId: json['user_id'] ?? '',
        points: json['points'] ?? 0,
        verified: json['verified'] ?? false,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now(),
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : DateTime.now(),
      );
}
