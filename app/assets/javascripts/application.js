//= require jquery3
//= require jquery
//= require select2
//= require rails-ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .


$(document).on("turbolinks:load", function () {

        {   // SELECT2 SECTION

            $("#project_sort_select").select2({theme: "bootstrap", width: '100%'});
            $("#customer_sort_select").select2({theme: "bootstrap", width: '100%'});
            $("#status_sort_select").select2({theme: "bootstrap", width: '100%'});

            $("#project_edit_select").select2({theme: "bootstrap", width: '100%'});
            $("#customer_edit_select").select2({theme: "bootstrap", width: '100%'});
            $("#status_edit_select").select2({theme: "bootstrap", width: '100%'});

            $("#project_extra_edit_select").select2({theme: "bootstrap", width: '100%'});
            $("#extra_edit_select").select2({theme: "bootstrap", width: '100%'});

            $("#ware_edit_name_select").select2({theme: "bootstrap", width: '100%', tags: true});

            $("#customer_name_select").select2({theme: "bootstrap", width: '100%', tags: true});
            $("#customer_locality_select").select2({theme: "bootstrap", width: '100%', tags: true});

        }
        {  // DATEPICKER SECTION

            //Calls for datepickers formatting
            autoFormatDatePicker("sortProjectFrom");
            autoFormatDatePicker("sortProjectTo");

            //Datepicker formatting
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

        //Navbar active
        $.each($('.navbar-nav').find('li'), function () {
            $(this).toggleClass('active',
                window.location.pathname.indexOf($(this).find('a').attr('href')) > -1);
        });

        //Clickable rows
        $("th[data-link]").click(function () {
            console.log(event);
            if (event.target.localName === "a") {
                event.stopPropagation();
            }
            window.location = $(this).data("link")
        });

        //Notification fader
        setTimeout(function () {
            $('#notice').fadeOut();
        }, 3000);

        //Color lines status
        if (document.getElementById("table-to-color")) {
            if (document.getElementById("table-to-color2")) {
                colorTable(document.getElementById("table-to-color2"));
            }
            colorTable(document.getElementById("table-to-color"));
        }

        //Badges titles
        let title = document.getElementById("titleBadge");
        switch (title.getAttribute('display')) {
            case 'projects' :
            case 'project' :
                title.style.backgroundColor = "#32469b";
                break;
            case 'wares' :
                title.style.backgroundColor = "#6f3e9b";
                break;
            case 'services' :
                title.style.backgroundColor = "#9b4b5b";
                break;
            case 'customers' :
                title.style.backgroundColor = "#9b724c";
                break;
            case 'quotations' :
                title.style.backgroundColor = "#3c769b";
                break;
            case 'invoices' :
                title.style.backgroundColor = "#819b4c";
                break;
            case 'payments' :
                title.style.backgroundColor = "#479b46";
                break;
            case 'extras' :
                title.style.backgroundColor = "#9b7311";
                break;
            default:
                console.log(title.value);
        }
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
            element.value = dd + "-" + mm + "-" + yyyy;
        }
    }
}


//Color lines status
function colorTable(tableToColor) {
    for (let i = 0, row; row = tableToColor.rows[i]; i++) {
        for (let j = 0, col; col = row.cells[j]; j++) {
            if (col.id === "status-cell") {
                switch (col.innerHTML) {
                    case 'Devis' : //Project, Ware
                    case 'Créé' : //Quotation
                    case 'Emise' : //Invoice
                        row.style.backgroundImage = "linear-gradient(to right, #95d7db, #a0dce0, #abe0e4, #b5e5e9, #c0eaed)";
                        break;
                    case 'Atelier': //Ware
                    case 'Encodé' : //Service
                    case 'En réalisation' : //Project
                    case 'Envoyé' : //Quotation
                    case 'Envoyée' : //Invoice
                        row.style.backgroundImage = "linear-gradient(to right, #fef07a, #fdf18b, #fcf39c, #fcf4ad, #fbf5bd)";
                        break;
                    case 'Terminé': //Project
                    case 'Attribuée' : //Ware, Service
                    case 'Accepté' : //Quotation
                        row.style.backgroundImage = "linear-gradient(to right, #f9ae48, #f9b559, #f8bb6a, #f7c27b, #f6c88b)";
                        break;
                    case 'A facturer' : //Ware
                        row.style.backgroundImage = "linear-gradient(to right, #ee8f55, #ee9864, #eea172, #eeaa81, #edb390";

                        break;
                    case 'Facturé' : //Project, Ware
                        row.style.backgroundImage = "linear-gradient(to right, #ee7c6c, #ee8475, #ef8c7d, #ee9386, #ee9b8f)";
                        break;
                    case 'Payée' : //Invoice
                    case 'Payé' : //Project, Ware
                        row.style.backgroundImage = "linear-gradient(to right, #cedb4f, #d0db60, #d1dc6f, #d3dc7d, #d4dc8b)";
                        break;
                    default:
                }
            }
        }
    }
}