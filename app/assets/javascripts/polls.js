document.addEventListener('DOMContentLoaded', function () {
  let before = document.getElementById("article_poll_area");
  if(!before) { return;}
  let iframe = document.createElement("iframe");
  iframe.style = "border: none;"
  iframe.id = "myframe";
  iframe.width = "100%";
  iframe.height = 220;
  iframe.src = "http://vote.turai.work/iframes/?group_id=1&url="+location.href;
  before.parentNode.replaceChild(iframe, before);
});
