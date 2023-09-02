class popularHash {
  final String hashTagName;
  final int hashTagCount;

  popularHash({
    required this.hashTagName,
    required this.hashTagCount,
  });
  factory popularHash.fromJson(Map<String, dynamic> json) {
    return popularHash(
        hashTagName: json["hashTagName"],
        hashTagCount: json["hashTagCount"]
    );}
}
