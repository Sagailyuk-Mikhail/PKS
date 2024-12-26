import 'dart:convert';
import 'package:dio/dio.dart';
import 'auth/auth_service.dart';
import 'models/AnalysisItem.dart';
import 'models/BasketItem.dart';
import 'models/CartHistoryItem.dart';
import 'models/FearRoom.dart';

class ApiService {
  final Dio _dio = Dio();
  final authService = AuthService();
  final String baseUrl = 'http://172.20.10.4:8080';

  Future<List<FearRoom>> getFearRooms() async {
    try {
      final response = await _dio.get('$baseUrl/fear_rooms/');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<FearRoom> fearRooms = data.map((room) => FearRoom.fromJson(room)).toList();
        return fearRooms;
      } else {
        throw Exception('Failed to load fear rooms');
      }
    } catch (e) {
      print('Error fetching fear rooms: $e');
      throw Exception('Error fetching fear rooms: $e');
    }
  }

  Future<void> addFearRoom(FearRoom newFearRoom) async {
    try {
      final response = await _dio.post('$baseUrl/fear_rooms/add', data: newFearRoom.toJson(), options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));
      if (response.statusCode == 200) {
        print('Fear room added successfully');
      } else {
        throw Exception('Failed to add fear room');
      }
    } catch (e) {
      print('Error adding fear room: $e');
      throw Exception('Error adding fear room: $e');
    }
  }

  Future<void> deleteFearRoom(int id) async {
    try {
      final response = await _dio.delete('$baseUrl/fear_rooms/delete/$id', options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));
      if (response.statusCode == 200) {
        print('Fear room deleted successfully');
      } else {
        throw Exception('Failed to delete fear room');
      }
    } catch (e) {
      print('Error deleting fear room: $e');
      throw Exception('Error deleting fear room: $e');
    }
  }

  Future<void> addProductToServer(AnalysisItem newProduct) async {
    try {
      final response = await _dio.post('$baseUrl/analyzes/add', data: newProduct.toJson(), options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));
      if (response.statusCode == 200) {
        print('Product added successfully');
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      print('Error adding product: $e');
      throw Exception('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await _dio.delete('$baseUrl/analyzes/delete/$id', options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));
      if (response.statusCode == 200) {
        print('Product deleted successfully');
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Error deleting product: $e');
    }
  }

  Future<void> updateProduct(AnalysisItem item) async {
    try {
      final response = await _dio.put('$baseUrl/analyzes/update', data: item.toJson(), options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));
      if (response.statusCode == 200) {
        print('Product updated successfully');
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Error updating product: $e');
    }
  }

  Future<List<AnalysisItem>> getProducts() async {
    try {
      final response = await _dio.get('$baseUrl/analyzes/');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<AnalysisItem> products = data.map((product) => AnalysisItem.fromJson(product)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<CartHistoryItem>> getCartHistory() async {
    try {
      final response = await _dio.get('$baseUrl/cart/history', options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => CartHistoryItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load cart history');
      }
    } catch (e) {
      print('Error fetching cart history: $e');
      throw Exception('Error fetching cart history: $e');
    }
  }

  Future<void> postToUserCart(List<BasketItem> cart) async {
    try {
      final List<Map<String, dynamic>> cartData = cart.map((item) =>
      {
        'analyze_id': item.item.id,
        'count': item.count,
      }).toList();

      final response = await _dio.post('$baseUrl/cart/post', data: cartData, options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));

      if (response.statusCode == 200) {
        print('Cart posted successfully');
      } else {
        throw Exception('Failed to post cart');
      }
    } catch (e) {
      print('Error posting cart: $e');
      throw Exception('Error posting cart: $e');
    }
  }

  Future<List<FearRoom>> getFavorites() async {
    try {
      final response = await _dio.get('$baseUrl/favorite/get', options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<FearRoom> favorites = data.map((item) => FearRoom.fromJson(item)).toList(); // Измените на FearRoom
        return favorites;
      } else if (response.statusCode == 404) {
        throw Exception('No favorites found');
      } else {
        throw Exception('Failed to fetch favorites');
      }
    } catch (e) {
      print('Error fetching favorites: $e');
      throw Exception('Error fetching favorites: $e');
    }
  }



  Future<void> addToFavorites(int analyzeId) async {
    try {
      final response = await _dio.post('$baseUrl/favorite/add/$analyzeId', options: Options(headers: {
        'authorization': authService.getCurrentUserId(),
      }));
      if (response.statusCode == 200) {
        print('Added to favorites successfully');
      } else {
        throw Exception('Failed to add to favorites');
      }
    } catch (e) {
      print('Error adding to favorites: $e');
      throw Exception('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(int analyzeId) async {
    try {
      final response = await _dio.delete('$baseUrl/favorite/delete/$analyzeId', options: Options(headers: {
        'Authorization': authService.getCurrentUserId(),
      }));
      if (response.statusCode == 200) {
        print('Removed from favorites successfully');
      } else {
        throw Exception('Failed to remove from favorites');
      }
    } catch (e) {
      print('Error removing from favorites: $e');
      throw Exception('Error removing from favorites: $e');
    }
  }
}
