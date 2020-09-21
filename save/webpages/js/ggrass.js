$(document).ready(function(){
   $.cookieBar({
     fixed: true,
     message: 'Mit der Nutzung der Audio- und Video-Streams auf diesen Seiten erklären Sie, dass Sie die rechtlichen Hinweise gelesen haben und diese akzeptieren.',
     acceptText: 'Akzeptieren',
     policyButton: true,
     policyText: 'Rechtliche Regelungen',
     policyURL: '/content/below/rights.xml',
     expireDays: 30,
     zindex: '4000',
     domain: 'webdatenbank.grass-medienarchiv.de',
     referrer: 'webdatenbank.grass-medienarchiv.de'
   });

   $('.ggrass_tooltip').tooltip();

   // spam protection for mails
   $('span.madress').each(function(i) {
       var text = $(this).text();
       var address = text.replace(" [at] ", "@");
       $(this).after('<a href="mailto:'+address+'">'+ address +'</a>')
       $(this).remove();
   });
});