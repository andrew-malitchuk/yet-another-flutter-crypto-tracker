abstract class BaseDatabaseDatasource<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<T?> getBySlug(String slug);
  Future<void> insert(T item);
  Future<void> update(T item);
  Future<void> delete(int id);
  Future<void> deleteBySlug(String slug);
}