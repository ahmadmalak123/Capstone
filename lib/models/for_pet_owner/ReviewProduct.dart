class ReviewProduct {
  final int? reviewproductId;
  final int? ownerId;
  final int? productId;
  final int? rating;
  final String? comment;
  final DateTime? date;

  ReviewProduct({
    this.reviewproductId,
    this.ownerId,
    this.productId,
    this.rating,
    this.comment,
    this.date,
  });

  // Converts a ReviewResource object to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewproductId,
      'ownerId': ownerId,
      'productId': productId,
      'rating': rating,
      'comment': comment,
      'date': date?.toIso8601String(), // Use ISO 8601 format
    };
  }

  // Creates a ReviewResource object from a JSON map.
  factory ReviewProduct.fromJson(Map<String, dynamic> json) {
    return ReviewProduct(
      reviewproductId: json['reviewId'] as int?,
      ownerId: json['ownerId'] as int?,
      productId: json['vetId'] as int?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
}
