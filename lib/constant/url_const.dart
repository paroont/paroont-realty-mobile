const String URL_REALTY_API_HOST = "http://localhost:8080";

String fullApiUrl(String url) {
  return '$URL_REALTY_API_HOST$url';
}

const String URL_REALTY_API_DATA_PREFIX = "/api/data/realty";
const String URL_REALTY_RDM_API_DATA_PREFIX =
    URL_REALTY_API_DATA_PREFIX + "/rdm";
const String URL_REALTY_PROPERTY_API_DATA_PREFIX =
    URL_REALTY_API_DATA_PREFIX + "/property";

const String URL_REALTY_RDM_PROPERTY_API_DATA_PREFIX =
    URL_REALTY_RDM_API_DATA_PREFIX + "/property";
const String URL_REALTY_RDM_COMMON_API_DATA_PREFIX =
    URL_REALTY_RDM_API_DATA_PREFIX + "/common";
 const    String URL_REALTY_PROPERTY_SELL  = URL_REALTY_PROPERTY_API_DATA_PREFIX + "/sells";

