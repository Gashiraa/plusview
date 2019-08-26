//= require jquery3
//= require jquery
//= require select2-full
//= require rails-ujs
//= require jquery-ui
//= require semantic-ui
//= require activestorage
//= require turbolinks
//= require select2_locale_fr
//= require_tree .


document.addEventListener('turbolinks:before-cache', function () {
    $('.select2-hidden-accessible').select2('destroy');
});

$(document).on("turbolinks:load", function () {

        {
            // SELECT2 INITIALISATIONS
            $("#project_sort").select2({
                width: '100%',
                selectOnClose: true,
                language: $('.locale').data('locale')
            }); //SORTING BY PROJECT NAME IN LISTINGS

            $("#customer_sort").select2({
                width: '100%',
                selectOnClose: true,
                language: $('.locale').data('locale')
            }); //SORTING BY CUSTOMER NAME IN LISTINGS
        }

        {  // DATEPICKER SECTION
            //Datepickers initilization
            autoFormatDatePicker("sortProjectFrom");
            autoFormatDatePicker("sortProjectTo");

            // Datepicker formatting
            if ($('.locale').data('locale') !== 'fr') {
                $("#sortProjectFrom,#sortProjectTo,#dateProject").datepicker();
            } else {
                $("#sortProjectFrom,#sortProjectTo,#dateProject").datepicker({
                    altField: "#datepicker",
                    closeText: 'Fermer',
                    firstDay: 1,
                    prevText: 'Précédent',
                    nextText: 'Suivant',
                    currentText: 'Aujourd\'hui',
                    monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
                    monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
                    dayNames: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
                    dayNamesShort: ['Dim.', 'Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.', 'Sam.'],
                    dayNamesMin: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
                    weekHeader: 'Sem.',
                    dateFormat: 'dd/mm/yy'
                });
            }
        }

        //Clickable rows (remote true) Not used ATM
        // $("tr[data-link]").click(function () {
        //     if (event.target.tagName === "IMG") {
        //         return
        //     }
        //     $.ajax({
        //         url: this.getAttribute('data-link'),
        //         dataType: "script",
        //         type: "GET"
        //     });
        //     event.preventDefault();
        // });
        //
        //Navbar active (also handling locale)
        $.each($('.ui.menu').find('a'), function () {
            console.log($(this).attr('href'));
            $(this).toggleClass('active',
                ((window.location.pathname.indexOf($(this).attr('href')) > -1) ||
                $('.locale').data('locale') === this.text.toLowerCase() ||
                (window.location.pathname === "/" && $(this).attr('href') === "/projects")) &&
                $(this).attr('id') !== "logo"
            )
        });

        //Notification fader
        setTimeout(function () {
            $('#notice').fadeOut();
        }, 3000);

        // //Color lines from a table
        $('.table-to-color').each(function () {
            let original;
            let rgb;
            // $("tr").not(':first').hover(
            //     function () {
            //         original = $(this).css("background-color");
            //         rgb = original.replace(/^rgba?\(|\s+|\)$/g, '').split(',');
            //         $(this).css("background-color", "rgba(" + rgb[0] + "," + rgb[1] + "," + rgb[2] + "," + 0.75 + ")");
            //     },
            //     function () {
            //         original = $(this).css("background-color");
            //         rgb = original.replace(/^rgba?\(|\s+|\)$/g, '').split(',');
            //         $(this).css("background-color", "rgba(" + rgb[0] + "," + rgb[1] + "," + rgb[2] + "," + 0.55 + ")");
            //     }
            // );
            colorTable();
        });

        // Color status in project dashboard
        $('#status-project').each(function () {
            this.style.backgroundColor = assignColor(this.getAttribute('status'));
        });

        //Color status in selects
        $('#status_sort_select > option').each(function () {
            this.style.backgroundColor = assignColor(this.getAttribute('status'));
        });

        // //Badges titles
        // let title = document.getElementById("titleBadge");
        // switch (title.getAttribute('display')) {
        //     case 'projects' :
        //         title.style.backgroundColor = "#32469b";
        //         break;
        //     case 'wares' :
        //         title.style.backgroundColor = "#6f3e9b";
        //         break;
        //     case 'services' :
        //         title.style.backgroundColor = "#9b4b5b";
        //         break;
        //     case 'customers' :
        //         title.style.backgroundColor = "#9b724c";
        //         break;
        //     case 'quotations' :
        //         title.style.backgroundColor = "#3c769b";
        //         break;
        //     case 'invoices' :
        //         title.style.backgroundColor = "#819b4c";
        //         break;
        //     case 'payments' :
        //         title.style.backgroundColor = "#479b46";
        //         break;
        //     case 'extras' :
        //         title.style.backgroundColor = "#9b7311";
        //         break;
        //     default:
        //         console.log(title.value);
        // }
    }
);

function autoFormatDatePicker(picker) {
    if (document.getElementById(picker)) {
        let element = document.getElementById(picker);
        let oldDate = element.value;
        if (oldDate.length > 0) {
            let yyyy = oldDate.substring(0, 4);
            let mm = oldDate.substring(5, 7);
            let dd = oldDate.substring(8, 10);
            element.value = dd + "/" + mm + "/" + yyyy;
        }
    }
}

//Color lines status
function colorTable() {
    $('.status-cell').each(function () {
        this.firstElementChild.classList.add("ui");
        this.firstElementChild.classList.add(assignColor(this.getAttribute('status')));
        this.firstElementChild.classList.add("button")
        this.firstElementChild.classList.add("status-button")
        // this.parentElement.classList.add(assignColor(this.getAttribute('status')))
    });
}

//Color picker based on status enum
function assignColor(status) {
    switch (status) {
        case 'quotation' : //Project, Ware
            return "blue"; //BLUE
        case 'invoiced' :
        case 'created' :
            return "yellow"; //YELLOW
        case 'assigned_project' :
        case 'assigned_customer' :
        case 'assigned' :
        case 'in_progress' :
            return "orange"; //ORANGE
        case 'not_assigned' :
        case 'done' :
            return "red"; //RED
        case 'accepted' :
        case 'paid' :
            return "green"; //GREEN
        case 'bin' :
            return "grey"; //GREEN
        default:
    }
}

function capitalize(textboxid, str) {
    // string with alteast one character
    if (str && str.length >= 1) {
        var firstChar = str.charAt(0);
        var remainingStr = str.slice(1);
        str = firstChar.toUpperCase() + remainingStr;
    }
    document.getElementById(textboxid).value = str;
}