/// Base class for result types indicating the source of data.
sealed class ResultType {}

/// Represents a result obtained from an offline source (e.g., cache or local storage).
class OfflineResultType extends ResultType {
  OfflineResultType();
}

/// Represents a result obtained from an online source (e.g., network).
class OnlineResultType extends ResultType {
  OnlineResultType();
}
