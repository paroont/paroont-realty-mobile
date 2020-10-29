
class CoreObj {
}

class CoreFilter {
  int pageNo = 0;
  int pageSize = 10;
}


class CorePaginationData<T extends CoreObj> {
int totalRecords;
List<T> data = List();
}


class MultiSelectData {
  Map<int, TextSearchData> allData = Map();
  Map<int, TextSearchData> selectedData = Map();
  String title = '';
}

class TextSearchData {
  int dataId = -1;
  String type = '';
  String key = '';
  String value = '';
  String title = '';
  String subTitle = '';
  TextSearchData(this.value);
  TextSearchData.keyValue(this.key, this.value);
  TextSearchData.keyValueTitle(this.key, this.value, this.title);
  TextSearchData.all(this.dataId, this.type, this.key, this.value, this.title, this.subTitle);
}
