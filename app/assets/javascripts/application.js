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

        {   // SELECT2 INITIALIZATION

            $("#project_sort_select").select2({theme: "bootstrap", width: '100%', selectOnClose: true});
            $("#customer_sort_select").select2({theme: "bootstrap", width: '100%', selectOnClose: true});

            $("#project_edit_select").select2({theme: "bootstrap", width: '100%', selectOnClose: true});
            $("#customer_edit_select").select2({theme: "bootstrap", width: '100%', selectOnClose: true});
            $("#customer_select_invoice").select2({theme: "bootstrap", width: '100%', selectOnClose: true});
            $("#number_select_invoice").select2({theme: "bootstrap", width: '100%', tags: true, selectOnClose: true});

            $("#project_extra_edit_select").select2({theme: "bootstrap", width: '100%', selectOnClose: true});
            $("#category_select_extra_line").select2({theme: "bootstrap", width: '100%', tags: true, selectOnClose: true});

            $("#ware_edit_name_select").select2({theme: "bootstrap", width: '100%', tags: true, selectOnClose: true});

            $("#customer_name_select").select2({theme: "bootstrap", width: '100%', tags: true, selectOnClose: true});
            $("#customer_locality_select").select2({theme: "bootstrap", width: '100%', tags: true, selectOnClose: true});
        }

        {  // DATEPICKER SECTION

            //Datepickers initilization
            autoFormatDatePicker("sortProjectFrom");
            autoFormatDatePicker("sortProjectTo");

            //Datepicker formatting
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

        //Clickable rows (remote true)
        $("tr[data-link]").click(function () {
            if (event.target.tagName === "IMG") {
                return
            }
            $.ajax({
                url: this.getAttribute('data-link'),
                dataType: "script",
                type: "GET"
            });
            event.preventDefault();
        });

        //Navbar active
        $.each($('.navbar-nav').find('li'), function () {
            $(this).toggleClass('active',
                (window.location.pathname.indexOf($(this).find('a').attr('href')) > -1) ||
                $('.locale').data('locale') === this.childNodes[1].text.toLowerCase()
            )
        });

        //Notification fader
        setTimeout(function () {
            $('#notice').fadeOut();
        }, 3000);

        //Color lines status
        $('table').each(function () {
            colorTable(this)
        });

        $('#status_sort_select > option').each(function () {
            this.style.backgroundColor = assignColor(this.getAttribute('status'));
        });

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
        for (let j = 0, cell; cell = row.cells[j]; j++) {
            if (cell.id === "status-cell") {
                row.style.backgroundColor = assignColor(cell.getAttribute('status'));
            }
        }
    }
}

function assignColor(status) {
    switch (status) {
        case 'quotation' : //Project, Ware
            return "rgba(84,205,255,0.65)"; //BLUE
        case 'invoiced' :
        case 'created' :
            return "rgba(255,234,0,0.65)"; //YELLOW
        case 'assigned_project' :
        case 'assigned_customer' :
        case 'assigned' :
        case 'in_progress' :
            return "rgba(255,116,0,0.65)"; //ORANGE
        case 'not_assigned' :
        case 'done' :
            return "rgba(255,7,9,0.65)"; //RED
        case 'accepted' :
        case 'paid' :
            return "rgba(87,194,36,0.65)"; //GREEN
        default:
    }
}