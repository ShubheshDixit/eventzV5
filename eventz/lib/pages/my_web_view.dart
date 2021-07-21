import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:html' as html;

// class MyWebView extends StatefulWidget {
//   final String title;
//   final String selectedUrl;

//   MyWebView({
//     @required this.title,
//     @required this.selectedUrl,
//   });

//   @override
//   _MyWebViewState createState() => _MyWebViewState();
// }

// class _MyWebViewState extends State<MyWebView> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();
//   WebViewController _webViewController;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await _webViewController.canGoBack()) {
//           await _webViewController.goBack();
//           return false;
//         } else {
//           Navigator.pop(context);
//           return false;
//         }
//       },
//       child: Scaffold(
//           body: WebView(
//         initialUrl: widget.selectedUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller.complete(webViewController);
//           setState(() {
//             _webViewController = webViewController;
//           });
//         },
//       )),
//     );
//   }
// }

class MyWebView extends StatefulWidget {
  final String title;
  final String url;

  const MyWebView({Key key, this.url, this.title}) : super(key: key);
  @override
  _MyWebViewState createState() => new _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController?.canGoBack()) {
          webViewController.goBack();
          return false;
        } else {
          Navigator.pop(context);
          return true;
        }
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
            height: constraints.maxHeight,
            child: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 65.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Stack(
                            children: [
                              InAppWebView(
                                key: webViewKey,
                                initialUrlRequest:
                                    URLRequest(url: Uri.parse(widget.url)),
                                initialOptions: options,
                                pullToRefreshController:
                                    pullToRefreshController,
                                onWebViewCreated: (controller) {
                                  webViewController = controller;
                                },
                                onLoadStart: (controller, url) {
                                  setState(() {
                                    this.url = url.toString();
                                    urlController.text = this.url;
                                  });
                                },
                                androidOnPermissionRequest:
                                    (controller, origin, resources) async {
                                  return PermissionRequestResponse(
                                      resources: resources,
                                      action: PermissionRequestResponseAction
                                          .GRANT);
                                },
                                shouldOverrideUrlLoading:
                                    (controller, navigationAction) async {
                                  var uri = navigationAction.request.url;

                                  if (![
                                    "http",
                                    "https",
                                    "file",
                                    "chrome",
                                    "data",
                                    "javascript",
                                    "about"
                                  ].contains(uri.scheme)) {
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                      );
                                      // and cancel the request
                                      return NavigationActionPolicy.CANCEL;
                                    }
                                  }

                                  return NavigationActionPolicy.ALLOW;
                                },
                                onLoadStop: (controller, url) async {
                                  pullToRefreshController.endRefreshing();
                                  setState(() {
                                    this.url = url.toString();
                                    urlController.text = this.url;
                                  });
                                },
                                onLoadError: (controller, url, code, message) {
                                  pullToRefreshController.endRefreshing();
                                },
                                onProgressChanged: (controller, progress) {
                                  if (progress == 100) {
                                    pullToRefreshController.endRefreshing();
                                  }
                                  setState(() {
                                    this.progress = progress / 100;
                                    urlController.text = this.url;
                                  });
                                },
                                onUpdateVisitedHistory:
                                    (controller, url, androidIsReload) {
                                  setState(() {
                                    this.url = url.toString();
                                    urlController.text = this.url;
                                  });
                                },
                                onConsoleMessage: (controller, consoleMessage) {
                                  print(consoleMessage);
                                },
                              ),
                              progress < 1.0
                                  ? LinearProgressIndicator(
                                      value: progress,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    // color: Colors.black.withOpacity(0.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            webViewController?.goBack();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            webViewController?.goForward();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            webViewController?.reload();
                          },
                        ),
                        // Flexible(
                        //   child: Container(
                        //     margin:
                        //         EdgeInsets.only(right: 10, top: 5, bottom: 5),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(25),
                        //       color: Colors.grey[900],
                        //     ),
                        //     padding: EdgeInsets.symmetric(horizontal: 8.0),
                        //     child: TextField(
                        //       style: TextStyle(color: Colors.white),
                        //       decoration:
                        //           InputDecoration(border: InputBorder.none),
                        //       controller: urlController,
                        //       keyboardType: TextInputType.url,
                        //       onSubmitted: (value) {
                        //         var url = Uri.parse(value);
                        //         if (url.scheme.isEmpty) {
                        //           url = Uri.parse(
                        //               "https://www.google.com/search?q=" +
                        //                   value);
                        //         }
                        //         webViewController?.loadUrl(
                        //             urlRequest: URLRequest(url: url));
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class WebViewWeb extends StatefulWidget {
//   final String title, url;
//   const WebViewWeb({Key key, this.title, this.url}) : super(key: key);

//   @override
//   _WebViewWebState createState() => _WebViewWebState();
// }

// class _WebViewWebState extends State<WebViewWeb> {
//   final _webViewPlugin = FlutterWebviewPlugin();

//   @override
//   void initState() {
//     super.initState();
//     // on pressing back button, exiting the screen instead of showing loading symbol
//     _webViewPlugin.onDestroy.listen((_) {
//       if (Navigator.canPop(context)) {
//         // exiting the screen
//         Navigator.of(context).pop();
//       }
//     });
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//         'hello-world-html',
//         (int viewId) => html.IFrameElement()
//           ..width = '640'
//           ..height = MediaQuery.of(context).size.height.toString()
//           ..src = widget.url
//           ..style.border = 'none');
//   }

//   @override
//   Widget build(BuildContext context) {
//     // WillPopScope will prevent loading
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: SizedBox(
//         width: 640,
//         height: 360,
//         child: HtmlElementView(viewType: 'hello-world-html'),
//       ),
//     );
//   }
// }
