const userTable='users';
const userData='userData';
const baseUrl='https://wfgvihviefrbvzrwkgye.supabase.co/rest/v1/';
const authBaseUrl='https://wfgvihviefrbvzrwkgye.supabase.co/auth/v1/';
const userId='';
const homeProductsUrl='products_table?select=*,favorite_products(*),purchase_table(*)';
const productUrl='products_table?';
const productRateUrl='rates_table?select=*&for_product=eq.';
const productRateAddUrl='rates_table';
const getProductCommentsUrl='comments_table?select=*&for_product=eq.';
const postProductCommentsUrl='comments_table';
const favTable='favorite_products';
const purchaseTable='purchase_table';
const List<String> orderStatusList = [
  'Pending',
  'Processing',
  'Shipped',
  'Delivered',
  'Confirm Receipt',
  'Archived',
];
const deliveryInfoTable='delivery_info';
const String termsUrl = "https://www.termsfeed.com/live/43bf675d-7b68-454a-bf45-7ec1db0cf6a4";
const List<String> DropDownListList= [
'Sports',
'Electronics',
'Collections',
'Book',
'Game',
'Bikes',
];
final List<String> adminRolesList = ['Primary', 'Secondary'];
const String authDio="authDio";
const String authApi="authApi";
const String adminTable='admin_table';
const String accessToken='access_token';
const String adminInfo='admin_info';




