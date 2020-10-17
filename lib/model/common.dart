
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
