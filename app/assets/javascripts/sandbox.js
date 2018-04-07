document.addEventListener('DOMContentLoaded', function () {
  console.log(1)
  let before = document.getElementById("main");
  let iframe = document.createElement("iframe");
  iframe.id = "myframe";
  iframe.width = 700;
  iframe.height = 200;
    
  let html = `
    <h3>この記事は参考になりましたか？</h3>
    <label>このページの情報は役に立った</label>
    <input type="button" value="投票" onclick="window.parent.vote('1')">
    <label>このページの情報は役に立たなかった</label>
    <input type="button" value="投票" onclick="window.parent.vote('-1')">
    <label>どちらでもない</label>
    <input type="button" value="投票" onclick="window.parent.vote('0')">
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
  debugger
  
  var xhr = new XMLHttpRequest();
  xhr.open("POST", "http://localhost:3000/api/votes");

  xhr.addEventListener("progress", function(){}); // 通信中
  xhr.addEventListener("load", function(){}); // 通信成功
  xhr.addEventListener("error", function(){}); // 通信失敗
  xhr.addEventListener("abort", function(){}); // 通信をキャンセル

  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.send(JSON.stringify(json));
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
