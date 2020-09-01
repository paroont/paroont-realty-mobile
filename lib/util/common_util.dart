
String notNullStr(String s) => s == null ? '' : s;
bool isEmptyStr(String s) => s == null || s.length == 0;
bool isBlankStr(String s) => s == null || s.trim().length == 0;
bool notBlankStr(String s) => !isBlankStr( s);

int notNullInt(int i) => i == null ? 0 : i;