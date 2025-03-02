import 'dart:ui';

import '../../../data/modules/dio_service.dart';
import '../../../data/modules/interceptor.dart';

final _dioService = AppInterceptor(showLoader: false).dio;

class OfferService {
  static final OfferService _instance = OfferService._();

  OfferService._();

  static OfferService get instance => _instance;

  final DioService _dioService = DioService();

  Future<Map<String, dynamic>> creatingOffer({required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.postRequest(endpoint: '/offer/create', data: data);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> acceptingOrRejectingOffer({required String id, required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.postRequest(endpoint: '/offer/accept-reject/$id', data: data);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> negotiatingOffer({required String id, required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.postRequest(endpoint: '/offer/negotiate/$id', data: data);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> swappingOffer({required String id, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/offer/swap/$id');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchAllOffers({required Map<String, dynamic> queryParameters, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/offer', queryParameters: queryParameters);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchOfferById({required String id, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/offer/$id');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchAllNegotiatedOffers({required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/offer/negotiate/negotiated-offers');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchMyOffers({required Map<String, dynamic> queryParameters, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/offer/me/my-offers', queryParameters: queryParameters);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchMyBids({required Map<String, dynamic> queryParameters, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/offer/me/my-bids', queryParameters: queryParameters);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchMyOffersById({required String id, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/offer/me/my-offer/$id');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> fetchMyBidsById({required String id, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/offer/me/my-bid/$id');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> switchInstantSwap({required String id, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.putRequest(endpoint: '/offer/instant-swap/update/$id');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> updateInstantSwap({required String id, required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.putRequest(endpoint: '/offer/instant-swap/update/$id', data: data);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> deleteOffer({required String id, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.deleteRequest(endpoint: '/offer/$id');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> deleteBid({required String id, required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.deleteRequest(endpoint: '/offer/bid/$id');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }
}







// then and catch method

// import 'dart:ui';
//
// import '../../../data/modules/interceptor.dart';
// import '../../../utils/responses/handleApiError.dart';
//
// final _apiService = AppInterceptor(showLoader: false).dio;
//
// class OfferService {
//   static final OfferService _instance = OfferService._();
//
//   OfferService._();
//
//   static OfferService get instance => _instance;
//
//   Future _creatingOffer({required Object data}) {
//     return _apiService.post('/offer/create', data: data);
//   }
//
//   Future _acceptingOrRejectingOffer({required String id, required Object data}) {
//     return _apiService.post('/offer/accept-reject/$id', data: data);
//   }
//
//   Future _negotiatingOffer({required String id, required Object data}) {
//     return _apiService.post('/offer/negotiate/$id', data: data);
//   }
//
//   Future _swappingOffer({required String id}) {
//     return _apiService.get('/offer/swap/$id');
//   }
//
//   Future _fetchAllOffers({required Map<String, dynamic> queryParameters}) {
//     return _apiService.get('/offer', queryParameters: queryParameters);
//   }
//
//   Future _fetchOfferById({required String id}) {
//     return _apiService.get('/offer/$id');
//   }
//
//   Future _fetchAllNegotiatedOffers() {
//     return _apiService.get('/offer/negotiate/negotiated-offers');
//   }
//
//   Future _fetchMyOffers({required Map<String, dynamic> queryParameters}) {
//     return _apiService.get('/offer/me/my-offers', queryParameters: queryParameters);
//   }
//
//   Future _fetchMyBids({required Map<String, dynamic> queryParameters}) {
//     return _apiService.get('/offer/me/my-bids', queryParameters: queryParameters);
//   }
//
//   Future _fetchMyOffersById({required String id}) {
//     return _apiService.get('/offer/me/my-offer/$id');
//   }
//
//   Future _fetchMyBidsById({required String id}) {
//     return _apiService.get('/offer/me/my-bid/$id');
//   }
//
//   Future _switchInstantSwap({required String id}) {
//     return _apiService.put('/offer/instant-swap/update/$id');
//   }
//
//   Future _updateInstantSwap({required String id, required Object data}) {
//     return _apiService.put('/offer/instant-swap/update/$id', data: data);
//   }
//
//   Future _deleteOffer({required String id}) {
//     return _apiService.delete('/offer/$id');
//   }
//
//   Future _deleteBid({required String id}) {
//     return _apiService.delete('/offer/bid/$id');
//   }
//
//   // post requests
//
//   Future creatingOffer({required Object data, required VoidCallback onFailure}) async {
//     return _creatingOffer(data: data).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future acceptingOrRejectingOffer({required String id, required Object data, required VoidCallback onFailure}) async {
//     return _acceptingOrRejectingOffer(id: id, data: data).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future negotiatingOffer({required String id, required Object data, required VoidCallback onFailure}) async {
//     return _negotiatingOffer(id: id, data: data).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future swappingOffer({required String id, required VoidCallback onFailure}) async {
//     return _swappingOffer(id: id).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future fetchAllOffers({required Map<String, dynamic> queryParameters, required VoidCallback onFailure}) async {
//     return _fetchAllOffers(queryParameters: queryParameters).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future fetchOfferById({required String id, required VoidCallback onFailure}) async {
//     return _fetchOfferById(id: id).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future fetchAllNegotiatedOffers({required VoidCallback onFailure}) async {
//     return _fetchAllNegotiatedOffers().then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future fetchMyOffers({required String days, required String currency, required VoidCallback onFailure}) async {
//     return _fetchMyOffers(queryParameters: {
//       'days': days, 'currency': currency
//     }).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future fetchMyBids({required String days, required String currency, required VoidCallback onFailure}) async {
//     return _fetchMyBids(queryParameters: {
//       'days': days, 'currency': currency
//     }).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future fetchMyOffersById({required String id, required VoidCallback onFailure}) async {
//     return _fetchMyOffersById(id: id).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future fetchMyBidsById({required String id, required VoidCallback onFailure}) async {
//     return _fetchMyBidsById(id: id).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future switchInstantSwap({required String id, required VoidCallback onFailure}) async {
//     return _switchInstantSwap(id: id).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future updateInstantSwap({required String id, required VoidCallback onFailure}) async {
//     return _updateInstantSwap(id: id, data: {}).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future deleteOffer({required String id, required VoidCallback onFailure}) async {
//     return _deleteOffer(id: id).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future deleteBid({required String id, required VoidCallback onFailure}) async {
//     return _deleteBid(id: id).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
// }