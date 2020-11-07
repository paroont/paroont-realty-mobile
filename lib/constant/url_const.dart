const String URL_REALTY_API_HOST = "localhost:8080";

const String URL_WHATS_APP = "https://wa.me/";

String fullApiUrl(String url) {
  return '$URL_REALTY_API_HOST$url';
}

const String URL_COMMON_PARAM_HEADER_PAROONT_UID  = "paroont-uid";

const String URL_REALTY_API_DATA_PREFIX = "/api/data/realty";
const String URL_REALTY_API_CACHE_DATA_PREFIX = "/api/data-swift/realty";
const String URL_REALTY_RDM_API_DATA_PREFIX =
    URL_REALTY_API_DATA_PREFIX + "/rdm";


const String URL_REALTY_RDM_PROPERTY_API_DATA_PREFIX =
    URL_REALTY_RDM_API_DATA_PREFIX + "/property";
const String URL_REALTY_RDM_COMMON_API_DATA_PREFIX =
    URL_REALTY_RDM_API_DATA_PREFIX + "/common";
 const    String URL_REALTY_PROPERTY  = URL_REALTY_API_DATA_PREFIX + "/properties";
 const    String URL_REALTY_CACHE_PROPERTY  = URL_REALTY_API_CACHE_DATA_PREFIX + "/properties";
 const    String URL_REALTY_RDM_ARD  = URL_REALTY_RDM_API_DATA_PREFIX + "/app-ref-data";


 const    String URL_REALTY_USER_PROFILE  = URL_REALTY_API_DATA_PREFIX + "/user/profiles";
