import 'package:mobile/models/VotingResult.dart';

class VotingSummary {
  final List<VotingResult> results;

  VotingSummary({
    required this.results
  });

  factory VotingSummary.fromJson(Map<String, dynamic> json) {
    return VotingSummary(
      results: List<VotingResult>.from(json['username']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results
    };
  }
}
