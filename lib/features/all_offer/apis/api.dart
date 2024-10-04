import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/responses/handleApiError.dart';

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
final apiService = AppInterceptor(showLoader: true).dio;

class OfferService {
  static final OfferService _instance = OfferService._();

  OfferService._();

  static OfferService get instance => _instance;

  // post requests

  Future creatingOffer(Map<String, dynamic> queryParameters) async {
    try {
      final response = await _apiService.post('$OFFER_URL/$CREATE_OFFER_URL', data: queryParameters);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future acceptingOrRejectingOffer({required String id, required Object data}) async {
    try {
      final response = await _apiService.post('$OFFER_URL/$ACCEPT_REJECT_OFFER_URL/$id', data: data);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future negotiatingOffer({required String id, required Object data}) async {
    try {
      final response = await _apiService.post('$OFFER_URL/$NEGOTIATE_OFFER_URL/$id', data: data);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future swappingOffer({required String id}) async {
    try {
      final response = await _apiService.post('$OFFER_URL/$SWAP_OFFER_URL/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchAllOffers(Map<String, dynamic> queryParameters) async {
    try {
      final response = await _apiService.get('$OFFER_URL', queryParameters: queryParameters);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchOfferById(String id) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$id',);
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchAllNegotiatedOffers() async {
    try {
      final response = await _apiService.get('$OFFER_URL/$ALL_NEGOTIATED_OFFER_URL');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchMyOffers(String days, String currency) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$MY_OFFERS_URL', queryParameters: {'days': days, 'currency': currency});
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchMyBids(String days, String currency) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$MY_BIDS_URL', queryParameters: {'days': days, 'currency': currency});
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchMyOffersById(String id) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$MY_OFFER_URL/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future fetchMyBidsById(String id) async {
    try {
      final response = await _apiService.get('$OFFER_URL/$MY_BID_URL/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future deleteOffer(String id) async {
    try {
      final response = await _apiService.delete('$OFFER_URL/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }

  Future deleteBid(String id) async {
    try {
      final response = await _apiService.delete('$OFFER_URL/bid/$id');
      return response;
    } catch (e) {
      Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.redAccent);
    }
  }











  



}