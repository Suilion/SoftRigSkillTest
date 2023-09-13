import 'package:flutter/material.dart';
import 'contact.dart';
import 'homePage.dart';
import 'constants.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:oauth_webauth/oauth_webauth.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OAuthWebAuth.instance.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unimicro template',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Unimicro Flutter Template'),
    );
  }

}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = OAuthWebAuth.instance.restoreCodeVerifier() != null;

  // LOGIN RELATED INFORMATION
  static const String authorizationEndpointUrl = String.fromEnvironment('AUTHORIZATION_ENDPOINT_URL', defaultValue: 'https://test-login.softrig.com/connect/authorize');
  static const String tokenEndpointUrl = String.fromEnvironment('TOKEN_ENDPOINT_URL', defaultValue: 'https://test-login.softrig.com/connect/token');
  static const String clientId = String.fromEnvironment('CLIENT_ID', defaultValue: '3c09b5dc-20d2-49ca-8750-fde58daf49e9');
  static const String companyKey = String.fromEnvironment('COMPANY_KEY', defaultValue: '2767e3e2-f432-459a-a3a1-ff466f327484');
  static const String redirectUrl = String.fromEnvironment('REDIRECT_URL', defaultValue: 'com.example.unimicroflutter://callback2');
  final List<String> scopes = const String.fromEnvironment('SCOPES', defaultValue: 'AppFramework Administrator Sales.Admin Sales.Manager openid profile offline_access').split(' ');


  Locale? contentLocale;
  String authResponse = 'Authorization data will be shown here';
  String token = '';
  String apiResponse = 'API data will be shown here';


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 300),
            () {
          if (OAuthWebAuth.instance.restoreCodeVerifier() != null) {
            login();
          }
        },
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (isLoading) const CircularProgressIndicator(),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              Text(
                authResponse,
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  goApiCall();
                },
                child: const Text('API Call'),
              ),
              const SizedBox(height: 16),
              Text(
                apiResponse,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Go to App'),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void login() {
    OAuthWebScreen.start(
      context: context,
      configuration: OAuthConfiguration(
          authorizationEndpointUrl: authorizationEndpointUrl,
          tokenEndpointUrl: tokenEndpointUrl,
          clientId: clientId,
          redirectUrl: redirectUrl,
          scopes: scopes,
          promptValues: const ['login'],
          loginHint: 'susanneskjoldedvardsen@gmail.com',
          onCertificateValidate: (certificate) {
            return true;
          },
          textLocales: {
            BaseConfiguration.backButtonTooltipKey: 'Back',
            BaseConfiguration.forwardButtonTooltipKey: 'Forward',
            BaseConfiguration.reloadButtonTooltipKey: 'Reload',
            BaseConfiguration.clearCacheButtonTooltipKey: 'Clear Cache',
            BaseConfiguration.closeButtonTooltipKey: 'Close',
            BaseConfiguration.clearCacheWarningMessageKey: 'Are you sure you want to clear the cache?',
          },
          contentLocale: contentLocale,
          onSuccessAuth: (credentials) {
            isLoading = false;
            setState(() {
              token = credentials.accessToken;
              UserCredentials.Token = token;
              authResponse = 'Login success!';
            });
          },

          onError: (error) {
            isLoading = false;
            setState(() {
              authResponse = error.toString();
            });
          },

          onCancel: () {
            isLoading = false;
            setState(() {
              authResponse = 'User cancelled authentication';
            });
          }),
    );
  }


  void goApiCall() async {
    try {
      final response = await http.get(
        Uri.parse('https://test-api.softrig.com/api/biz/contacts?expand=Info,Info.InvoiceAddress,Info.DefaultPhone,Info.DefaultEmail,Info.DefaultAddress&hateoas=false&top=10'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
          HttpHeaders.authorizationHeader: 'Bearer $token',
          "CompanyKey": companyKey,
          HttpHeaders.accessControlAllowOriginHeader: '*',
        },
      );

      // Check for error status codes
      if (response.statusCode == 401) {
        // Handle unauthorized error
        // For simplicity, we're just setting the state. You might want to show an alert or navigate the user.
        setState(() {
          apiResponse = "Error 401: Unauthorized. Check your credentials.";
        });

      } else if (response.statusCode == 403) {
        // Handle forbidden error
        setState(() {
          apiResponse = "Error 403: Forbidden. You don't have permission.";
        });

      } else if (response.statusCode != 200) {
        // Handle other status codes
        setState(() {
          apiResponse = "Error ${response.statusCode}: ${response.reasonPhrase}";
        });

      } else {
        setState(() {
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);

          //This generates an error
        });


        /*List jsonResponse = json.decode(response.body);
          jsonResponse.map((job) => ApiResponse.fromJson(job)).toList();
        final responseJson = jsonDecode(response.body);
        setState(() {
          apiResponse = responseJson.toString();
          debugPrint(apiResponse, wrapWidth: 1024);
        });
         */
      }
    } catch (error) {
      // Handle other errors like network issues, JSON decoding, etc.
      setState(() {
        apiResponse = "An error occurred: $error";
      });
    }
  }
}