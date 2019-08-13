(function () {
    "use strict";

    /*-------------------------*/
    /* global variable         */
    /*-------------------------*/
    var deviceID,
        watchID,
        questID,
        zoneID,
        zonePinArray = [],
        questPinArray = [],
        map,
        myPin,
        myPosition,
        checkUserInterval = null,
        watchUserInterval = null,
        updateUserInterval = null,
        waterInterval = null,
        couponsArray = [],
        globalPosition,
        music,
        test = "0"; //sound switch pc = 1, android = 0
        

    //user is fishing -  variable
    var luring = true,
        lureFishInterval = null,
        line = 10, //spoil
        rod = 10, //rod
        bait = 10, //bait
        multiDistance = 2.8, //multiple distance trown
        castDistance;

    //Handle the Cordova deviceready event
    document.addEventListener( 'deviceready', onDeviceReady.bind( this ), false );

    /*-------------------------*/
    /* device ready 		   */
    /*-------------------------*/
    function onDeviceReady() {
        initialize(); //check & initialize

        // Handle the Cordova pause and resume events
        document.addEventListener( 'pause', onPause.bind( this ), false );
        document.addEventListener( 'resume', onResume.bind( this ), false );
    }

    /*-------------------------*/
    /* on device pause  	   */
    /*-------------------------*/
    function onPause() {
        // TODO: This application has been suspended. Save application state here.
    }

    /*-------------------------*/
    /* on device resume		   */
    /*-------------------------*/
    function onResume() {
        // TODO: This application has been reactivated. Restore application state here.
    }
  
    /*-------------------------*/
    /*  initialize             */
    /*-------------------------*/
    function initialize() {

        //variable
        var serverAddress = address("checkDevice.php"),
            start_time = new Date().getTime();

        deviceID = device.uuid; //get device uuid

        //after check if user is new .then load everything else in sequel
        $.post(serverAddress, {"deviceID": deviceID}, "json").then(function () {

            checkAccessTime(start_time, "check device success:"); //time over connection

        }, function (error) { console.log("check device error: " + error); })
            .then(function () {
                Howler.volume(0.1); //Change global volume
                musicFunction("water_ambient"); //load and play music
            })
            .then(deferringImages()) //load in images
            .then(loadButtons()) //load in all buttons
            .then(getQuest()) //load in all users quest
            .then(getCoupons()) //load in all users coupons
            .then(loadMap()) //load in map
            .then(function () {
                cssStyle("#loader", "display", "none"); //hide loading
                cssStyle("#content", "display", "block");  //show content

                //interval
                startCDP(); //start checking gps location /3sec
                startUpdateUser(); //start update gps location to database /4sec
                startCheckWater(); //start checking water over database /6sec
            });

    }

    /*-------------------------*/
    /* GPS / interval      	   */
    /*-------------------------*/
    //start check device position
    function startCDP() {
        if (!checkUserInterval) {
            checkUserInterval = setInterval(deviceGPS_currentPosition, 3000);
        }
    }

    //stop check device position
    function stopCDP() {
        if (checkUserInterval) {
            clearInterval(checkUserInterval);
            checkUserInterval = null;
        }
    }

    //start check device position
    function startWatch() {
        if (!watchUserInterval) {
            watchUserInterval = setInterval(deviceGPS_watchPosition, 3000);
        }
    }

    //stop check device position
    function stopWatch() {
        if (watchUserInterval) {
            clearInterval(watchUserInterval);
            watchUserInterval = null;
        }
    }

    //start check water
    function startCheckWater() {
        if (!waterInterval) {
            waterInterval = setInterval(checkNearWater, 6000);
        }
    }

    //stop check water
    function stopCheckWater() {
        if (waterInterval) {
            clearInterval(waterInterval);
            waterInterval = null;
        }
    }

    //start update user
    function startUpdateUser() {
        if (!updateUserInterval) {
            updateUserInterval = setInterval(updateMyPosition, 4000);
        }
    }

    //stop update user
    function stopUpdateUser() {
        if (updateUserInterval) {
            clearInterval(updateUserInterval);
            updateUserInterval = null;
        }
    }

    /*-------------------------*/
    /* updateCoupons       	   */
    /*-------------------------*/
    function getCoupons() {

        //variable
        var serverAddress = address("getCoupons.php"),
            start_time = new Date().getTime();

        //update data
        $.post(serverAddress, { "deviceID": deviceID }, function (data) { }, "json").then(function (data) {

            for (var x in data) { couponsArray.push({ title: data[x].title, description: data[x].description, time: data[x].time }); } //loop though data from database

            checkAccessTime(start_time, "get coupons success: "); //time over connection

        }, function (error) { console.log("get coupons error: " + error); });

    }

    /*-------------------------*/
    /* countDownTimer      	   */
    /*-------------------------*/
    function countDown(value, number) {

        // Set the date we're counting down to
        var countDownDate = new Date(value).getTime(),
            x;

        //interval
        x = setInterval(function () {

            // Get todays date and time
            var now = new Date().getTime();

            // Find the distance between now and the count down date
            var distance = countDownDate - now;

            // Time calculations for hours, minutes and seconds
            var hours = Math.floor(distance % (1000 * 60 * 60 * 24) / (1000 * 60 * 60));
            var minutes = Math.floor(distance % (1000 * 60 * 60) / (1000 * 60));
            var seconds = Math.floor(distance % (1000 * 60) / 1000);

            // Display the result in the element with class="date"
            $("#timeLeft" + number).text("Tid kvar: " + hours + "t " + minutes + "m " + seconds + "s ");

            // If the count down is finished, write some text
            if (distance < 0) {
                clearInterval(x);
                $("#timeLeft" + number).text("Ogiltig");
            }

            //stop counter if not visible
            if ($("#coupons").is(':hidden')) {
                clearInterval(x);
            }

        }, 1000);

    }

    /*-------------------------*/
    /* random what user get	   */
    /*-------------------------*/
    function randomGift() {

        var gift = randomGen(0, 100);

        //calc for what user get
        if (gift <= 5) {
            //5%

            //sound
            soundEffect("questDone");

            //message
            messageBox("Du hittade påskharens bonusfråga!");

            //wait 2 sec before getting poll
            setTimeout(function () {
                getPoll();
            }, 2000);

        } else if (gift > 5 && gift <= 20) {
            //15% 
            eggGain(3);

        } else if (gift > 20 && gift <= 45) {
            //25%
            eggGain(2);

        } else if (gift > 45 && gift <= 80) {
            //35%
            eggGain(1);

        } else if (gift > 80) {
            //20%

            //sound
            soundEffect("error");

            //message
            messageBox("Du hittade inget!");

        }
    }

    /*-------------------------*/
    /* eggGain          	   */
    /*-------------------------*/
    function eggGain(newEgg) {

        //variable
        var eggValue = Number(localStorage.getItem(eggCount));

        //update egg
        eggValue += Number(newEgg);

        //message
        messageBox("Du hittade " + newEgg + " ägg!");

        //update localstorage eggCount
        localStorage.setItem(eggCount, eggValue);

        //wait 2 sec
        setTimeout(function () {

            //if localstorage eggCount is >= 10
            if (localStorage.getItem(eggCount) >= 10) {

                //variable
                var serverAddress = address("updateEgg.php"),
                    start_time = new Date().getTime();

                //remove 10 egg
                eggValue -= 10;

                //update localstorage eggCount
                localStorage.setItem(eggCount, eggValue);

                //get coupon
                $.post(serverAddress, { "deviceID": deviceID }).then(function () {

                    //message
                    messageBox("Du har fått en ny rabatt!");

                    //check time
                    checkAccessTime(start_time, "eggGain");

                }, function (xhr, status, error) { console.log("eggGain - xhr: " + xhr + " status: " + status + " error: " + error); });

                //account information
                updateEggCount();

                //get and update coupons
                getCoupons();
            }

        }, 2000);

        //account information
        updateEggCount();

    }

    /*-------------------------*/
    /* getPoll          	   */
    /*-------------------------*/
    function getPoll() {

        //variable
        var serverAddress = address("getPoll.php"),
            start_time = new Date().getTime(),
            rightAnswer,
            idOutput = "#q1",
            idOutput2 = "#q2",
            idOutput3 = "#q3",
            idOutput4 = "#poll";

        //get data
        $.post(serverAddress, { "deviceID": deviceID }, function (data) { }, "json").then(function (data) {

            //get data and array push it
            for (var x in data) {
                //poll title
                $("#pollTitle").html(data[x].title);

                //poll question
                $(idOutput).html(data[x].q1);

                //poll question
                $(idOutput2).html(data[x].q2);

                //poll question
                $(idOutput3).html(data[x].q3);

                //right answer
                rightAnswer = data[x].answer;
            }

            //check time
            checkAccessTime(start_time, "Poll");

        }, function (xhr, status, error) { console.log("Poll - xhr: " + xhr + " status: " + status + " error: " + error); });

        //show poll
        $(idOutput4).toggle();

        //button
        $(idOutput).on("click", function () {
            answer("q1");
        });

        $(idOutput2).on("click", function () {
            answer("q2");
        });

        $(idOutput3).on("click", function () {
            answer("q3");
        });

        //users answer
        function answer(userAnswer) {

            //close poll
            $(idOutput4).toggle();

            //what user get after an answer
            if (userAnswer === rightAnswer) {

                messageBox("Du svarade rätt och får extra ägg!");

                //wait 2 sec before user get egg
                setTimeout(function () {
                    eggGain(10);
                }, 2000);

            } else {

                messageBox("Det svarade lite fel!");

                //wait 2 sec before user get egg
                setTimeout(function () {
                    eggGain(randomGen(1, 3));
                }, 2000);
            }

        }
    }

    /*-------------------------*/
    /* loadButtons     	       */
    /*-------------------------*/
    function loadButtons() {

        //array
        var buttonArray = [
            {
                container: "#fishingButton",
                getFunc: fishingButton,
                click: "click",
                sound: "button"
            },{
                container: "#closeButton",
                getFunc: closeButton,
                click: "click",
                sound: "button2"
            },{
                container: "#mapButton",
                getFunc: mapButton,
                click: "click",
                sound: "button"
            },{
                container: "#settingButton",
                getFunc: settingButton,
                click: "click",
                sound: "button"
            },{
                container: "#couponButton",
                getFunc: couponButton,
                click: "click",
                sound: "button"
            }
        ];

        //loop buttonArray
        for (var index = 0; index < buttonArray.length; index++) (function (index) {
      
            $(buttonArray[index].container).on(buttonArray[index].click, function () {
                vibrationFunction(50); //vibrator
                soundEffect(buttonArray[index].sound); //sound
                buttonArray[index].getFunc(); //function to the button

                //interval
                if (buttonArray[index].container === "#closeButton") {

                    //start intervals if it not exist
                    if (!checkUserInterval && !updateUserInterval && !waterInterval) {
                        startCDP();
                        startUpdateUser();
                        startCheckWater();
                    }

                    if (watchUserInterval) { stopWatch(); } //if watch is active, then stop it

                } else if (buttonArray[index].container !== "#mapButton") {

                    //stop intervals
                    stopCDP();
                    stopUpdateUser();
                    stopCheckWater();

                }
                    
            });

        })(index);

        //get quest id
        $("body").on("click", "div.subQuestID", function () {
            vibrationFunction(50); //vibrator
            soundEffect("button"); //sound

            questButton(this);

            //stop intervals
            stopCDP();
            stopUpdateUser();
            stopCheckWater();
        });

    }

    /*-------------------------*/
    /* buttons       	       */
    /*-------------------------*/
    //quest button
    function questButton(id) {

        //hide
        cssStyle(".middleButton", "display", "none");
        cssStyle("#buttonText3", "display", "none");

        //show
        cssStyle("#closeButton", "display", "block");

        questID = $(id).attr('id'); //get id
        getSubQuest(questID);

    }

    //coupon button
    function settingButton() {

        //variable
        var checkVal;

        //array
        var settingsArray = [
            { name: "vibration", title: "vibrationer", image: "vibrate", value: "1" },
            { name: "sound", title: "Ljud", image: "sound", value: "1" },
            { name: "music", title: "Musik", image: "music", value: "1" }
        ];

        //hide
        cssStyle("#styleTop", "display", "none");
        cssStyle("#buttonMenu", "display", "none");
        cssStyle("#mapContent", "display", "none");
        cssStyle("#settingButton", "display", "none");

        //show
        cssStyle("#closeButton", "display", "block");
        //cssStyle("#settings", "display", "block");

        //empty mainContent
        $("#contentOutput").empty();

        //output main title
        $("#contentOutput").append("<h1 class='settingsh1'>Inställningar</h1>");

        //show data
        for (var index = 0; index < settingsArray.length; index++) (function (index) {

            //get localstorage name value
            if (localStorage.getItem(settingsArray[index].name) === null) {
                localStorage.setItem(settingsArray[index].name, settingsArray[index].value);
            }

            //set checkbox to the right value
            if (localStorage.getItem(settingsArray[index].name) === "1") {
                checkVal = "checked";
            } else {
                checkVal = "unchecked";
            }

            //checkbox click button
            $("body").on("click", "input[name=" + settingsArray[index].name + "]", function () {

                // If the checkbox is checked, display the output text
                if ($(this).attr("checked", "checked").is(":checked")) {

                    //localstorage
                    localStorage.setItem(settingsArray[index].name, "1");

                    //play music
                    if (settingsArray[index].name === "music") {
                        music.play();
                    }
                } else {

                    //localstorage
                    localStorage.setItem(settingsArray[index].name, "0");

                    //pause music
                    if (settingsArray[index].name === "music") {
                        music.stop();
                    }
                }

            });

            //output data
            $("#contentOutput").append(
                '<div class="col-full">' +
                '<div class="wrap-col boxButton">' +

                '<div class="col-9-12">' +
                '<div class="wrap-col">' +
                '<img src="images/svg/' + settingsArray[index].image + '.svg" alt="">' +
                '<p>' + settingsArray[index].title + '</p>' +
                '</div>' +
                '</div>' +

                '<div class="col-3-12">' +
                '<div class="wrap-col">' +
                '<label class="container">' +
                '<input id=' + settingsArray[index].name + ' type="checkbox" name=' + settingsArray[index].name + ' ' + checkVal + '>' +
                '<span class="checkmark"></span>' +
                '</label>' +
                '</div>' +
                ' </div>' +

                '</div></div>');

        })(index);

        $("#contentOutput").append("<version>V. 1.0.0</version>");

    }

    //coupon button
    function couponButton() {

        //show
        cssStyle("#closeButton", "display", "block");

        //hide
        cssStyle(".middleButton", "display", "none");
        cssStyle("#buttonText3", "display", "none");

        //empty mainContent
        $("#contentOutput").empty();

        //variable
        var y = 1;

        //show data
        for (var x in couponsArray) {

            //output data
            $("#contentOutput").append(
                '<div class="col-full box"><div class="wrap-col">' +

                '<div class="col-full">' +
                '<div class="wrap-col">' +
                '<h2>' + couponsArray[x].title + '</h2>' +
                '<p>' + couponsArray[x].description + '</p>' +
                '</div>' +
                '</div>' +

                '<div id="timeLeft' + y + '" class="date"></div>' +

                '</div></div>'
            );

            //write out time left
            countDown(couponsArray[x].time, y);

            //increase y with 1
            y += 1;
        }

    }

    //fishing button
    function fishingButton() {

        //variable
        //var serverAddress = address("updateZone.php");

        //hide
        cssStyle("#styleTop", "display", "none");
        cssStyle(".middleButton", "display", "none");
        cssStyle("#buttonText3", "display", "none");
        cssStyle("#mapContent", "display", "none");

        //show
        cssStyle("#closeButton", "display", "block");
        cssStyle("#styleFishing", "display", "block");

        //empty mainContent
        $("#contentOutput").empty();

        throwLine();  //throw fishing line

            //time to search
            /*setTimeout(function () {

                var start_time = new Date().getTime();

                //give user a random gift
                randomGift();

                //update data
                $.post(serverAddress, { "zoneID": zoneID, "deviceID": deviceID }).then(function () {

                    //check time
                    checkAccessTime(start_time, "CheckZone");

                    //update zone on map
                    updateZonePosition();

                }, function (xhr, status, error) { console.log("CheckZone - xhr: " + xhr + " status: " + status + " error: " + error); });

            }, 2000);*/

    }

    //close button
    function closeButton() {

        //hide
        cssStyle("#closeButton", "display", "none");
        cssStyle("#mapContent", "display", "none");
        cssStyle("#coupons", "display", "none");
        cssStyle("#poll", "display", "none");
        cssStyle("#styleFishing", "display", "none");

        //show
        cssStyle("#styleTop", "display", "block");
        cssStyle("#buttonMenu", "display", "block");
        cssStyle("#settingButton", "display", "block");

        //empty mainContent
        $("#contentOutput").empty();
        getQuest();
    }

    //map button
    function mapButton() {

        //hide
        cssStyle("#styleTop", "display", "none");
        cssStyle("#buttonMenu", "display", "none");
        cssStyle("#buttonText3", "display", "none");

        //show
        cssStyle("#closeButton", "display", "block");
        cssStyle("#mapContent", "display", "block");

        //empty mainContent
        $("#contentOutput").empty();

        //adding zones if null
        if (zonePinArray.length === 0) {
            getZonePosition();
        }

        //adding quest if null
        if (questPinArray.length === 0) {
            getQuestPosition();
        }

        //interval
        startWatch();

    }

    /*-------------------------*/
    /* get quest data          */
    /*-------------------------*/
    function getQuest() {

        //variable
        var serverAddress = address("getQuest.php");
        
        //clear content div
        $('#contentOutput').empty();
        
        //get post
        $.post(serverAddress, { "deviceID": deviceID }, function (data) {

            for (var x in data) {

                $("#contentOutput").prepend(
                    '<div id=' + data[x].id + ' class="col-full subQuestID lastChild">' +
                        '<div class="wrap-col boxButton">' +

                            '<div class="col-full">' +
                                '<div class="wrap-col">' +
                                    '<img class="rightSideImg" src="images/svg/fish2.svg" alt="">' +
                                    '<h3>' + data[x].title + '</h3>' +
                                    "<div class='subP'>Uppdrag: " + data[x].quest + "</div>" +
                                '</div>' +
                            '</div>' +

                        "</div>" +
                    "</div>"
                );
            }
        }, "json");

    }

    /*-------------------------*/
    /* get quest sub data      */
    /*-------------------------*/
    function getSubQuest(id) {

        //vibration
        vibrationFunction(50);

        //variable
        var serverAddress = address("getQuestSub.php");

        //clear content div
        $('#contentOutput').empty();

        //get data
        $.post(serverAddress, { "questID": id, "deviceID": deviceID }, function (data) {
            
            var viewQuestNumber = 0;

            for (var x in data) {

                viewQuestNumber += 1;

                $("#contentOutput").prepend(
                    '<div class="col-full lastChild '+ data[x].title +'">' +
                    '<div class="wrap-col boxRead">' +

                    '<div class="col-full">' +
                    '<div class="wrap-col">' +
                    '<p>' + nl2br(data[x].text) + '</p>' +
                    '</div>' +
                    '</div>' +

                    "</div>" +
                    "</div>"
                );

                /*$("#contentOutput").prepend(
                    "<div class='col-full lastChild " + data[x].title + "'><div class='wrap-col boxButton'>"

                    + "<p>" + data[x].text + "</p>"
                    + "<p class='subP'>Uppdrag: " + viewQuestNumber + "</p>"

                    + "</div></div>");*/
            }
        }, "json");
    }

    /*-------------------------*/
    /* throw fishing line      */
    /*-------------------------*/
    function throwLine() {

        //variable
        var ax = 0,
            ay = 0,
            az = 0,
            delay = 1000,
            check_interval,
            startPosition = true;

        //motion
        if (window.DeviceMotionEvent) { window.ondevicemotion = function (event) { ax = event.accelerationIncludingGravity.x; }; }

        //check if device is in starting position
        check_interval = setInterval(function () {

            if (ax <= "-8" && startPosition === true) {
                countdown(); //countdown before you can cast
                startPosition = false;
            }

        }, delay);

        //countdown function
        function countdown() {

            //variable
            var delay = 1000,
                time = 3,
                time_interval;

            //interval
            time_interval = setInterval(function () {

                //start counting down
                if (time > 0 && ax <= "-8") {
                    soundEffect("tick");
                    $("#distCal").html(time);
                }

                //countdown end
                if (time <= 0 && ax <= "-8") {
                    $("#distCal").html("Kasta!");
                    clearInterval(time_interval); //end this interval
                    throwSpeed(); //check users cast to see which lenght the line goes
                }

                //moving out of startPosition
                if (ax > "-8") {
                    $("#distCal").empty(); //empty content
                    clearInterval(time_interval); //end this interval
                    startPosition = true;

                    //reset
                    $("#distM").html("Förbered ditt kast! <br /><img class='movingRight' src='images/svg/arrow_right.svg' />");
                    $("#distCal").html("<img src='images/svg/fishing_rod.svg' alt=''>");
                    $("#distM").empty();
                }

                //decrement
                time--;

            }, delay);

        }

        //throw speed function
        function throwSpeed() {

            //variable
            var delay = 1,
                time = 0,
                time_interval;

            //interval
            time_interval = setInterval(function () {

                if (ax >= "8") {

                    soundEffect("cast");

                    castDistance = (line + rod + bait) * multiDistance - time;

                    if (castDistance > 0) {
                        $("#distCal").html(castDistance);
                        $("#distM").html("meter");
                        $("#messageOutput").html("Veva in linan!");
                        clearInterval(time_interval); //end this interval

                        setTimeout(function () { throwSuccess(castDistance); }, 2000); //if thrown success, run function after 2 sec

                    } else {
                        $("#messageOutput").html("En del av linan fastnade.");
                        //end countdown and reset it - try again
                        clearInterval(time_interval); //end this interval
                        startPosition = true;
                    }
                }

                time++;

            }, delay);

        }

        //throw success
        function throwSuccess(castDistance) {

            //variable
            var delay = 100,
                time_interval,
                getLine = true;

            //interval
            time_interval = setInterval(function () {

                //left side, then wait for right side
                if (ax >= "3" && getLine === true) {
            
                    $("#distCal").html(castDistance);
                    $("#messageOutput").html("Veva in linan! <br/><img class='movingRight' src='images/svg/arrow_right.svg' />");

                    soundEffect("reel2");
                    castDistance -= 1;
                    getLine = false;
                }

                //right side, then wait for left side
                if (ax < "3" && ax <= "-3" && getLine === false) {
    
                    $("#distCal").html(castDistance);
                    $("#messageOutput").html("Veva in linan! <br/><img class='movingLeft' src='images/svg/arrow_left.svg' />");

                    soundEffect("reel3");
                    castDistance -= 1;
                    getLine = true;
                }

                //check if user can lure a fish
                if (luring === true) {

                    //fish on the hook
                    lureFish();

                } else {

                    //if distance <= 0, then check if user have a fish or not
                    if (castDistance <= 0) {
                        $("#messageOutput").html("Du fick ingen fisk.");
                        clearInterval(time_interval); //end this interval
                        startPosition = true;
                        clearInterval(lureFishInterval); //end this interval

                        //reset
                        $("#distM").html("Förbered ditt kast! <br /><img class='movingRight' src='images/svg/arrow_right.svg' />");
                        $("#distCal").html("<img src='images/svg/fishing_rod.svg' alt=''>");
                        $("#distM").empty();
                    }

                }

            }, delay);
        }

        //if user lured fish
        function lureFish() {

            //variable
            var lureChance = Math.floor(Math.random(line + rod + bait) / Math.random(line + rod + bait) * 0.1),
                random100 = randomGen(0, 100);

            //calc for what user get
            if (random100 + lureChance >= 50) { //if user has 15% and over a fish can be lured, then check if fish can be catch (100% / user skill can add up to this catchrate)

                //cant lure fish
                luring = false;

                //wait 2 sec before countinue
                setTimeout(function () {

                    //message
                    $("#messageOutput").html("En fisk har nappat! <br>Se till att den inte sliter sig!");

                    //fish hooked - random shake
                    lureFishInterval = setInterval(function () {

                        //vibrator
                        vibrationFunction(randomGen(100, 1000));

                    }, randomGen(100, 2500));

                    //check if random chance + user skills can add up to 100%, if so then user will catch the fish
                    if (random100 + lureChance >= 40 && castDistance <= 0) {
                        clearInterval(lureFishInterval); //end this interval
                        setTimeout(function () {
                            catchFish();
                            luring = true; //reset so user can lure a fish again
                        }, 2000);
                    } else if (random100 + lureChance >= 0 && random100 + lureChance <= 30) {
                        clearInterval(lureFishInterval); //end this interval
                        luring = true; //reset so user can lure a fish again
                        $("#messageOutput").html("Fisken lyckades smita.");
                    }

                }, 2000);      

            }

        }

        //if user catch fish
        function catchFish() {
            $("#messageOutput").html("Du drog up en fisk!");
        }

    }

    /*-------------------------*/
    /*-------------------------*/
    /* map section	           */
    /*-------------------------*/
    /*-------------------------*/

    /*-------------------------*/
    /* initialize map          */
    /*-------------------------*/
    function loadMap() {

        //ApLCEMry5NxPZgclDYBfn8nRWBjsBVpXqBxNGhYXhptPyUspgINSSBZmAfLQoKtM

        //yaUBbzkhEYiXdUP5JMGu~eWEOkhy1LA5VNJeXXxVXqw~AjGA6jHbUOVZt8oUEU-nzuzvD6zUS9yQStc8Ud4kiSAgY_z70_5ECE-1rHFdkY5c

        //create map
        map = new Microsoft.Maps.Map('#mapContent', {
            credentials: 'yaUBbzkhEYiXdUP5JMGu~eWEOkhy1LA5VNJeXXxVXqw~AjGA6jHbUOVZt8oUEU-nzuzvD6zUS9yQStc8Ud4kiSAgY_z70_5ECE-1rHFdkY5c',
            showMapTypeSelector: false,
            showZoomButtons: false,
            showLocateMeButton: false,
            showScalebar: false,
            showTermsLink: false,
            showCopyright: false,
            allowHidingLabelsOfRoad: true,
            liteMode: true,
            zoom: 16
            //mapTypeId: Microsoft.Maps.MapTypeId.aerial
        });

        //custom style
        var easterMap = {
            elements: {
                mapElement: { "labelVisible": false },
                political: { "borderStrokeColor": "#a0b100", "borderOutlineColor": "#a0b100" },
                point: { "iconColor": "#a0b100", "fillColor": "#a0b100", "strokeColor": "#a0b100" },
                transportation: { "strokeColor": "#5b1a65", "fillColor": "#a0b100" },
                sand: { "fillcolor": "#fbb92c" },
                railway: { "strokeColor": "#a0b100", "visible": false },
                structure: { "fillColor": "#5b1a65" },
                water: { "fillColor": "#ff75cff0" },
                area: { "fillColor": "#ffb6e591" },
                tollRoad: { fillColor: '#a964f4', strokeColor: '#a964f4' },
                arterialRoad: { fillColor: '#ffffff', strokeColor: '#d7dae7' },
                road: { fillColor: '#ffa35a', strokeColor: '#ff9c4f' },
                street: { fillColor: '#ffffff', strokeColor: '#ffffff' }
            },
            settings: {
                landColor: "#efe9e1"
            }
        };

        //options
        map.setOptions({
            maxZoom: 17,
            minZoom: 15
            //customMapStyle: easterMap
        });

    }

    /*-------------------------*/
    /* update device position  */
    /*-------------------------*/
    function updateMyPosition() {

        //variable
        var serverAddress = address("updateLocation.php"),
            start_time = new Date().getTime();

        //update data
        $.post(serverAddress, { "deviceID": deviceID, "latitude": globalPosition.coords.latitude, "longitude": globalPosition.coords.longitude }).then(function () {

            //check time
            checkAccessTime(start_time, "updateMyPosition");

        }, function (xhr, status, error) { console.log("updateMyPosition - xhr: " + xhr + " status: " + status + " error: " + error); });

    }

    /*-------------------------*/
    /* check device near water */
    /*-------------------------*/
    function checkNearWater() {

        //variable
        var serverAddress = address("checkNearWater.php"),
            start_time = new Date().getTime(),
            classOutput = "#fishingButton",
            textOutput = "#buttonText3";

        //update data
        $.post(serverAddress, { "latitude": globalPosition.coords.latitude, "longitude": globalPosition.coords.longitude }, function (data) { }, "json").then(function (data) {

            //check distance to zones
            if (data === true) {
                console.log("Can fish");
                //show button
                cssStyle(classOutput, "display", "block");
                cssStyle(textOutput, "display", "block");
            } else {
                //hide button
                cssStyle(classOutput, "display", "block"); //none
                cssStyle(textOutput, "display", "block"); //none
            }

            //check time
            checkAccessTime(start_time, "checkNearWater");

        }, function (xhr, status, error) { console.log("checkNearWater - xhr: " + xhr + " status: " + status + " error: " + error); });

    }

    /*-----------------------------*/
    /* device gps currentPosition  */
    /*-----------------------------*/
    function deviceGPS_currentPosition() {

        //try highAccuracy
        navigator.geolocation.getCurrentPosition(success, error_highAccuracy, option_highAccuracy);

        //options highAccuracy
        var option_highAccuracy = {
            maximumAge: 600000,
            timeout: 5000,
            enableHighAccuracy: true
        };

        //error highAccuracy
        function error_highAccuracy(error) {

            if (error.code === error.TIMEOUT) {

                // Attempt to get GPS loc timed out after 5 seconds,
                // try low accuracy location

                console.log("attempting to get low accuracy location");

                //try lowAccuracy
                navigator.geolocation.getCurrentPosition(success, error_lowAccuracy, option_lowAccuracy);

                //options highAccuracy
                var option_lowAccuracy = {
                    maximumAge: 600000,
                    timeout: 10000,
                    enableHighAccuracy: false
                };

                return;
            }

            //show error message
            var msg = "Can't get your location (high accuracy attempt). Error = ";
            if (error.code === 1)
                msg += "PERMISSION_DENIED";
            else if (error.code === 2)
                msg += "POSITION_UNAVAILABLE";
            msg += ", msg = " + error.message;

            console.log(msg);
        }

        //error lowAccuracy
        function error_lowAccuracy(error) {
            var msg = "Can't get your location (low accuracy attempt). Error = ";
            if (error.code === 1)
                msg += "PERMISSION_DENIED";
            else if (error.code === 2)
                msg += "POSITION_UNAVAILABLE";
            else if (error.code === 3)
                msg += "TIMEOUT";
            msg += ", msg = " + error.message;

            console.log(msg);
        }

        //success
        function success(position) {

            globalPosition = position;
         
        }

    }

    /*-----------------------------*/
    /* device gps currentPosition  */
    /*-----------------------------*/
    function deviceGPS_watchPosition() {

        //try highAccuracy
        watchID = navigator.geolocation.watchPosition(success, error_highAccuracy, option_highAccuracy);

        //options highAccuracy
        var option_highAccuracy = {
            maximumAge: 600000,
            timeout: 5000,
            enableHighAccuracy: true
        };

        //error highAccuracy
        function error_highAccuracy(error) {

            if (error.code === error.TIMEOUT) {

                // Attempt to get GPS loc timed out after 5 seconds,
                // try low accuracy location

                console.log("attempting to get low accuracy location");

                //try lowAccuracy
                navigator.geolocation.watchPosition(success, error_lowAccuracy, option_lowAccuracy);

                //options highAccuracy
                var option_lowAccuracy = {
                    maximumAge: 600000,
                    timeout: 10000,
                    enableHighAccuracy: false
                };

                return;
            }

            //show error message
            var msg = "Can't get your location (high accuracy attempt). Error = ";
            if (error.code === 1)
                msg += "PERMISSION_DENIED";
            else if (error.code === 2)
                msg += "POSITION_UNAVAILABLE";
            msg += ", msg = " + error.message;

            console.log(msg);
        }

        //error lowAccuracy
        function error_lowAccuracy(error) {
            var msg = "Can't get your location (low accuracy attempt). Error = ";
            if (error.code === 1)
                msg += "PERMISSION_DENIED";
            else if (error.code === 2)
                msg += "POSITION_UNAVAILABLE";
            else if (error.code === 3)
                msg += "TIMEOUT";
            msg += ", msg = " + error.message;

            console.log(msg);
        }

        //success
        function success(position) {

            //variable
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;

            //console.log("Your watch location is: " + latitude + "," + longitude + " Accuracy=" + position.coords.accuracy + "m");

            // create a new LatLng object for every position update
            myPosition = new Microsoft.Maps.Location(latitude, longitude);

            // build entire marker first time thru
            if (myPin === undefined) {

                //users icon
                myPin = new Microsoft.Maps.Pushpin(myPosition, {
                    icon: "images/isometric/user.svg"
                });

                //view myPosition
                map.setView({ center: myPosition });

                //Add the pushpin to the map
                map.entities.push(myPin);

            } else {

                //change myPin position on subsequent passes
                myPin.setLocation(myPosition);

                //view myPosition
                //map.setView({ center: myPosition });

            }

        }

    }

    /*-------------------------*/
    /* track own quests        */
    /*-------------------------*/
    function getQuestPosition() {

        var questPin,
            questPosition,
            serverAddress = address("getQuestLocation.php"),
            iconArray = ["iso_flag"],
            svg_icon,
            start_time = new Date().getTime();

        //get data
        $.post(serverAddress, { "deviceID": deviceID }, function (data) { }, "json").then(function (data) {

            //loop users id who are online and not same id as the user
            for (var x in data) {

                // create a new LatLng object for every position update
                questPosition = new Microsoft.Maps.Location(data[x].latitude, data[x].longitude);

                //random egg from array
                svg_icon = iconArray[Math.floor(Math.random() * iconArray.length)];

                //icon
                questPin = new Microsoft.Maps.Pushpin(questPosition, {
                    icon: "images/isometric/" + svg_icon + ".svg",
                    title: data[x].title
                });

                //Add the pushpin to the map
                map.entities.push(questPin);

                // Push marker to markers array
                questPinArray.push(questPin);
            }

            //check time
            checkAccessTime(start_time, "getQuestLocation");

        }, function (xhr, status, error) { console.log("getZoneLocation - xhr: " + xhr + " status: " + status + " error: " + error); });

    }

    /*-------------------------*/
    /* track own zones         */
    /*-------------------------*/
    function getZonePosition() {

        var zonePin,
            zonePosition,
            serverAddress = address("getZoneLocation.php"),
            iconArray = ["iso_panel"],
            svg_icon,
            start_time = new Date().getTime();

        //get data
        $.post(serverAddress, { "deviceID": deviceID }, function (data) { }, "json").then(function (data) {

            //loop users id who are online and not same id as the user
            for (var x in data) {

                // create a new LatLng object for every position update
                zonePosition = new Microsoft.Maps.Location(data[x].latitude, data[x].longitude);

                //random egg from array
                svg_icon = iconArray[Math.floor(Math.random() * iconArray.length)];

                //users icon
                zonePin = new Microsoft.Maps.Pushpin(zonePosition, {
                    icon: "images/isometric/" + svg_icon + ".svg",
                    title: data[x].title
                });

                //Add the pushpin to the map
                map.entities.push(zonePin);

                //Push marker to markers array
                zonePinArray.push(zonePin);
            }

            //check time
            checkAccessTime(start_time, "getZoneLocation");

        }, function (xhr, status, error) { console.log("getZoneLocation - xhr: " + xhr + " status: " + status + " error: " + error); });

    }

    /*-------------------------*/
    /* update own zone & quest */
    /*-------------------------*/
    function updateZonePosition() {

        //remove zoneID from array and map
        var index = map.entities.indexOf(zonePinArray[zoneID]);

        if (index !== -1) {
            map.entities.removeAt(index - 1);
        }

    }

    function updateQuestPosition() {

        //remove zoneID from array and map
        var index = map.entities.indexOf(questPinArray[questID]);

        if (index !== -1) {
            map.entities.removeAt(index - 1);
        }

    }

    /*-------------------------*/
    /* random generator    	   */
    /*-------------------------*/
    function randomGen(min, max) { return Math.floor(Math.random() * (max - min) + min); }

    /*-------------------------*/
    /* checkAccessTime 	       */
    /*-------------------------*/
    function checkAccessTime(sTime, value) {

        //check time
        var request_time = new Date().getTime() - sTime;

        console.log(value + " " + request_time + " ms");
        //messageBox(value + " " + request_time + " ms");
    }

    /*-------------------------*/
    /* messageBox			   */
    /*-------------------------*/
    function messageBox(data) {

        //variable
        var box = "#messageBox",
            time = 2000;

        //fade in message
        $(box).hide().html(data).fadeIn();

        //fade out message after time in sec
        setTimeout(function () {
            $(box).fadeOut("slow");
        }, time);
    }

    /*-------------------------*/
    /* Css style			   */
    /*-------------------------*/
    function cssStyle(style, value, value2) { $(style).css(value, value2); }

    /*-------------------------*/
    /* Deferring Images        */
    /*-------------------------*/
    function deferringImages() {

        var imgDefer = document.getElementsByTagName('img');

        for (var i = 0; i < imgDefer.length; i++) {
            if (imgDefer[i].getAttribute('data-src')) {
                imgDefer[i].setAttribute('src', imgDefer[i].getAttribute('data-src'));
            }
        }
    }

    /*-------------------------*/
    /* serveraddress           */
    /*-------------------------*/
    function address(src) {

        //89.160.115.26

        //variable
        var ip = "http://89.160.115.26",
            folder = "/laxfiske/ajax/",
            address = ip + folder + src;

        return address;
    }

    /*-------------------------*/
    /* line breaks             */
    /*-------------------------*/
    function nl2br(str, is_xhtml) {
        if (typeof str === 'undefined' || str === null) {
            return '';
        }
        var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br />' : '<br>';
        return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
    }

    /*-------------------------*/
    /*-------------------------*/
    /* system section 		   */
    /*-------------------------*/
    /*-------------------------*/

    /*---------------------------*/
    /* sound / music / vibration */
    /*---------------------------*/
    //vibration
    function vibrationFunction(value) {
        if (localStorage.getItem("vibration") === "1") {
            navigator.vibrate(value);
        }
    }

    //sound
    function soundEffect(value) {
        if (localStorage.getItem("sound") === "1") {

            var sound;

            if (test === "0") {
                sound = new Howl({
                    src: ["/android_asset/www/sound/" + value + ".mp3"],
                    volum: 0.5
                }); //android
            } else {
                sound = new Howl({
                    src: ["/sound/" + value + ".mp3"],
                    volum: 0.5
                }); //pc test
            }

            sound.play();
        }
    }

    //music
    function musicFunction(value) {

        if (localStorage.getItem("music") === "1") {

            //android or PC
            if (test === "0") {
                music = new Howl({
                    src: ["/android_asset/www/music/" + value + ".mp3"],
                    loop: true,
                    volum: 0.01
                }); //android
            } else {
                music = new Howl({
                    src: ["/music/" + value + ".mp3"],
                    loop: true,
                    volum: 0.01
                }); //pc test
            }

            //play
            music.play();

        }

    }

})();