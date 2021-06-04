var timeout;
var opened;

var model;
var vehclass;

var parts;
var plate;
var repair;
var mileage;
var workshop;

var Parts = {};
var partType = '';
var allparts = {};

function closeMenu() {
  $.post('https://core_vehicle/close', JSON.stringify({}));


  $("#main_container").fadeOut(400);
  timeout = setTimeout(function () {
    $("#main_container").html("");
    $("#main_container").fadeIn();
  }, 400);


}

function replacePart(t) {

  var part = t.dataset.part;


  $.post('https://core_vehicle/replace', JSON.stringify({
    part: part,
    parttype: partType
  }));

  closeMenu();

}

function removePart() {


    

 $.post('https://core_vehicle/removePart', JSON.stringify({
    parttype: partType
  }));

      closeMenu();
  
}

function repairPart() {


  $.post('https://core_vehicle/repair', JSON.stringify({
    parttype: partType
  }));

  closeMenu();

}


function cancelRepair() {


  $.post('https://core_vehicle/cancelrepair', JSON.stringify({
  }));

  closeMenu();

}



function installPart(t) {

  var part = t.dataset.part;


  $.post('https://core_vehicle/install', JSON.stringify({
    part: part,
    parttype: partType
  }));

  closeMenu();

}

function openInstallPart() {

  $("#main_container").html('');


  var base = '<div class="clearfix slide-left borderbox" id="page"><!-- column -->' +
   '   <div class="clearfix colelem " onclick="openVehicleMenu()" id="back"><i class="fas fa-chevron-circle-left fa-lg"></i></div>' +
    '   <div class="clearfix colelem " id="pu378-4"><!-- group -->' +
    '    <div class="clearfix grpelem" id="u378-4"><!-- content -->' +
    '     <p>PARTS</p>' +
    '    </div>' +
    '   </div>' +
    '   <div class="rounded-corners colelem" id="u392" ><!-- simple frame --></div>' +

    '   <div class="clearfix colelem" id="pu126"><!-- group -->';

  for (const [key, value] of Object.entries(allparts[partType])) {


    base = base + '    <div class="gradient  grpelem part" onclick="installPart(this)" data-part="' + key + '" id="u126"><!-- column -->' +
      '     <div class="colelem" id="u247" style="background: url(img/' + key + '.png) no-repeat center; background-size: 90%; " data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- rasterized frame --></div>' +
      '     <div class="clearfix colelem" id="u148-4" data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- content -->' +
      '      <p>' + value.label + '</p>' +
      '     </div>' +
      '    </div>';


  }


  base = base + '   </div>' +


    '   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="756" data-content-below-spacer="324" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>' +
    '  </div>';

  $("#main_container").append(base);


}

function openRepairParts() {

  $("#main_container").html('');


  var base = '<div class="clearfix slide-left borderbox" id="page"><!-- column -->' +
   '   <div class="clearfix colelem " onclick="openVehicleMenu()" id="back"><i class="fas fa-chevron-circle-left fa-lg"></i></div>' +
    '   <div class="clearfix colelem " id="pu378-4"><!-- group -->' +
    '    <div class="clearfix grpelem" id="u378-4"><!-- content -->' +
    '     <p>REP. TEILE</p>' +
    '    </div>' +
    '   </div>' +
    '   <div class="rounded-corners colelem" id="u392" ><!-- simple frame --></div>' +

    '   <div class="clearfix colelem" id="pu126"><!-- group -->';

  for (const [key, value] of Object.entries(allparts[partType][Parts[partType].type].repair)) {

    

      base = base + '    <div class="gradient  grpelem part" data-part="' + key + '" id="u126"><!-- column -->' +
        '     <div class="colelem" id="u247" style="background: url(img/' + key + '.png) no-repeat center; background-size: 90%; " data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- rasterized frame --></div>' +
        '     <div class="clearfix colelem" id="u148-4" data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- content -->' +
        '      <p> ' + value.amount +' x ' + value.label + '</p>' + //key.toUpperCase()
        '     </div>' +
        '    </div>';
    


  }


  base = base + '   </div>' +


    '   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="756" data-content-below-spacer="324" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>' +
    '  </div>';

  $("#main_container").append(base);


}

function openReplaceParts() {

  $("#main_container").html('');


  var base = '<div class="clearfix slide-left borderbox" id="page"><!-- column -->' +
   '   <div class="clearfix colelem " onclick="openVehicleMenu()" id="back"><i class="fas fa-chevron-circle-left fa-lg"></i></div>' +
    '   <div class="clearfix colelem " id="pu378-4"><!-- group -->' +
    '    <div class="clearfix grpelem" id="u378-4"><!-- content -->' +
    '     <p>TEILE</p>' +
    '    </div>' +
    '   </div>' +
    '   <div class="rounded-corners colelem" id="u392" ><!-- simple frame --></div>' +

    '   <div class="clearfix colelem" id="pu126"><!-- group -->';

  for (const [key, value] of Object.entries(allparts[partType])) {

    if ((allparts[partType][key].usability.exclusive.length == 0 || allparts[partType][key].usability.exclusive.includes(model)) && (allparts[partType][key].usability.vehicletypes.length == 0 || allparts[partType][key].usability.vehicletypes.includes(vehclass))) {

      base = base + '    <div class="gradient  grpelem part" onclick="replacePart(this)" data-part="' + key + '" id="u126"><!-- column -->' +
        '     <div class="colelem" id="u247" style="background: url(img/' + key + '.png) no-repeat center; background-size: 90%; " data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- rasterized frame --></div>' +
        '     <div class="clearfix colelem" id="u148-4" data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- content -->' +
        '      <p>' + value.label + '</p>' +
        '     </div>' +
        '    </div>';
    }


  }


  base = base + '   </div>' +


    '   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="756" data-content-below-spacer="324" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>' +
    '  </div>';

  $("#main_container").append(base);


}

function openVehicleMenu() {

  $("#main_container").html('');

  var nitro = false;
  var turbo = false;
  Parts = parts;

  var base = '<div class="clearfix slide-left borderbox" id="page"><!-- column -->';
  if (repair) {
      base = base +   '<div id="repairMode">' +
    '<div id="repairText">REPARATUR MODUS</div><div id="repairButton" class="ripple" onclick="cancelRepair()">ABBRECHEN</div> </div>';
  }

    base = base + '   <div class="clearfix colelem " id="pu378-4"><!-- group -->' +
    '    <div class="clearfix grpelem" id="u378-4"><!-- content -->' +
    '     <p>' + mileage + ' KILOMETER</p>' +
    '    </div>' +
    '    <div class="clearfix grpelem" id="u389-4"><!-- content -->' +
    '     <p>' + plate + '</p>' +
    '    </div>' +
    '   </div>' +
    '   <div class="rounded-corners colelem" id="u392" ><!-- simple frame --></div>' +

    '   <div class="clearfix colelem" id="pu126"><!-- group -->';

  for (const [key, value] of Object.entries(parts)) {

    var proc = (125 / 100) * value.health;

    base = base + '    <div class="gradient  grpelem box" data-type="' + key + '" id="u126"><!-- column -->' +
      '     <div class="colelem" id="u247" style="background: url(img/' + value.type + '.png) no-repeat center; background-size: 90%; " data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- rasterized frame --></div>' +
      '     <div class="clearfix colelem" id="u148-4" data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- content -->' +
      '      <p>' + value.label + '</p>' +
      '     </div>' +
      '     <div class="rgba-background clearfix colelem" id="u141"><!-- group -->' +
      '      <div class="rgba-background grpelem" id="u144" style="width: ' + proc + 'px" data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- simple frame --></div>' +
      '     </div>' +
      '    </div>';

    if (key == "nitro") {
      nitro = true;
    } else if (key == "turbo") {
      turbo = true;
    }


  }


  if (!turbo && workshop) {
    base = base + '    <div class="gradient grpelem box" data-type="uninstalled" data-uninstalled="turbo" style="opacity: 0.7;" id="u126"><!-- column -->' +
      '     <div class="colelem" id="u247" data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- rasterized frame --></div>' +

      '    </div>';
  }

  if (!nitro && workshop) {
    base = base + '    <div class="gradient grpelem box" data-type="uninstalled" data-uninstalled="nitro" style="opacity: 0.7;" id="u126"><!-- column -->' +
      '     <div class="colelem" id="u247" data-sizePolicy="fixed" data-pintopage="page_fixedRight"><!-- rasterized frame --></div>' +

      '    </div>';
  }

  base = base + '   </div>' +


    '   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="756" data-content-below-spacer="324" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>' +
    '  </div>';

  $("#main_container").append(base);


}


function openGauge(bottom, right) {


  var base = '<div class="clearfix colelem slide-left" id="gauge_location"><!-- group -->' +
    '    <div class="rounded-corners" id="u108"><!-- group -->' +
        '<div id="u109">NOS</div>' + 
        '<div id="u110"></div>' + 
    '    </div>' +
    '    <div class="clip_frame grpelem" id="u120"><!-- image -->' +
    '     <img class="block" id="u120_img" src="img/lowoil.png" alt="" data-heightwidthratio="0.8" data-image-width="45" data-image-height="36"/>' +
    '    </div>' +
    '    <div class="clip_frame grpelem" id="u130"><!-- image -->' +
    '     <img class="block" id="u130_img" src="img/checkengine.png" alt="" data-heightwidthratio="1" data-image-width="36" data-image-height="36"/>' +
    '    </div>' +
    '    <div class="rounded-corners clearfix grpelem" id="u107"><!-- group -->' +
    '     <div class="clearfix grpelem" id="u111-4"><!-- content -->' +
    //'    00003485.0' +
    '     </div>' +
    '    </div>' +
    '   </div>';


  $("#gauges").append(base);

  $("#gauge_location").css("bottom", bottom + "vh").css("right", right + "vw");


}

$(document).keyup(function (e) {
  if (e.keyCode === 27) {

    closeMenu();

  }


});

window.onclick = function (event) {

  if (opened != null) {
    opened.style.display = "none";
    opened.remove();
    opened = null;
  }

}

window.oncontextmenu = function (event) {

  if (opened != null) {
    opened.style.display = "none";
    opened.remove();
    opened = null;
  }

  var columnMenu = false
  var element = $(event.target).parents('.box')[0];

  if (element != null) {

    partType = element.dataset.type;


    var html = '<div id="dropdown" class="dropdown-content">';


    if (partType == "uninstalled") {

      partType = element.dataset.uninstalled;
      html = html + '    <a onclick="openInstallPart()">Installieren</a>';
    } else {


      if (Parts[partType].health > 0 && allparts[partType][Parts[partType].type].repair != null) {
        html = html + '    <a onclick="repairPart()">Reparieren</a>';
         html = html + '    <a onclick="openRepairParts()">Inspizieren</a>';
      }

      html = html + '    <a onclick="openReplaceParts()">Ersetzen</a>';


     
    }

      if (partType == "turbo" || partType == "nitro") {

         html = html + '    <a onclick="removePart()">Remove</a>';

    }


    html = html + '  </div>';

    $("#main_container").append(html);

    var dropdown = document.getElementById("dropdown");
    dropdown.style.display = "block";

    var rect = element.getBoundingClientRect();

    if (columnMenu) {
      dropdown.style.top = rect.top;
    } else {
      dropdown.style.top = rect.top + (rect.bottom - rect.top);
    }

    dropdown.style.left = rect.left;
    dropdown.classList.add("active");


    opened = dropdown;

  }
}

function pad(num, size) {
  var s = "000000000" + num;
  return s.substr(s.length - size);
}

function playClickSound() {
  var audio = document.getElementById("clickaudio");
  audio.volume = 0.05;
  audio.play();
}


window.addEventListener('message', function (event) {


  var edata = event.data;

  if (edata.type == "showinfo") {

    openGauge(edata.bottom, edata.right);
  }

  if (edata.type == "hideinfo") {

    $("#gauges").fadeOut(400);
    timeout = setTimeout(function () {
      $("#gauges").html("");
      $("#gauges").fadeIn();
    }, 400);

  }

  if (edata.type == "info") {

    $("#u111-4").text(pad(edata.mileage, 9));

    if(edata.nitro > 0) {
      
          $("#u108").css("display", "inline");
           $("#u110").css("width", edata.nitro);
    } else {
      $("#u108").css("display", "none");
    }

    if (edata.check) {
      $("#u130_img").attr("src", "img/checkengine_light.png");

    } else {
      $("#u130_img").attr("src", "img/checkengine.png");
    }
    if (edata.oil) {
      $("#u120_img").attr("src", "img/lowoil_light.png");
    } else {

      $("#u120_img").attr("src", "img/lowoil.png");
    }
  }

  if (edata.type == "open") {

 


      repair = edata.repair;
     allparts = edata.allparts;
    vehclass = edata.vehicleType;
    model = edata.model;
    parts = edata.parts;
    plate = edata.plate;
    mileage = edata.mileage;
    workshop = edata.workshop
    openVehicleMenu();

  }


});