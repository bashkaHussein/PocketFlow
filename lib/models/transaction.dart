
enum TransactionType { income, expense, bonus }

class Transaction {
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final bool isIncome; // Kept for backward compatibility if needed, or derived
  final TransactionType type;
  final String currency;

  Transaction({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.type,
    required this.currency,
  });
}
