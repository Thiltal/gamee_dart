//// Copyright (c) 2016, Zdeněk Mlčoch. All rights reserved. Use of this source code
//// is governed by a BSD-style license that can be found in the LICENSE file.
//
//library gamee.base;
//import "dart:html";
//import "dart:js";
//
///// Checks if you are awesome. Spoiler: you are.
//abstract class GameeNative {
//  static const String type = 'no-gamee';
//  void updateScore(String score);
//  /** ### requestController
//   * Request controller.
//   *
//   * *see also
//   * [gamee.controller.requestController](controller.js.html#requestcontroller)*
//   */
//  void requestController(String type);
//  /** ### additionalController
//   * Request additional controller (for desktop).
//   *
//   * *see also
//   * [gamee.controller.additionalController](controller.js.html#additionalcontroller)*
//   */
//  void additionalController(String type);
//  /** ### gameOver
//   * Game over.
//   *
//   * *see also
//   * [gamee.gameOver](gamee.js.html#gamee.gameover)
//   */
//  void gameOver();
//  /** ### gameStart
//   * Game start.
//   *
//   * *see also
//   * [gamee.gameStart](gamee.js.html#gamee.gamestart)
//   */
//  void gameStart();
//  void gameLoaded();
//  void gamePaused();
//}
///* current user agent */
//String get userAgent=>window.navigator.userAgent.toLowerCase();
//
///**
// * Gamee Mobile App
// */
//class GameeMobile extends GameeNative{
//  @override
//  static const String type = 'gamee-mobile';
//
//  @override
//  void additionalController(String type) {
//
//  }
//
//  @override
//  void gameLoaded() {
//    window.location.href = "gamee://game-loaded";
//  }
//
//  @override
//  void gameOver() {
//    window.location.href = "gamee://game-over";
//  }
//
//  @override
//  void gameStart() {
//    window.location.href = "gamee://game-start";
//  }
//
//  @override
//  void requestController(String type) {
//    window.location.href = "gamee://request-controller/" + type;
//  }
//
//  @override
//  void updateScore(String score) {
//    window.location.href = "gamee://score/" + score;
//  }
//
//  @override
//  void gamePaused() {
//    // TODO: implement gamePaused
//  }
//}
//
//class GameeSimulator extends GameeNative{
//  JsObject get simulator=>context["parent"]["gameeSimulator"];
//
//  @override
//  void additionalController(String type) {
//    simulator.callMethod("additionalController",[type]);
//  }
//
//  @override
//  void gameLoaded() {
//    simulator.callMethod("gameLoaded",[]);
//  }
//
//  @override
//  void gameOver() {
//    simulator.callMethod("gameOver",[]);
//  }
//
//  @override
//  void gameStart() {
//    simulator.callMethod("gameStart",[]);
//  }
//
//  @override
//  void requestController(String type) {
//    simulator.callMethod("requestController",[type]);
//  }
//
//  @override
//  void updateScore(String score) {
//    simulator.callMethod("updateScore",[score]);
//  }
//
//  @override
//  void gamePaused() {
//    // TODO: implement gamePaused
//  }
//}
//
//class GameeWebApp extends GameeNative{
//  WindowBase gamee = window.parent;
//
//  @override
//  void additionalController(String type) {
//    gamee.postMessage(['additional-controller', type], '*');
//  }
//
//  @override
//  void gameLoaded() {
//    gamee.postMessage(['game-loaded'], '*');
//  }
//
//  @override
//  void gameOver() {
//    gamee.postMessage(['game-over'], '*');
//  }
//
//  @override
//  void gameStart() {
//    gamee.postMessage(['game-start'], '*');
//  }
//
//  @override
//  void requestController(String type) {
//    gamee.postMessage(['request-controller', type], '*');
//  }
//
//  @override
//  void updateScore(String score) {
//    gamee.postMessage(["score", score], '*');
//  }
//
//  @override
//  void gamePaused() {
//    gamee.postMessage(['game-paused'], '*');
//  }
//}
//
//GameeNative getGamee(){
//  RegExp testAndroid = new RegExp(r"gamee\/[0-9\.]+$");
//  RegExp testIOs = new RegExp(r"iphone|ipod|ipad");
//
//  Navigator navigator = window.navigator;
//  if(testAndroid.hasMatch(navigator.userAgent) || testIOs.hasMatch(navigator.userAgent)){
//    return new GameeMobile();
//  }
//
//  if(window.parent!=null && context["parent"]["gameeSimulator"].toString()!="undefined"){
//    return new GameeSimulator();
//  }
//
//  if(window.parent!=null){
//    return new GameeWebApp();
//  }
//
//  throw new Exception('No gamee enviroment matched');
//}