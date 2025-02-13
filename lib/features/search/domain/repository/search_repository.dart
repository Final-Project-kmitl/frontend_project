abstract class SearchRepository {
  Future<List<String>> getLocalSearch();
  Future<List<String>> getPopularSearch();
  Future<void> saveSearchQuery(String query);
}
