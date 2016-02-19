part of gamee;

class Gamee{
  JsObject gameeNative;
  List<Function> onRestart = [];
  List<Function> onPausedChange = [];
  List<Function> onMutedChange = [];
  List<Function> onScoreChanged = [];
  bool _paused = false;
  bool _muted = false;
  String _score;



  bool get paused => _paused;
  set paused(bool val){
    if(val==_paused)return;
    _paused = val;
    onPausedChange.forEach((f)=>f());
    if(_paused){
      gameeNative.callMethod("pause",[]);
    }else{
      gameeNative.callMethod("resume",[]);
    }
  }

  bool get muted => _muted;
  set muted(bool val){
    if(val==_muted)return;
    _muted = val;
    onMutedChange.forEach((f)=>f());
    if(_muted){
      gameeNative.callMethod("mute",[]);
    }else{
      gameeNative.callMethod("unmute",[]);
    }
  }

  String get score=>_score;
  set score(String val){
    if(_score==val)return;
    _score = val;
    onScoreChanged.forEach((f)=>f());
    gameeNative.callMethod("updateScore",[score]);
  }

  Gamee([this.gameeNative]){
    if(gameeNative==null){
      gameeNative = context[r"$gameeNative"];
    }
    window.onKeyDown.listen((KeyboardEvent e){
      if(e.keyCode==KeyCode.R){
        onRestart.forEach((f)=>f());
      }
      if(e.keyCode==KeyCode.P){
        paused = !paused;
      }
    });

    window.onMessage.listen((MessageEvent e){
      switch((e.data as List).first){
        case 'pause':
          _paused = true;
          onPausedChange.forEach((f)=>f());
          break;

        case 'resume':
          _paused = false;
          onPausedChange.forEach((f)=>f());
          break;

        case 'restart':
        // after restart we have to steal the focus from parent frame
          context.callMethod('focus');
          onRestart.forEach((f)=>f());
          break;

        case 'mute':
          _muted = true;
          onMutedChange.forEach((f)=>f());
          break;

        default:
          throw new Exception('Unknown message');
      }
    });
  }

  void additionalController(String type) {
    gameeNative.callMethod("additionalController",[type]);
  }

  void gameLoaded() {
    gameeNative.callMethod("gameLoaded",[]);
  }

  void gameOver() {
    gameeNative.callMethod("gameOver",[]);
  }

  void gameStart() {
    gameeNative.callMethod("gameStart",[]);
  }

  void requestController(String type) {
    gameeNative.callMethod("requestController",[type]);
  }

}