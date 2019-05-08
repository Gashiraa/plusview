$(document).on("turbolinks:load", function () {

        $('#customer_edit_select').on('focus trigger mouseover change', function () {
            let projects = $('#quotation_projects').html();
            let customer, options;
            customer = $('#customer_edit_select :selected').text();
            options = $(projects).filter("optgroup[label='" + customer + "']").html();
            if (options) {
                return $('#quotation_projects').html(options);
            } else {
                return $('#quotation_projects').empty();
            }
        });
    }
);
