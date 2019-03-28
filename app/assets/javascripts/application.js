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
//= require rails-ujs
//= require bootstrap-sprockets
//= require bootstrap
//= require activestorage
//= require turbolinks
// = require_tree .


$(document).on("turbolinks:load", function () {
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
    $('select[name="ware[project_id]"],html').on('focus, trigger mouseover change', function () {
        if ($('select[name="ware[project_id]"]').val().length > 0) {
            $('#ware_customer_id').prop("disabled", true);
        } else {
            $('#ware_customer_id').prop("disabled", false);
        }
    });
    $('select[name="ware[customer_id]"],html').on('focus, trigger mouseover change', function () {
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

    $('#waresForm,#total_cost,#total_gross,#quantity,#unit_price,#tva_rate,#margin')
        .on('keyup keypress mouseover change', function () {
            let total_cost = document.getElementById('total_cost');
            let total_gross = document.getElementById('total_gross');
            let quantity = document.getElementById('quantity').value || 0;
            let unit_price = document.getElementById('unit_price').value || 0;
            let margin = document.getElementById('margin').value || 1;
            let tva_rate = document.getElementById('tva_rate').value || 0;

            let gross = ((parseInt(quantity) * parseFloat(unit_price)) * parseFloat(margin));
            let total = gross * (1 + parseFloat(tva_rate) / 100);

            total_gross.value = gross.toFixed(2);
            total_cost.value = total.toFixed(2);
        });

    $('#servicesForm,#total_cost_s,#total_gross,#hourly_rate,#tva_rate_s,#coefficient,#_duration_4i,#_duration_5i,#service_duration_4i,#service_duration_5i')
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
});

$(document).ready(function () {
    }
);