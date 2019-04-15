// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery
//= require rails-ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require bootstrap
//= require activestorage
//= require turbolinks
// = require_tree .


$(document).on("turbolinks:load", function () {

    autoFormatDatePicker("sortProjectFrom");
    autoFormatDatePicker("sortProjectTo");


    $("tr[data-link]").click(function () {
        window.location = $(this).data("link")
    });

    $("tr[data-link] td a").click(function () {
        console.log(event);
        if (event.path[0].attributes.dataset.method !== "delete") {
            event.stopPropagation();
        }
    });

    $('th').click(function () {
        var table = $(this).parents('table').eq(0);
        var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()));
        this.asc = !this.asc;
        if (!this.asc) {
            rows = rows.reverse()
        }
        for (var i = 0; i < rows.length; i++) {
            table.append(rows[i])
        }
    });

    function comparer(index) {
        return function (a, b) {
            var valA = getCellValue(a, index), valB = getCellValue(b, index);
            return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
        }
    }

    function getCellValue(row, index) {
        return $(row).children('td').eq(index).text()
    }

    setTimeout(function () {
        $('#notice').fadeOut();
    }, 3000);

    $('select[name="project_id"]').change(function () {
        if ($(this).val().length > 0) {
            $('#customer_id').prop("disabled", true);
        } else {
            $('#customer_id').prop("disabled", false);
        }
    });
    $('select[name="customer_id"]').change(function () {
        if ($(this).val().length > 0) {
            $('#project_id').prop("disabled", true);
        } else {
            $('#project_id').prop("disabled", false);
        }
    });
    $('select[name="ware[project_id]"]').on('focus, trigger mouseover change', function () {
        if ($('select[name="ware[project_id]"]').val().length > 0) {
            $('#ware_customer_id').prop("disabled", true);
        } else {
            $('#ware_customer_id').prop("disabled", false);
        }
    });
    $('select[name="ware[customer_id]"]').on('focus, trigger mouseover change', function () {
        if ($('select[name="ware[customer_id]"]').val().length > 0) {
            $('#ware_project_id').prop("disabled", true);
        } else {
            $('#ware_project_id').prop("disabled", false);
        }
    });
    $(document).ready(function () {
        $.each($('.navbar-nav').find('li'), function () {
            $(this).toggleClass('active',
                window.location.pathname.indexOf($(this).find('a').attr('href')) > -1);
        });
    });

    //WARES PROVIDER PRICES auto-complete
    $('#provider_price,#provider_discount')
        .on('keyup keypress mouseover change', function () {
            let provider_price = document.getElementById('provider_price').value || 0;
            let provider_discount = document.getElementById('provider_discount').value || 0;
            let bought_price = document.getElementById('bought_price');

            let total = parseFloat(provider_price) - ((parseFloat(provider_price) / 100) * parseFloat(provider_discount));

            bought_price.value = total.toFixed(2);
        });

    //WARES TOTAL auto-complete
    $('#waresForm,#total_cost,#total_gross,#quantity,#bought_price,#tva_rate,#margin')
        .on('keyup keypress mouseover change', function () {
            let total_cost = document.getElementById('total_cost');
            let total_gross = document.getElementById('total_gross');
            let sell_price = document.getElementById('sell_price');
            let quantity = document.getElementById('quantity').value || 0;
            let bought_price = document.getElementById('bought_price').value || 0;
            let margin = document.getElementById('margin').value || 0;
            let tva_rate = document.getElementById('tva_rate').value || 0;

            let sell = parseFloat(bought_price) + ((parseFloat(bought_price) / 100) * parseFloat(margin));
            let gross = (parseInt(quantity) * parseFloat(sell));
            let total = gross * (1 + parseFloat(tva_rate) / 100);

            sell_price.value = sell.toFixed(2);
            total_gross.value = gross.toFixed(2);
            total_cost.value = total.toFixed(2);
        });

    $('#servicesForm,#total_cost_s,#total_gross_s,#hourly_rate,#tva_rate_s,#coefficient,#_duration_4i,#_duration_5i,#service_duration_4i,#service_duration_5i')
        .on('keyup keypress mouseover change', function () {
            let total_cost = document.getElementById('total_cost_s');
            let total_gross = document.getElementById('total_gross_s');
            let hourly_rate = document.getElementById('hourly_rate').value || 0;
            let tva_rate = document.getElementById('tva_rate_s').value || 0;
            let hours;
            let minutes;

            if (document.getElementById('_duration_4i')) {
                hours = document.getElementById('_duration_4i').value || 0;
                minutes = document.getElementById('_duration_5i').value || 0;
            } else {
                hours = document.getElementById('service_duration_4i').value || 0;
                minutes = document.getElementById('service_duration_5i').value || 0;
            }

            let gross = (((parseInt(hours) + parseFloat(minutes) / 60) * parseFloat(hourly_rate)));
            let total = gross * (1 + parseFloat(tva_rate) / 100);

            total_gross.value = gross.toFixed(2);
            total_cost.value = total.toFixed(2);
        });
    $("#sortProjectFrom,#sortProjectTo").datepicker({
        altField: "#datepicker",
        closeText: 'Fermer',
        firstDay: 1 ,
        prevText: 'Précédent',
        nextText: 'Suivant',
        currentText: 'Aujourd\'hui',
        monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
        monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
        dayNames: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
        dayNamesShort: ['Dim.', 'Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.', 'Sam.'],
        dayNamesMin: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
        weekHeader: 'Sem.',
        dateFormat: 'dd-mm-yy'
    });
});

function autoFormatDatePicker(picker) {
    if (document.getElementById(picker)) {
        let element = document.getElementById(picker);
        let oldDate = element.value;
        let yyyy = oldDate.substring(0, 4);
        let mm = oldDate.substring(5, 7);
        let dd = oldDate.substring(8, 10);
        element.value = dd + "-" + mm + "-" + yyyy;
    }
}

$(document).ready(function () {
    }
);