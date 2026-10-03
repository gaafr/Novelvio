// Withdrawal model for Supabase
class Withdrawal {
  final int id;
  final String userId;
  final double amountUsd;
  final String status;
  final String method;
  final String? transactionId;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Withdrawal({
    required this.id,
    required this.userId,
    required this.amountUsd,
    required this.status,
    required this.method,
    this.transactionId,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'amount_usd': amountUsd,
        'status': status,
        'method': method,
        'transaction_id': transactionId,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory Withdrawal.fromJson(Map<String, dynamic> json) => Withdrawal(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? '',
        amountUsd: (json['amount_usd'] as num?)?.toDouble() ?? 0.0,
        status: json['status'] ?? 'pending',
        method: json['method'] ?? 'paypal',
        transactionId: json['transaction_id'],
        notes: json['notes'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now(),
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : DateTime.now(),
      );
}
