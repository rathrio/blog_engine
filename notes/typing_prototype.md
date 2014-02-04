title: Typing Prototype
author: radi
date: 2014-02-04
tags: orange, game, javascript

These are the first steps to some kind of typing trainer. The final vision is a
combat system that takes dynamic natural language as an input and converts it to
actions (fast). Dynamic because it depends on naming of enemies, commands etc.

In the following demo, it is expected that the user types the word above the
input field. If the input matches, an alert will be triggered. Reload the page
to randomise the expected command.

__DEMO__

<script>
  window.onload = function() {
    var game = typing();
    var inputField = document.getElementById("typing-userinput");
    var cmdDisplayField = document.getElementById("typing-cmddisplay");

    cmdDisplayField.innerHTML = game.getCurrentCMD();
    inputField.addEventListener("input", function(e) {
      if (game.cmdMatches(inputField.value)) {
        alert("INPUT MATCHES!");
      }
    });
  }

  // Constructor function
  var typing = function() {
    var CMDS = ["punch", "kick", "kamehameha", "shoot"];
    var currentCMD = null;

    var setRandomCMD = function() {
      currentCMD = CMDS[Math.floor(Math.random()*CMDS.length)];
    }

    return {
      getCurrentCMD: function() {
        if (currentCMD == null) {
          setRandomCMD();
        }
        return currentCMD;
      },

      cmdMatches: function(string) {
        return string == currentCMD;
      }
    }
  }
</script>

<div id="typing-cmddisplay"></div>
<input type="text" id="typing-userinput">


__index.html__

```html
<!doctype html>
<meta charset=utf-8>
<html>
  <head>
    <script src="typing.js"></script>
  </head>
  <body>
    <div id="typing-cmddisplay"></div>
    <input type="text" id="typing-userinput">
  </body>
</html>
```

__typing.js__

```javascript
window.onload = function() {
  var game = typing();
  var inputField = document.getElementById("typing-userinput");
  var cmdDisplayField = document.getElementById("typing-cmddisplay");

  cmdDisplayField.innerHTML = game.getCurrentCMD();
  inputField.addEventListener("input", function(e) {
    if (game.cmdMatches(inputField.value)) {
      alert("INPUT MATCHES!");
    }
  });
}

// Constructor function
var typing = function() {
  var CMDS = ["punch", "kick", "kamehameha", "shoot"];
  var currentCMD = null;

  var setRandomCMD = function() {
    currentCMD = CMDS[Math.floor(Math.random()*CMDS.length)];
  }

  return {
    getCurrentCMD: function() {
      if (currentCMD == null) {
        setRandomCMD();
      }
      return currentCMD;
    },

    cmdMatches: function(string) {
      return string == currentCMD;
    }
  }
}
```

__Frog Fractions__

I just recently stumbled upon the fantastic
[frog fractions](http://twinbeard.com/frog-fractions). The "frog fractions
teaches typing" and zork sections are something I could take a page from.
