// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<List<String>> fetchSearchPredictions(String query) async {
//   // Ensure the query is not empty
//   if (query.isEmpty) {
//     return [];
//   }

//   // Define the endpoint with dynamic input
//   final url = Uri.parse(
//       'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
//       'input=$query&'
//       'key=YOUR_API_KEY&'
//       'types=geocode&'
//       'language=en-GB&'
//       'components=country:AU');

//   // Headers (optional for this API)
//   final headers = {
//     'accept': '/',
//     'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8',
//     'user-agent': 'Flutter App',
//   };

//   try {
//     // Send GET request
//     final response = await http.get(url, headers: headers);

//     // Check the response status
//     if (response.statusCode == 200) {
//       // Decode JSON response
//       final jsonResponse = json.decode(response.body);

//       // Extract predictions
//       final predictions = jsonResponse['predictions'] as List;
//       return predictions.map((p) => p['description'] as String).toList();
//     } else {
//       print('Failed to fetch data: ${response.statusCode}');
//       return [];
//     }
//   } catch (e) {
//     print('Error: $e');
//     return [];
//   }
// }

// void main() async {
//   // Example usage: Replace 'Sydney' with user input
//   final results = await fetchSearchPredictions('Sydney');
//   print('Search Predictions: $results');
// }
