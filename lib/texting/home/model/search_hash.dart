class searchHash {
  final String hashTagName;
  final int hashTagCount;
  final bool hashTagCheck;

  searchHash({
    required this.hashTagName,
    required this.hashTagCount,
    required this.hashTagCheck
  });
  factory searchHash.fromJson(Map<String, dynamic> json) {
    return searchHash(
        hashTagName: json["hashTagName"],
        hashTagCount: json["hashTagCount"],
        hashTagCheck: json["hashTagCheck"]
    );}
}
