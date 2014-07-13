title: VII. Hide Yo Functions
author: radi
date: 2014-07-14
tags: javascript, encapsulation

When it comes to encapsulation in our Javascript code we prominently use self-invoking
functions. Sometimes anonymous:

```javascript
(function() {
  var superSecretFunction = function() {
    // ...
  }

  // Super generic handler name that might clash with other functions.
  var handleClickOnSomeDiv = function() {
    // ...
  }

  $(document).on('ready pjax:success', function() {
    $(document).off("click", handleClickOnSomeDiv);
    $(document).on("click", ".someDiv",handleClickOnSomeDiv);
  })
})();
```

and sometimes, if required, not so anonymous:


```javascript
Styles = function() {

  var privateFunction = function() {
    // ...
  }

  return {
    // Usually called initialize, because we do some setup like attaching a
    // bunch of handlers etc.
    publicFunction: function() {
      var bla = privateFunction();
      // ...
    }
  }
}();

$(document).on('ready pjax:success', function() {
  Styles.publicFunction();
})
```

**Further reading**

* <a href="http://www.adequatelygood.com/JavaScript-Module-Pattern-In-Depth.html" target="_blank">In Depth Description of the Module Pattern</a>
* <a href="http://www.amazon.co.uk/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742/ref=sr_1_1?ie=UTF8&qid=1405262775&sr=8-1&keywords=javascript+the+good+parts" target="_blank">Javascript Bible</a>
