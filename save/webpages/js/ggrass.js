$(document).ready(function(){
   $.cookieBar({
     fixed: true,
     message: 'Mit der Nutzung der Audio- und Video-Streams auf diesen Seiten erklären Sie, dass Sie die rechtlichen Hinweise gelesen haben und diese akzeptieren.',
     acceptText: 'Akzeptieren',
     policyButton: true,
     policyText: 'Rechtliche Regelungen',
     policyURL: '/ggrass/content/below/rights.xml',
     expireDays: 1,
     zindex: '4000',
     domain: 'reposis-test.gbv.de',
     referrer: 'reposis-test.gbv.de'
   });
});