const String BASE_URL = "http://192.120.130.100:90/";
String userid = "";

const String USER_REGISTER_URL = "user/register";
const String USER_LOGIN_URL = "user/login";

const String ADD_DOCTOR_URL = "doctor/register";
const String ADD_PRODUCT_URL = "product/register";

const String GET_PROFILE = "user/profile/";

const String GET_ALL_PRODUCT = "product/getall";
const String GET_ALL_DOCTOR = "doctor/getall";
const String GET_SINGLE_PRODUCT = "product/show/";
const String GET_SINGLE_DOCTOR = "doctor/show/";
const String ADD_TO_CART = "product/addtocart";
const String GET_ADD_TO_CART = "product/getall/";
const String REMOVE_FROM_CART = "addtocart/remove/";
const String ADD_TO_APPOINTMENT = "appointment/register";
const String GET_ALL_APPOINTMENT = "appointment/getall/";
const String REMOVE_FROM_APPOINTMENT = "appointment/remove/";
const String REMOVE_DOCTOR_INFO = "doctor/remove/";
const String REMOVE_PRODUCT_INFO = "product/remove/";
const String UPDATE_DOCTOR_INFO = "doctor/update/";
const String DETAILS_CHECKOUT_URL = "checkout/details/register";

String get getregisterUrl => BASE_URL + USER_REGISTER_URL;

String get getloginUrl => BASE_URL + USER_LOGIN_URL;

String get getadddoctorUrl => BASE_URL + ADD_DOCTOR_URL;

String get getaddproductUrl => BASE_URL + ADD_PRODUCT_URL;

String get userloginid => userid;

String get getprofile => BASE_URL + GET_PROFILE;

String get getallproducturl => BASE_URL + GET_ALL_PRODUCT;

String get getalldoctorurl => BASE_URL + GET_ALL_DOCTOR;

String get getsingleproducturl => BASE_URL + GET_SINGLE_PRODUCT;

String get getsingledoctorUrl => BASE_URL + GET_SINGLE_DOCTOR;

String get addtocarturl => BASE_URL + ADD_TO_CART;

String get getaddtocartitemsurl => BASE_URL + GET_ADD_TO_CART;

String get getremovefromcarturl => BASE_URL + REMOVE_FROM_CART;

String get addtoappointmenturl => BASE_URL + ADD_TO_APPOINTMENT;

String get getallappointmenturl => BASE_URL + GET_ALL_APPOINTMENT;

String get getremoveappointmenturl => BASE_URL + REMOVE_FROM_APPOINTMENT;

String get getremovedoctorurl => BASE_URL + REMOVE_DOCTOR_INFO;

String get getremoveproducturl => BASE_URL + REMOVE_PRODUCT_INFO;

String get geteditdoctorurl => BASE_URL + UPDATE_DOCTOR_INFO;

String get getcheckoutdetailsurl => BASE_URL + DETAILS_CHECKOUT_URL;
