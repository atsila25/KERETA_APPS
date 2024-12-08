import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prakmob3/UTS/Models/jadwal.dart';
import 'package:prakmob3/UTS/Models/stasiun.dart';

class ApiService {
  final String baseUrl = 'http://kereta-api-master.test/api';

  // Fetch data jadwal
  Future<List<Jadwal>> fetchJadwal() async {
    final response = await http.get(Uri.parse('$baseUrl/jadwal'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['result'];
      return data.map((item) => Jadwal.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jadwal');
    }
  }

  // Fetch stations by jenis_perjalanan 'local'
  Future<List<Stasiun>> fetchLocalStasiun() async {
    final response = await http.get(Uri.parse('$baseUrl/stasiun'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['result'];
      // Filter stations where jenis_perjalanan == 'local'
      List<Stasiun> localStations = data
          .where((item) => item['jenis_perjalanan'] == 'local')
          .map((item) => Stasiun.fromJson(item))
          .toList();
      return localStations;
    } else {
      throw Exception('Failed to load local stations');
    }
  }

  // Fetch stations by jenis_perjalanan 'intercity'
  Future<List<Stasiun>> fetchIntercityStasiun() async {
    final response = await http.get(Uri.parse('$baseUrl/stasiun'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['result'];
      // Filter stations where jenis_perjalanan == 'intercity'
      List<Stasiun> intercityStations = data
          .where((item) => item['jenis_perjalanan'] == 'intercity')
          .map((item) => Stasiun.fromJson(item))
          .toList();
      return intercityStations;
    } else {
      throw Exception('Failed to load intercity stations');
    }
  }

  // Fetch all stations
  Future<List<Stasiun>> fetchAllStasiun() async {
    final response = await http.get(Uri.parse('$baseUrl/stasiun'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['result'];
      // Return all stations without filtering
      return data.map((item) => Stasiun.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load all stations');
    }
  }
}
