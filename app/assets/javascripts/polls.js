document.addEventListener('DOMContentLoaded', function () {
  let before = document.getElementById("article_poll_area");
  if(!before) { return;}
  let iframe = document.createElement("iframe");
  iframe.style = "border: none;"
  iframe.id = "myframe";
  iframe.width = "100%";
  iframe.height = 220;
  let html = `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <style>
  ul {
    padding: 0;
    position: relative;
  }

  ul li {
    border: solid 1px #2d8fdd;
    background: #f1f8ff;
    margin-bottom: 3px;
    line-height: 1.5;
    padding: 0.5em;
    list-style-type: none;
  }
  </style>
</head>
<body>
  <h3>この記事は参考になりましたか？</h3>
  <ul id="votes">
    <li>
      <input type="button" value="投票" onclick="window.parent.vote('1')">
      <span class="vote_label">役に立った</span>
    </li>
    <li>
      <input type="button" value="投票" onclick="window.parent.vote('-1')">
      <span class"vote_label">役に立たなかった</span>
    </li>
    <li>
      <input type="button" value="投票" onclick="window.parent.vote('0')">
      <span class="vote_label">どちらでもない</span>
    </li>
  </ul>
</body>
</html>
  `;
  let blob = new Blob([html], { type: 'text/html' });
  iframe.src = URL.createObjectURL(blob);
  before.parentNode.replaceChild(iframe, before);
  
})

function RandId() {
  const today = new Date();
  const yyyy = today.getFullYear();
  let dd = today.getDate();
  let mm = today.getMonth()+1;
  
  if(dd<10) {
      dd = '0'+dd
  } 
  
  if(mm<10) {
      mm = '0'+mm
  } 
  
  const max = 100000;
  const min = 999999;
  const rand = Math.floor( Math.random() * (max + 1 - min) ) + min ;
  return yyyy+mm+dd+rand;
}


function vote(value) {
  var json = {vote: {}};
  json.vote.user_id = setUserId();
  json.vote.value = value;
  json.vote.url = parent.location.href; // TODO:確認
  
  var xhr = new XMLHttpRequest();
  xhr.open("POST", "http://vote.turai.work/api/votes");

  xhr.addEventListener("progress", function(){}); // 通信中
  xhr.addEventListener("load", function(){}); // 通信成功
  xhr.addEventListener("error", function(){}); // 通信失敗
  xhr.addEventListener("abort", function(){}); // 通信をキャンセル

  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.send(JSON.stringify(json));
  
  let nodes = document.getElementById("myframe").contentDocument.querySelectorAll('input[type=button]');
  Array.prototype.forEach.call (nodes, function (elm) {
    elm.disabled = "true";
    elm.value = "投票ありがとうございました";
  });

}

function setUserId() {
  let id = '';
  const cookie_key = "polls_uid";
  document.cookie.split(';').forEach(function(item) {
    console.log(item)
    const ck = item.split('=');
    if (ck[0] == cookie_key) {
      id = ck[1];
    }
  });
  id = id || RandId();
  document.cookie = cookie_key+'='+id;
  return id;
}
