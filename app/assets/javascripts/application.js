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
//= require select2
//= require rails-ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require bootstrap
//= require activestorage
//= require turbolinks
// = require_tree .


$(document).on("turbolinks:load", function () {

        $("#project_select").select2({theme: "bootstrap"});
        $("#customer_select").select2({theme: "bootstrap"});
        $("#status_select").select2({theme: "bootstrap"});
        $("#customer_name_select").select2({theme: "bootstrap"});
        $("#customer_locality_select").select2({theme: "bootstrap"});

        //+++GENERAL+++

        //Navbar active
        $(document).ready(function () {
            $.each($('.navbar-nav').find('li'), function () {
                $(this).toggleClass('active',
                    window.location.pathname.indexOf($(this).find('a').attr('href')) > -1);
            });
        });

        //Calls for datepickers formatting
        autoFormatDatePicker("sortProjectFrom");
        autoFormatDatePicker("sortProjectTo");

        //Clickable rows
        $("tr[data-link]").click(function () {
            console.log(event);
            if (event.target.localName === "a") {
                event.stopPropagation();
            }
            window.location = $(this).data("link")
        });

        //Row sorting
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

        //Row sorting
        function comparer(index) {
            return function (a, b) {
                var valA = getCellValue(a, index), valB = getCellValue(b, index);
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
            }
        }

        function getCellValue(row, index) {
            return $(row).children('td').eq(index).text()
        }

        //Notification fader
        setTimeout(function () {
            $('#notice').fadeOut();
        }, 3000);

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

        //Color lines status
        if (document.getElementById("table-to-color")) {
            let tableToColor = document.getElementById("table-to-color");
            for (let i = 0, row; row = tableToColor.rows[i]; i++) {
                for (let j = 0, col; col = row.cells[j]; j++) {
                    if (col.id === "status-cell") {
                        switch (col.innerHTML) {
                            case 'Devis' : //Project, Ware
                            case 'Créé' : //Quotation
                            case 'Emise' : //Invoice
                                row.style.backgroundColor = "rgba(149,215,219,0.66)";
                                break;
                            case 'Atelier': //Ware
                            case 'Encodé' : //Service
                            case 'En réalisation' : //Project
                            case 'Envoyé' : //Quotation
                            case 'Envoyée' : //Invoice
                                row.style.backgroundColor = "rgba(206,219,79,0.65)";
                                break;
                            case 'Terminé': //Project
                            case 'Attribuée' : //Ware, Service
                            case 'Accepté' : //Quotation
                                row.style.backgroundColor = "rgba(254,240,122,0.65)";
                                break;
                            case 'A facturer' : //Ware
                                row.style.backgroundColor = "rgba(249,174,72,0.65)";
                                break;
                            case 'Facturé' : //Project, Ware
                            case 'Payée' : //Invoice
                                row.style.backgroundColor = "rgba(238,143,85,0.65)";
                                break;
                            case 'Payé' : //Project, Ware
                                row.style.backgroundColor = "rgba(238,124,108,0.65)";
                                break;
                            default:
                        }
                    }
                }
            }
        }

        //Badges titles
        let title = document.getElementById("titleBadge");
        switch (title.innerText) {
            case 'PROJETS' :
            case 'PROJET' :
                title.className += " badge badge-primary";
                break;
            case 'MARCHANDISES' :
                title.className += " badge badge-success";
                break;
            case 'PRESTATIONS' :
                title.className += " badge badge-danger";
                break;
            case 'CLIENTS' :
                title.className += " badge badge-warning";
                break;
            case 'DEVIS' :
                title.className += " badge badge-info";
                break;
            case 'FACTURES' :
                title.className += " badge badge-dark";
                break;
            case 'PAIEMENT' :
                title.className += " badge badge-secondary";
                break;
            default:
                console.log(title.value);
        }

        //+++WARES+++

        //Disabling dropdowns for ware forms
        $('select[id="project_id"]').on('focus trigger mouseover change', function () {
            if ($(this).val().length > 0) {
                $('#customer_id').prop("disabled", true);
                $('#status option:eq(2)').prop('selected', true);
            } else {
                $('#customer_id').prop("disabled", false);
                $('#status option:eq(0)').prop('selected', true);
            }
        });
        $('select[id="customer_id"]').on('focus trigger mouseover change', function () {
            if ($(this).val().length > 0) {
                $('#project_id').prop("disabled", true);
            } else {
                $('#project_id').prop("disabled", false);
            }
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

        //+++SERVICES++++

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

                }
            );
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

//Confirmation messages for service updates
function confirmService() {
    if (document.getElementById('invoice_id').name !== (0 || "service[0]"))
        return confirm('Cette prestation est déjà facturée, continuer ?');
}