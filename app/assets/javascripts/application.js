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
//= require js/bin/materialize.min.js
//= require js/datepicker.js
//= require turbolinks
//= require cocoon
//= require highcharts
//= require chartkick
//= require_tree .


// devido imcompatibilidade com turbolinks, o sidenav não funciona apenas com o código abaixo
// $(document).ready(function(){
//   $('.sidenav').sidenav();
// });
// portanto, a solução abaixo resolve esse conflito do sidenav com o turbolinks

document.addEventListener('turbolinks:load', function() {
  elem = document.querySelector('#slide-out');
  instance = new M.Sidenav(elem, {});
});
document.addEventListener('turbolinks:before-visit', function() {
  elem = document.querySelector('#slide-out');
  instance = M.Sidenav.getInstance(elem);
  if (instance){
    instance.destroy();
  }
});