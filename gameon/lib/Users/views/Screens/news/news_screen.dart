import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/news/widgets/apikey.dart';
import 'package:gameon/Users/views/Screens/news/widgets/articalnews.dart';
import 'package:gameon/Users/views/Screens/news/widgets/listofcountry.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class DropDownList extends StatelessWidget {
  const DropDownList({super.key, required this.name, required this.call});
  final String name;
  final Function call;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(title: Text(name)),
      onTap: () => call(),
    );
  }
}

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void toggleDrawer() {
  if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
    _scaffoldKey.currentState?.openEndDrawer();
  } else {
    _scaffoldKey.currentState?.openDrawer();
  }
}

class _NewsScreenState extends State<NewsScreen> {
  String? cName;
  String? country = 'in';
  String? category = 'sports';
  String? findNews;
  int pageNum = 1;
  bool isLoading = false;
  late ScrollController controller;
  List<dynamic> news = [];
  bool notFound = false;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    getNews();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() => isLoading = true);
      getNews(reload: true);
    }
  }

  Future<void> getNews({
    String? channel,
    String? searchKey,
    bool reload = false,
  }) async {
    setState(() => notFound = false);

    if (!reload && !isLoading) {
      toggleDrawer();
    }

    if (reload) {
      pageNum++;
    } else {
      setState(() {
        news = [];
        pageNum = 1;
      });
    }

    String baseApi =
        'https://api.mediastack.com/v1/news?access_key=$access_key&languages=en&page=$pageNum&limit=10';

    if (channel != null) {
      baseApi += '&sources=$channel';
    } else {
      baseApi += '&categories=${category ?? "sports"}';
      baseApi += '&countries=${country ?? "in"}';
    }

    if (searchKey != null && searchKey.isNotEmpty) {
      baseApi += '&keywords=$searchKey';
    }

    await getDataFromApi(baseApi);
  }

  Future<void> getDataFromApi(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['data'];

      if (results.isEmpty) {
        setState(() {
          notFound = true;
          isLoading = false;
        });
      } else {
        setState(() {
          news.addAll(results);
          isLoading = false;
        });
      }
    } else {
      setState(() {
        notFound = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 32),
            children: [
              if (country != null)
                Text('Country = ${cName ?? country?.toUpperCase()}'),
              if (category != null)
                Text('Category = ${category?.toUpperCase()}'),
              const SizedBox(height: 20),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(hintText: 'Find Keyword'),
                  onChanged: (val) => findNews = val,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (findNews != null && findNews!.isNotEmpty) {
                      getNews(searchKey: findNews);
                    }
                  },
                ),
              ),
              ExpansionTile(
                title: const Text('Country'),
                children: [
                  for (final item in listOfCountry)
                    DropDownList(
                      name: item['name']!.toUpperCase(),
                      call: () {
                        setState(() {
                          country = item['code'];
                          cName = item['name'];
                        });
                        getNews();
                      },
                    ),
                ],
              ),
              ExpansionTile(
                title: const Text('Category'),
                children: [
                  for (final item in listOfCategory)
                    DropDownList(
                      name: item['name']!.toUpperCase(),
                      call: () {
                        setState(() => category = item['code']);
                        getNews();
                      },
                    ),
                ],
              ),
              ExpansionTile(
                title: const Text('Channel'),
                children: [
                  for (final item in listOfNewsChannel)
                    DropDownList(
                      name: item['name']!.toUpperCase(),
                      call: () {
                        setState(() {
                          country = null;
                          category = null;
                        });
                        getNews(channel: item['code']);
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
        body: notFound
            ? const Center(
                child: Text('Not Found', style: TextStyle(fontSize: 30)))
            : news.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.purple))
                : ListView.builder(
                    controller: controller,
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      final article = news[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          color: const Color.fromARGB(255, 186, 222, 255),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) =>
                                      ArticalNews(newsUrl: article['url']),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                children: [
                                  Text(
                                    article['title'] ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  if (index == news.length - 1 && isLoading)
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: CircularProgressIndicator(),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
