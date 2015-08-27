jQuery.fx.interval = 100;

$(document).ready(function () {
    //console.log('setugIOS');
    locuslabs.setupIOS(function () {
        //console.log('setup complete');
        locuslabs.ios.setup();
    });
});
