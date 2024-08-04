// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ProductEvent {}

class FetchAllProductEvent extends ProductEvent {}

class LoadMoreProductEvent extends ProductEvent {}

class RefreshProductEvent extends ProductEvent {}

