/**
* Unobtrusive scripting adapter for jQuery
*
* Requires jQuery 1.4.3 or later.
* https://github.com/rails/jquery-ujs
*/

(function($) {
// Make sure that every Ajax request sends the CSRF token
function CSRFProtection(fn) {
var token = $('meta[name="csrf-token"]').attr('content');
if (token) fn(function(xhr) { xhr.setRequestHeader('X-CSRF-Token', token) });
}
if ($().jquery == '1.5') { // gruesome hack
var factory = $.ajaxSettings.xhr;
$.ajaxSettings.xhr = function() {
var xhr = factory();
CSRFProtection(function(setHeader) {
var open = xhr.open;
xhr.open = function() { open.apply(this, arguments); setHeader(this) };
});
return xhr;
};
}
else $(document).ajaxSend(function(e, xhr) {
CSRFProtection(function(setHeader) { setHeader(xhr) });
});

// Triggers an event on an element and returns the event result
function fire(obj, name, data) {
var event = new $.Event(name);
obj.trigger(event, data);
return event.result !== false;
}

// Submits "remote" forms and links with ajax
function handleRemote(element) {
var method, url, data,
dataType = element.attr('data-type') || ($.ajaxSettings && $.ajaxSettings.dataType);

if (element.is('form')) {
method = element.attr('method');
url = element.attr('action');
data = element.serializeArray();
// memoized value from clicked submit button
var button = element.data('ujs:submit-button');
if (button) {
data.push(button);
element.data('ujs:submit-button', null);
}
} else {
method = element.attr('data-method');
url = element.attr('href');
data = null;
}

$.ajax({
url: url, type: method || 'GET', data: data, dataType: dataType,
// stopping the "ajax:beforeSend" event will cancel the ajax request
beforeSend: function(xhr, settings) {
if (settings.dataType === undefined) {
xhr.setRequestHeader('accept', '*/*;q=0.5, ' + settings.accepts.script);
}
return fire(element, 'ajax:beforeSend', [xhr, settings]);
},
success: function(data, status, xhr) {
element.trigger('ajax:success', [data, status, xhr]);
},
complete: function(xhr, status) {
element.trigger('ajax:complete', [xhr, status]);
},
error: function(xhr, status, error) {
element.trigger('ajax:error', [xhr, status, error]);
}
});
}

// Handles "data-method" on links such as:
// <a href="/users/5" data-method="delete" rel="nofollow" data-confirm="Are you sure?">Delete</a>
function handleMethod(link) {
var href = link.attr('href'),
method = link.attr('data-method'),
csrf_token = $('meta[name=csrf-token]').attr('content'),
csrf_param = $('meta[name=csrf-param]').attr('content'),
form = $('<form method="post" action="' + href + '"></form>'),
metadata_input = '<input name="_method" value="' + method + '" type="hidden" />';

if (csrf_param !== undefined && csrf_token !== undefined) {
metadata_input += '<input name="' + csrf_param + '" value="' + csrf_token + '" type="hidden" />';
}

form.hide().append(metadata_input).appendTo('body');
form.submit();
}

function disableFormElements(form) {
form.find('input[data-disable-with]').each(function() {
var input = $(this);
input.data('ujs:enable-with', input.val())
.val(input.attr('data-disable-with'))
.attr('disabled', 'disabled');
});
}

function enableFormElements(form) {
form.find('input[data-disable-with]').each(function() {
var input = $(this);
input.val(input.data('ujs:enable-with')).removeAttr('disabled');
});
}

function allowAction(element) {
var message = element.attr('data-confirm');
return !message || (fire(element, 'confirm') && confirm(message));
}

function requiredValuesMissing(form) {
var missing = false;
form.find('input[name][required]').each(function() {
if (!$(this).val()) missing = true;
});
return missing;
}

$('a[data-confirm], a[data-method], a[data-remote]').live('click.rails', function(e) {
var link = $(this);
if (!allowAction(link)) return false;

if (link.attr('data-remote') != undefined) {
handleRemote(link);
return false;
} else if (link.attr('data-method')) {
handleMethod(link);
return false;
}
});

$('form').live('submit.rails', function(e) {
var form = $(this), remote = form.attr('data-remote') != undefined;
if (!allowAction(form)) return false;

// skip other logic when required values are missing
if (requiredValuesMissing(form)) return !remote;

if (remote) {
handleRemote(form);
return false;
} else {
// slight timeout so that the submit button gets properly serialized
setTimeout(function(){ disableFormElements(form) }, 13);
}
});

$('form input[type=submit], form button[type=submit], form button:not([type])').live('click.rails', function() {
var button = $(this);
if (!allowAction(button)) return false;
// register the pressed submit button
var name = button.attr('name'), data = name ? {name:name, value:button.val()} : null;
button.closest('form').data('ujs:submit-button', data);
});

$('form').live('ajax:beforeSend.rails', function(event) {
if (this == event.target) disableFormElements($(this));
});

$('form').live('ajax:complete.rails', function(event) {
if (this == event.target) enableFormElements($(this));
});
})( jQuery );








// (function() {
//   // Technique from Juriy Zaytsev
//   // http://thinkweb2.com/projects/prototype/detecting-event-support-without-browser-sniffing/
//   function isEventSupported(eventName) {
//     var el = document.createElement('div');
//     eventName = 'on' + eventName;
//     var isSupported = (eventName in el);
//     if (!isSupported) {
//       el.setAttribute(eventName, 'return;');
//       isSupported = typeof el[eventName] == 'function';
//     }
//     el = null;
//     return isSupported;
//   }
// 
//   function isForm(element) {
//     return Object.isElement(element) && element.nodeName.toUpperCase() == 'FORM'
//   }
// 
//   function isInput(element) {
//     if (Object.isElement(element)) {
//       var name = element.nodeName.toUpperCase()
//       return name == 'INPUT' || name == 'SELECT' || name == 'TEXTAREA'
//     }
//     else return false
//   }
// 
//   var submitBubbles = isEventSupported('submit'),
//       changeBubbles = isEventSupported('change')
// 
//   if (!submitBubbles || !changeBubbles) {
//     // augment the Event.Handler class to observe custom events when needed
//     Event.Handler.prototype.initialize = Event.Handler.prototype.initialize.wrap(
//       function(init, element, eventName, selector, callback) {
//         init(element, eventName, selector, callback)
//         // is the handler being attached to an element that doesn't support this event?
//         if ( (!submitBubbles && this.eventName == 'submit' && !isForm(this.element)) ||
//              (!changeBubbles && this.eventName == 'change' && !isInput(this.element)) ) {
//           // "submit" => "emulated:submit"
//           this.eventName = 'emulated:' + this.eventName
//         }
//       }
//     )
//   }
// 
//   if (!submitBubbles) {
//     // discover forms on the page by observing focus events which always bubble
//     document.on('focusin', 'form', function(focusEvent, form) {
//       // special handler for the real "submit" event (one-time operation)
//       if (!form.retrieve('emulated:submit')) {
//         form.on('submit', function(submitEvent) {
//           var emulated = form.fire('emulated:submit', submitEvent, true)
//           // if custom event received preventDefault, cancel the real one too
//           if (emulated.returnValue === false) submitEvent.preventDefault()
//         })
//         form.store('emulated:submit', true)
//       }
//     })
//   }
// 
//   if (!changeBubbles) {
//     // discover form inputs on the page
//     document.on('focusin', 'input, select, texarea', function(focusEvent, input) {
//       // special handler for real "change" events
//       if (!input.retrieve('emulated:change')) {
//         input.on('change', function(changeEvent) {
//           input.fire('emulated:change', changeEvent, true)
//         })
//         input.store('emulated:change', true)
//       }
//     })
//   }
// 
//   function handleRemote(element) {
//     var method, url, params;
// 
//     var event = element.fire("ajax:before");
//     if (event.stopped) return false;
// 
//     if (element.tagName.toLowerCase() === 'form') {
//       method = element.readAttribute('method') || 'post';
//       url    = element.readAttribute('action');
//       params = element.serialize();
//     } else {
//       method = element.readAttribute('data-method') || 'get';
//       url    = element.readAttribute('href');
//       params = {};
//     }
// 
//     new Ajax.Request(url, {
//       method: method,
//       parameters: params,
//       evalScripts: true,
// 
//       onComplete:    function(request) { element.fire("ajax:complete", request); },
//       onSuccess:     function(request) { element.fire("ajax:success",  request); },
//       onFailure:     function(request) { element.fire("ajax:failure",  request); }
//     });
// 
//     element.fire("ajax:after");
//   }
// 
//   function handleMethod(element) {
//     var method = element.readAttribute('data-method'),
//         url = element.readAttribute('href'),
//         csrf_param = $$('meta[name=csrf-param]')[0],
//         csrf_token = $$('meta[name=csrf-token]')[0];
// 
//     var form = new Element('form', { method: "POST", action: url, style: "display: none;" });
//     element.parentNode.insert(form);
// 
//     if (method !== 'post') {
//       var field = new Element('input', { type: 'hidden', name: '_method', value: method });
//       form.insert(field);
//     }
// 
//     if (csrf_param) {
//       var param = csrf_param.readAttribute('content'),
//           token = csrf_token.readAttribute('content'),
//           field = new Element('input', { type: 'hidden', name: param, value: token });
//       form.insert(field);
//     }
// 
//     form.submit();
//   }
// 
// 
//   document.on("click", "*[data-confirm]", function(event, element) {
//     var message = element.readAttribute('data-confirm');
//     if (!confirm(message)) event.stop();
//   });
// 
//   document.on("click", "a[data-remote]", function(event, element) {
//     if (event.stopped) return;
//     handleRemote(element);
//     event.stop();
//   });
// 
//   document.on("click", "a[data-method]", function(event, element) {
//     if (event.stopped) return;
//     handleMethod(element);
//     event.stop();
//   });
// 
//   document.on("submit", function(event) {
//     var element = event.findElement(),
//         message = element.readAttribute('data-confirm');
//     if (message && !confirm(message)) {
//       event.stop();
//       return false;
//     }
// 
//     var inputs = element.select("input[type=submit][data-disable-with]");
//     inputs.each(function(input) {
//       input.disabled = true;
//       input.writeAttribute('data-original-value', input.value);
//       input.value = input.readAttribute('data-disable-with');
//     });
// 
//     var element = event.findElement("form[data-remote]");
//     if (element) {
//       handleRemote(element);
//       event.stop();
//     }
//   });
// 
//   document.on("ajax:after", "form", function(event, element) {
//     var inputs = element.select("input[type=submit][disabled=true][data-disable-with]");
//     inputs.each(function(input) {
//       input.value = input.readAttribute('data-original-value');
//       input.removeAttribute('data-original-value');
//       input.disabled = false;
//     });
//   });
// 
//   Ajax.Responders.register({
//     onCreate: function(request) {
//       var csrf_meta_tag = $$('meta[name=csrf-token]')[0];
// 
//       if (csrf_meta_tag) {
//         var header = 'X-CSRF-Token',
//             token = csrf_meta_tag.readAttribute('content');
// 
//         if (!request.options.requestHeaders) {
//           request.options.requestHeaders = {};
//         }
//         request.options.requestHeaders[header] = token;
//       }
//     }
//   });
// })();
