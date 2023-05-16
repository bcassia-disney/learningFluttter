import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter cache with dio',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DioCacheManager? _dioCacheManager;
  String? _myData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
      Center(
          child: CachedNetworkImage(
            placeholder: (context, url) => const CircularProgressIndicator(),
            imageUrl: 'https://picsum.photos/250?image=9',
          ),
        ),
          TextButton(
            child: const Text(
              'getData',
            ),
            onPressed: () async {
              _dioCacheManager = DioCacheManager(CacheConfig());

              Options cacheOptions = buildCacheOptions(const Duration(days: 7));
              Dio dio = Dio();
              dio.interceptors.add(_dioCacheManager?.interceptor);
              Response response = await dio.get(
                  'https://disease.sh/v3/covid-19/all',
                  options: cacheOptions);
              setState(() {
                _myData = response.data.toString();
              });
            },
          ),
          TextButton(
            child: const Text(
              'Delete Cache',
            ),
            onPressed: () async {
              if (_dioCacheManager != null) {
                var res = await _dioCacheManager?.deleteByPrimaryKey(
                    'https://disease.sh/v3/covid-19/all');
                print(res);
              }
            },
          ),
          Text(
            _myData ?? '',
            // style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}