import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "controle-despesas-financas",
  "private_key_id": "0b08aff49a892fe9e2bd63cc014b15de972c2d10",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC3DZm6hgcYJVVu\nry0GiwRk08HS1t3VLLYWqqFK6kUuuaUvYLWLuNKN7nQu/gwp9NMdy1ZExb3nMqJc\n/DTGw/z5lU1bS36GUwx3bA+boTVUXU3WI85/C2qRy4SrP2kRxgrTBqDD4LE/4SCS\nw5qkgDhDBinPXfWhUMNhoE2jqKOc3AuhOO4m80mLKKabEN1fWUtAuOmFOk2DA2C+\n+NKUMsLx6kki9xMoqv7KEQjfz9guzS414DJwrfWMzq+6v74yo4cyQuRAYetU2Ggd\nJkf1fqstH2GqQlgg22WHY7ssxbwImN+0gasmYf6W5Xxs6z6WhW23qwLei+lWhmLd\nD8v8HU1/AgMBAAECggEARIKClpyy6waOAu7tGxXMfzAByrdALxiczb7uvusPGX3B\npQm86J4zr4sfULckNk+689u2XebkPDNnMQXzerC/bWnDmfeXUw6iC9AVx1l+bCS/\njPW5wzKyn/5bmPwShuRoCLLiWG0v6YiIeGVc61RRukQEQegYlldzyIYGiMoE8h+G\nd12AnySr+AIYM8gM2ipkD9Dc1b9d3CQEwY1PFdn0rW8NcYGa9pRc6dpOneTI0U34\n3O5geAcsGb8RJgyRLG3z0PMKSJ43N1d0LA1pG6/Jiy8nViJEyC9fp5jO+8mW8VzE\nz9i3qo8X9GKmpe02hYCsUd+BV+EjGV9Yh/u0j6IvgQKBgQDprKZyh+OwsjYWRQQb\nLyAzCkYM9vdnWzLCWDFHDGT0YM4UU7a57hxv+v5E0LD2UWRL9RO8m511UpgW1QzH\nCkAEqHAQFZcRVhZQilaSqzRp0g3xBfxM5LYu8vIsWK5qypWbW65QkJIr91NSGNvk\nbP9h1iaR+G4oedMMKL7ya0qxqwKBgQDIitMGmCiybpfib24b1yPnraFSDLbr4VMH\n4f+l4eK89JlWXoqHu/u8FSKKsec0IPiO+hXMGckm4Gvr1txN5m+H5MNZI4XinusN\nWa7seEmIYVK1OHaGXdWkji0wbfgPqq+0xLqPfNv8q1EXCN92WwufJFupQ/C3vByG\nOIeo2jqnfQKBgHxSsyv0SJvV9RjcF1cvN35wVNzI+NAwoUztByq52Wx7pKkD8Q/z\nM4YQj/+k2MH0g9w1xA5w7NFi5DAhoe6z8WOJCjZEhl9e4fhv4aefFv/GFkzJ1nZC\nqPtJnrchZ4rBxd8mZBPRFzP1HotrVnKt2yH+gf7fohw+1J5/fzgTBWaJAoGAYHBC\nIv2xNH1ylPW5IbJIFfWtimOK48wrvbK02fTSsMN/qcU1ISkJWd1gCwqagLsKTNd+\n+/O6g/OQco2Uy/Fw2Qzt1EP88ooxxu3F7Pm7gtYqi/NnLB6bytKEcLGxhPc0H94r\nSS1mLQ/FoyolLCmEYTd+zNtbO0A/B1zQACdR5ZECgYBfpbR4ZGmNkueQ2TSLY8ZU\nCvb9A05ITMFNdWg8OiTwI96t6z828t62OusuavHPaBXIjWAB/8yytGyo/NYS8R9a\n5KBSyo/gKeUWgcA0UOEFn4fmGAGxHcNLS4/4sZ5KOwnHg0AnlT0T+iy1fu0WJ+pT\niQ1CsfN1JMkYR8A004DKdQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "controle-despesas-financas@controle-despesas-financas.iam.gserviceaccount.com",
  "client_id": "117645499117876541453",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/controle-despesas-financas%40controle-despesas-financas.iam.gserviceaccount.com"
}
 ''';

  static const _spreadSheetId = '1tz82FaGTD2U1qUzEJrngGUcWeZA8clr6e8ES9FrCDgU';

  //init GSheets
  final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadSheetId);
    // fetch spreadsheet by its title
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  static Future countRows() async {
    while ((await _worksheet!.values.value(
          column: 1,
          row: numberOfTransactions + 1,
        )) !=
        '') {
      numberOfTransactions++;
    }
    loadTransictions();
  }

  static Future loadTransictions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    loading = false;
  }
}
