$(document).ready(function() {
   var progressbreak = false;
   var progressbar = false;

   function AnimateAddValue(id, targetValue, duration = 500) {
      const obj = document.getElementById(id);

      const currentText = obj.innerText.replace(/\./g, '').replace(',', '.');
      let currentValue = parseFloat(currentText) || 0;

      const diff = targetValue - currentValue;
      if (diff === 0) return;

      const steps = Math.max(10, Math.floor(duration / 30));
      const stepValue = diff / steps;
      let currentStep = 0;

      function step() {
         currentStep++;
         currentValue += stepValue;
         obj.textContent = currentValue.toLocaleString('de-DE', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
         });

         if (currentStep < steps) {
            requestAnimationFrame(step);
         } else {
            obj.textContent = targetValue.toLocaleString('de-DE', {
               minimumFractionDigits: 2,
               maximumFractionDigits: 2
            });
         }
      }

      requestAnimationFrame(step);
   }

   function Progressbar(title, time) {
      if (progressbar == false) {
         $("#progressbar").fadeIn(250);
         progressbar = true;
         progressbreak = false;
         var val = Math.floor(time/100);
         var width = 0;
         var id = setInterval(frame, val);
         function frame() {  
            if (progressbreak == true) {
               clearInterval(id);
               progressbar = false;  
               width = 0;
               $("#progressbar").fadeOut(250);
            }
            if (width >= 100) {
               clearInterval(id);
               progressbar = false;
               width = 0;
               $("#progressbar").fadeOut(250);
            } else {
               width++;
               $("#progressbar-title").text(title);
               $("#progressbar-procent").text(width + "%");
               $("#innerprogressbar").css("width", width + "%");
            }
         }   
      }
   }

   function breakProgressbar() {
      progressbreak = true;
   }

   function SendNotify(type, title, description, time) {
      const containerId = (type === "intern") ? "#norification_intern" : "#notifications";

      const notify = $(`
         <div class="_${type}" style="display: none;">
            <div class="_img-box">
               <img class="${type}" src="../html/assets/img/success.png">
            </div>
            <div class="_data">
               <div class="_type">
                  <h1>${title}</h1>
                  <h2>${description}</h2>
               </div>
               <div class="_progress">
                  <div class="_bar"></div>
               </div>
            </div>
         </div>
      `);

      $(containerId).prepend(notify);
      notify.fadeIn(250);

      let width = 0;
      const bar = notify.find("._bar");
      const intervalTime = Math.floor(time / 100);

      const interval = setInterval(() => {
         if (width >= 100) {
            clearInterval(interval);
            notify.fadeOut(250, () => {
               notify.remove();
            });
         } else {
            width++;
            bar.css("width", width + "%");
         }
      }, intervalTime);
   }

   const announceQueue = [];
   let isAnnounceActive = false;

   function ShowAnnounce(title, description, time) {
      announceQueue.push({ title, description, time });
      ProcessAnnounceQueue();
   }

   function ProcessAnnounceQueue() {
      if (isAnnounceActive || announceQueue.length === 0) return;

      const { title, description, time } = announceQueue.shift();
      isAnnounceActive = true;

      $('#announcement-title').text(title);
      $('#announcement-description').text(description);
      $('#announcement-bar').css("width", "0%");
      $('#announcement').stop(true, true).fadeIn(250);

      let width = 0;
      const intervalTime = Math.floor(time / 100);

      const interval = setInterval(() => {
         if (width >= 100) {
            clearInterval(interval);
            $('#announcement').fadeOut(250, () => {
               isAnnounceActive = false;
               ProcessAnnounceQueue();
            });
         } else {
            width++;
            $('#announcement-bar').css("width", width + "%");
         }
      }, intervalTime);
   }

   function UpdateTimeAndDate() {
      const now = new Date();

      const hours = String(now.getHours()).padStart(2, '0');
      const minutes = String(now.getMinutes()).padStart(2, '0');
      const day = String(now.getDate()).padStart(2, '0');
      const month = String(now.getMonth() + 1).padStart(2, '0'); // Monate: 0-11
      const year = now.getFullYear();

      $('#time').text(`${hours}:${minutes}`);
      $('#date').text(`${day}.${month}.${year}`);
   }

   UpdateTimeAndDate();
   setInterval(UpdateTimeAndDate, 1000);

   window.addEventListener("message", function(event) {
      if (event.data.action == "UpdateId") {
         $('#playerid').text(event.data.id)
      }
      if (event.data.action == "UpdatePlayerCount") {
         $('#onlinecount').text(event.data.playerCount)
      }
      if (event.data.action == "UpdateCarHud") {
         if (event.data.status == true) {
            $('#speedo').fadeIn(250)
            $('#speed').html(event.data.speed + '<span class="kmh"> KMH</span>')
            $('#fuel').html(event.data.fuel + 'L <span class="liter">/100L</span>')
            $("#fuelbar").css("width", event.data.fuel);

            var RPM = (event.data.rpm * 18.4).toFixed(2);

            if (RPM >= 4) {
               $("#bar1").addClass("orange");
            } else {
               $("#bar1").removeClass("orange");
            }

            if (RPM >= 5) {
               $("#bar2").addClass("orange");
            } else {
               $("#bar2").removeClass("orange");
            }

            if (RPM >= 6) {
               $("#bar3").addClass("orange");
            } else {
               $("#bar3").removeClass("orange");
            }

            if (RPM >= 7) {
               $("#bar4").addClass("orange");
            } else {
               $("#bar4").removeClass("orange");
            }

            if (RPM >= 8) {
               $("#bar5").addClass("orange");
            } else {
               $("#bar5").removeClass("orange");
            }

            if (RPM >= 9) {
               $("#bar6").addClass("orange");
            } else {
               $("#bar6").removeClass("orange");
            }

            if (RPM >= 10) {
               $("#bar7").addClass("orange");
            } else {
               $("#bar7").removeClass("orange");
            }

            if (RPM >= 11) {
               $("#bar8").addClass("orange");
            } else {
               $("#bar8").removeClass("orange");
            }

            if (RPM >= 12) {
               $("#bar9").addClass("orange");
            } else {
               $("#bar9").removeClass("orange");
            }

            if (RPM >= 13) {
               $("#bar10").addClass("orange");
            } else {
               $("#bar10").removeClass("orange");
            }

            if (RPM >= 14) {
               $("#bar11").addClass("orange");
            } else {
               $("#bar11").removeClass("orange");
            }

            if (RPM >= 15) {
               $("#barlong1").addClass("red");
            } else {
               $("#barlong1").removeClass("red");
            }

            if (RPM >= 16) {
               $("#barlong2").addClass("red");
            } else {
               $("#barlong2").removeClass("red");
            }

            if (RPM >= 17) {
               $("#barlong3").addClass("red");
            } else {
               $("#barlong3").removeClass("red");
            }

            if (RPM >= 18) {
               $("#barlong4").addClass("red");
            } else {
               $("#barlong4").removeClass("red");
            }

            if (RPM >= 19) {
               $("#barlong5").addClass("red");
            } else {
               $("#barlong5").removeClass("red");
            }

            if (RPM >= 20) {
               $("#barlong6").addClass("red");
            } else {
               $("#barlong6").removeClass("red");
            }
         } else if (event.data.status == false) {
            $('#speedo').fadeOut(250)
         }
      }
      if (event.data.action == "UpdateStatusStatus") {
         $("#hungerbar").css("width", event.data.hunger);
         $("#thirstbar").css("width", event.data.thirst);
      }
      if (event.data.action == "UpdatePostal") {
         $('#street').text(event.data.street)
         $('#postal').text(event.data.postal)
      }
      if (event.data.action == "HideHud") {
         if (event.data.status == true) {
            $('#hud').fadeIn(250)
         } else if (event.data.status == false) {
            $('#hud').fadeOut(250)
         }
      }
      if (event.data.action == "HelpNotify") {
         if (event.data.status == true) {
            $('#helpnotify').fadeIn(250)
            $('#helpnotifymessage').text(event.data.message)
         } else if (event.data.status == false) {
            $('#helpnotify').fadeOut(250)
         }
      }
      if (event.data.action == "Progressbar") {
         if (event.data.status == true) {
            Progressbar(event.data.title, event.data.time)
         } else if (event.data.status == false) {
            breakProgressbar()
         }
      }
      if (event.data.action == "Notify") {
         SendNotify(event.data.type, event.data.title, event.data.description, event.data.time)
      }
      if (event.data.action == "Announce") {
         ShowAnnounce(event.data.title, event.data.description, event.data.time)
      }
      if (event.data.action == "UpdateJob") {
         $('#playerjob').text(event.data.job)
         $('#playerjobgrade').text(event.data.jobgrade)
      }
      if (event.data.action == "UpdateMoney") {
         AnimateAddValue("money", event.data.money, 500);
      }
      if (event.data.action == "UpdateBank") {
         AnimateAddValue("bank", event.data.bank, 500);
      }
      if (event.data.action == "AddPlayerToRadio") {
         const player = $(
            `
            <div data-id="` + event.data.playerId + `" class="_player off">
               <h1><span class="number">[` + event.data.playerId + `]</span> ` + event.data.playerName + `</h1>
               <div class="red"></div>
            </div>
            `
         )

         $('#radiolist').prepend(player);
      }
      if (event.data.action == "RemovePlayerFromRadio") {
         $('#radiolist').find(`[data-id="${event.data.playerId}"]`).remove();
      }
      if (event.data.action == "ClearRadio") {
         $('#radiolist').empty();
      }
      if (event.data.action == "SetRadioChannel") {
         $('#funk').html('<span class="funk">Funk</span> ' + event.data.channel + '.0 FM');
         if (event.data.channel > 0) {
            $('#funklist').fadeIn(250)
         } else {
            $('#funklist').fadeOut(250)
         }
      }
      if (event.data.action == "SetTalkingOnRadio") {
         const player = $('#radiolist').find(`[data-id="${event.data.source}"]`);

         if (player.length > 0) {
            if (event.data.talkingState === true) {
               player.removeClass("off").addClass("on");
               player.find("div").removeClass("red").addClass("green");
            } else {
               player.removeClass("on").addClass("off");
               player.find("div").removeClass("green").addClass("red");
            }
         }
      }
   })
})