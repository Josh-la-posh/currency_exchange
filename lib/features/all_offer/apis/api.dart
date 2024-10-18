import 'package:pouch/utils/responses/handleApiError.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';

import '../../../data/modules/interceptor.dart';


const OFFER_URL = '/offer';
const CREATE_OFFER_URL = 'create';
const ACCEPT_REJECT_OFFER_URL = 'accept-reject';
const NEGOTIATE_OFFER_URL = 'negotiate';
const SWAP_OFFER_URL = 'swap';
const ALL_NEGOTIATED_OFFER_URL = 'negotiate/negotiated-offers';
const MY_OFFER_URL = 'me/my-offer';
const MY_OFFERS_URL = 'me/my-offers';
const MY_BIDS_URL = 'me/my-bids';
const MY_BID_URL = 'me/my-bid';

final _apiService = AppInterceptor(showLoader: false).dio;

class OfferService {
  static final OfferService _instance = OfferService._();

  OfferService._();

  static OfferService get instance => _instance;

  // post requests

  Future creatingOffer(Map<String, dynamic> queryParameters) async {
    final response = await _apiService.post('$OFFER_URL/$CREATE_OFFER_URL', data: queryParameters);
    return response;
  }

  Future acceptingOrRejectingOffer({required String id, required Object data}) async {
    final response = await _apiService.post('$OFFER_URL/$ACCEPT_REJECT_OFFER_URL/$id', data: data);
    return response;
  }

  Future negotiatingOffer({required String id, required Object data}) async {
    final response = await _apiService.post('$OFFER_URL/$NEGOTIATE_OFFER_URL/$id', data: data);
    return response;
  }

  Future swappingOffer({required String id}) async {
    final response = await _apiService.post('$OFFER_URL/$SWAP_OFFER_URL/$id');
    return response;
  }

  Future fetchAllOffers(Map<String, dynamic> queryParameters) async {
    final response = await _apiService.get('$OFFER_URL', queryParameters: queryParameters);
    return response;
  }

  Future fetchOfferById(String id) async {
    final response = await _apiService.get('$OFFER_URL/$id',);
    return response;
  }

  Future fetchAllNegotiatedOffers() async {
    final response = await _apiService.get('$OFFER_URL/$ALL_NEGOTIATED_OFFER_URL');
    return response;
  }

  Future fetchMyOffers(String days, String currency) async {
    final response = await _apiService.get('$OFFER_URL/$MY_OFFERS_URL', queryParameters: {'days': days, 'currency': currency});
    return response;
  }

  Future fetchMyBids(String days, String currency) async {
    final response = await _apiService.get('$OFFER_URL/$MY_BIDS_URL', queryParameters: {'days': days, 'currency': currency});
    return response;
  }

  Future fetchMyOffersById(String id) async {
    final response = await _apiService.get('$OFFER_URL/$MY_OFFER_URL/$id');
    return response;
  }

  Future fetchMyBidsById(String id) async {
    final response = await _apiService.get('$OFFER_URL/$MY_BID_URL/$id');
    return response;
  }

  Future deleteOffer(String id) async {
    final response = await _apiService.delete('$OFFER_URL/$id');
    return response;
  }

  Future deleteBid(String id) async {
    final response = await _apiService.delete('$OFFER_URL/bid/$id');
    return response;
  }
}