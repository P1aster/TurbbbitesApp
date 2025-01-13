class PaginationResponseModel<T> {
  final int total;
  final List<T> data;

  PaginationResponseModel({required this.total, required this.data});

  factory PaginationResponseModel.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) fromJsonT) {
    var data = (json['data'] as List)
        .map((item) => fromJsonT(item as Map<String, dynamic>))
        .toList();
    return PaginationResponseModel<T>(total: json['total'], data: data);
  }
}

class PaginationRequestModel {
  final int? page;
  final int? pageSize;

  const PaginationRequestModel({
    this.page,
    this.pageSize,
  });

  Map<String, dynamic> toJson() => {
        if (page != null) 'page': page,
        if (pageSize != null) 'pageSize': pageSize,
      };
}
