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
//= require_tree .


$(document).on("turbolinks:load", function () {
    $("tr[data-link]").click(function () {
        window.location = $(this).data("link")
    })

    $('th').click(function () {
        var table = $(this).parents('table').eq(0)
        var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
        this.asc = !this.asc
        if (!this.asc) {
            rows = rows.reverse()
        }
        for (var i = 0; i < rows.length; i++) {
            table.append(rows[i])
        }
    })

    function comparer(index) {
        return function (a, b) {
            var valA = getCellValue(a, index), valB = getCellValue(b, index)
            return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
        }
    }

    function getCellValue(row, index) {
        return $(row).children('td').eq(index).text()
    }

    setTimeout(function () {
        $('#notice').fadeOut();
    }, 3000);

});

$(document).ready(function () {

    }
);