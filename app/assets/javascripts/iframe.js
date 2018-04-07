//= require rails-ujs

document.addEventListener('ajax:success', function (e) {
});

document.addEventListener('ajax:error', function (e) {
});

document.addEventListener('ajax:complete', function(e) {
  let nodes = document.querySelectorAll('button');
  Array.prototype.forEach.call (nodes, function (elm) {
    elm.disabled = "true";
    elm.innerHTML = "投票ありがとうございました";
  });
});