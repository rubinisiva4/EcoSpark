import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class DataService {
  final String apiUrl =
      'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001d9143fc81ac74bce7ad727abc2705a8a&format=csv&limit=10000';

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Print the raw response body for debugging
        //   print('Raw response: ${response.body}');

        // Parse CSV data
        final csvData = response.body;
        final List<List<dynamic>> rows = const CsvToListConverter().convert(
            csvData,
            eol: '\n',
            fieldDelimiter: ',',
            shouldParseNumbers: true);

        if (rows.isEmpty) {
          print('No data found in CSV.');
          return [];
        }

        // Extract headers
        final headers = rows[0].map((header) => header.toString()).toList();
        //   print('Headers: $headers'); // Debug print

        // Extract data rows
        final data = rows.skip(1).map((row) {
          final Map<String, dynamic> map = {};
          for (int i = 0; i < headers.length; i++) {
            map[headers[i]] = row[i];
          }
          return map;
        }).toList();

        // print('Parsed Data: $data'); // Debug print
        return data;
      } else {
        print('Failed to load data, status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
