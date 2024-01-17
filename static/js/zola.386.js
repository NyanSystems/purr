_386 = { 
  fastLoad: false,
  onePass: true,
  speedFactor: 3
};

document.addEventListener('DOMContentLoaded', function() {
  var rainbowText = document.querySelector('.brand');
  var text = rainbowText.innerText;
  rainbowText.innerText = '';
  for (var i = 0; i < text.length; i++) {
    var charElem = document.createElement('span');
    charElem.innerText = text[i];
    rainbowText.appendChild(charElem);
  }
});