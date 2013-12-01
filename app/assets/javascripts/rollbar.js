/* try {
    doSomething();
} catch (e) {
    _rollbar.push(e);
} */

var _rollbarParams = {"server.environment": "production"};
_rollbarParams["notifier.snippet_version"] = "2"; var _rollbar=["9b3ac1d5eda84acc90a167395ba5b1ef", _rollbarParams]; var _ratchet=_rollbar;
(function(w,d){w.onerror=function(e,u,l,c,err){_rollbar.push({_t:'uncaught',e:e,u:u,l:l,c:c,err:err});};var i=function(){var s=d.createElement("script");var
 f=d.getElementsByTagName("script")[0];s.src="//d37gvrvc0wt4s1.cloudfront.net/js/1/rollbar.min.js";s.async=!0;
 f.parentNode.insertBefore(s,f);};if(w.addEventListener){w.addEventListener("load",i,!1);}else{w.attachEvent("onload",i);}})(window,document);

 // Enable jQuery alerting for Rollbar; load after jQuery
(function(r,e,a){if(!e._rollbar){return}var n={"notifier.plugins.jquery.version":"0.0.5"};e._rollbar.push({_rollbarParams:n});var u=function(r){if(e.console){e.console.log(r.message+" [reported to Rollbar]")}};r(a).ajaxError(function(r,a,n,u){var l=a.status;var t=n.url;e._rollbar.push({level:"warning",msg:"jQuery ajax error for url "+t,jquery_status:l,jquery_url:t,jquery_thrown_error:u,jquery_ajax_error:true})});var l=r.fn.ready;r.fn.ready=function(r){return l.call(this,function(){try{r()}catch(a){e._rollbar.push(a);u(a)}})};var t=r.event.add;r.event.add=function(a,n,l,o,i){var s;var d=function(r){return function(){try{return r.apply(this,arguments)}catch(a){e._rollbar.push(a);u(a)}}};if(l.handler){s=l.handler;l.handler=d(l.handler)}else{s=l;l=d(l)}if(s.guid){l.guid=s.guid}else{l.guid=s.guid=r.guid++}return t.call(this,a,n,l,o,i)}})(jQuery,window,document);

