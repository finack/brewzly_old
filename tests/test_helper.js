document.write('<div id="ember-testing-container"><div id="ember-testing"></div></div>');

Ember.testing = true;

window.startApp          = require('brewzly/tests/helpers/start_app')['default'];
window.isolatedContainer = require('brewzly/tests/helpers/isolated_container')['default'];

function exists(selector) {
  return !!find(selector).length;
}

function getAssertionMessage(actual, expected, message) {
  return message || QUnit.jsDump.parse(expected) + " expected but was " + QUnit.jsDump.parse(actual);
}

function equal(actual, expected, message) {
  message = getAssertionMessage(actual, expected, message);
  QUnit.equal.call(this, actual, expected, message);
}

function strictEqual(actual, expected, message) {
  message = getAssertionMessage(actual, expected, message);
  QUnit.strictEqual.call(this, actual, expected, message);
}

window.exists = exists;
window.equal = equal;
window.strictEqual = strictEqual;

function stubEndpointForHttpRequest(url, json) {
  $.mockjax({
    url: url,
    dataType: 'json',
    responseText: json
  });
}

// $.mockjaxSettings.logging = false;
// $.mockjaxSettings.responseTime = 0;
