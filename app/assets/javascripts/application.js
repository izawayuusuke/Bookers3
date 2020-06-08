// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-tagsinput.min
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery.jpostal
//= require_tree .

$(function () {
  $(document).on("turbolinks:load", () => {
    $("#user_postal_code").jpostal({
      postcode: ["#user_postal_code"],
      address: {
        "#user_prefecture_code": "%3",
        "#user_address_city": "%4",
        "#user_address_street": "%5%6%7",
      },
    });
  });
});

// URLからパラメータを取得する
// function getUrlVars() {
//   var vars = {};
//   var param = location.search.substring(1).split("&");
//   for (var i = 0; i < param.length; i++) {
//     var keySearch = param[i].search(/=/);
//     var key = "";
//     if (keySearch != -1) key = param[i].slice(0, keySearch);
//     var val = param[i].slice(param[i].indexOf("=", 0) + 1);
//     if (key != "") vars[key] = decodeURI(val);
//   }
//   return vars;
// }

// セレクトタブの状態を保持する
// $(function () {
//   var val = getUrlVars();
//   var submit_select = val.submit_select;
//   if (submit_select) {
//     var now_select = $("#submit_select").find(
//       'option[value="' + submit_select + '"]'
//     );
//     $(now_select).prop("selected", true);
//   }
// });

// セレクトタブが変更されたら、サブミットする
// $(function () {
//   $("#submit_form").change(function () {
//     $(this).submit();
//   });
// });
