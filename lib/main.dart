import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = '''/// Provides a heuristic to determine if expensive frame-bound tasks should be
/// deferred.
///
/// The velocity parameter must not be null, but may be positive, negative, or
/// zero.
///
/// The metrics parameter must not be null.
///
/// The context parameter must not be null. It normally refers to the
/// [BuildContext] of the widget making the call, such as an [Image] widget
/// in a [ListView].
///
/// This can be used to determine whether decoding or fetching complex data
/// for the currently visible part of the viewport should be delayed
/// to avoid doing work that will not have a chance to appear before a new
/// frame is rendered.
///
/// For example, a list of images could use this logic to delay decoding
/// images until scrolling is slow enough to actually render the decoded
/// image to the screen.
///
/// The default implementation is a heuristic that compares the current
/// scroll velocity in local logical pixels to the longest side of the window
/// in physical pixels. Implementers can change this heuristic by overriding
/// this method and providing their custom physics to the scrollable widget.
/// For example, an application that changes the local coordinate system with
/// a large perspective transform could provide a more or less aggressive
/// heuristic depending on whether the transform was increasing or decreasing
/// the overall scale between the global screen and local scrollable
/// coordinate systems.
///
/// The default implementation is stateless, and simply provides a point-in-
/// time decision about how fast the scrollable is scrolling. It would always
/// return true for a scrollable that is animating back and forth at high
/// velocity in a loop. It is assumed that callers will handle such
/// a case, or that a custom stateful implementation would be written that
/// tracks the sign of the velocity on successive calls.
///
/// Returning true from this method indicates that the current scroll velocity
/// is great enough that expensive operations impacting the UI should be
/// deferred.
bool recommendDeferredLoading(double velocity, ScrollMetrics metrics, BuildContext context) {
  assert(velocity != null);
  assert(metrics != null);
  assert(context != null);
  if (parent == null) {
    final double maxPhysicalPixels = WidgetsBinding.instance.window.physicalSize.longestSide;
    return velocity.abs() > maxPhysicalPixels;
  }
  return parent!.recommendDeferredLoading(velocity, metrics, context);
}''';

  @override
  Widget build(BuildContext context) {
    /// Controller for TextField example below
    TextEditingController controller = TextEditingController(text: value);

    /// NOTES:
    /// 1. Dragging to select text within the bounds of what's currently in frame works fine ✅
    /// 2. Dragging to select text in the down direction works fine ✅
    /// 3. Dragging to select text in the up direction fails ❌
    /// 3. Dragging to select text horizontally beyond the bounds of what's in frame fails ❌
    ///
    ///
    /// **Use cases for this to work properly**:
    /// 1. Building a code editor or app that renders code with toggleable word-wrap
    /// 2. Building a rich text editor or app that renders rich text with toggleable word-wrap
    ///
    ///
    /// ========== Simple Setup Using SelectableText ============ ///
    ///
    ///
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Input Selection'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 250,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SelectableText(value),
          ),
        ),
      ),
    );

    /// ========== Alternative Setup Using TextField ============ ///
    ///
    ///
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Flutter Input Selection'),
    //   ),
    //   body: Center(
    //     /// Constraints in the X & Y direction
    //     child: SizedBox(
    //       width: 400,
    //       height: 250,
    //       child: Row(
    //         children: [
    //           /// The goal here is for the text within the text editor to stretch it's full height & width
    //           /// without wrapping, thus creating a horizontal and vertical overflow
    //           Expanded(
    //             /// This of course creates the ability to scroll horizontally
    //             child: SingleChildScrollView(
    //               scrollDirection: Axis.horizontal,
    //
    //               /// Enables the column to stretch the full width of the child
    //               child: IntrinsicWidth(
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.stretch,
    //                   children: [
    //                     /// Lets the text stretch as far vertically as possible
    //                     Expanded(
    //                       child: TextField(
    //                         controller: controller,
    //                         expands: true,
    //                         maxLines: null,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
