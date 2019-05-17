$(document).on("turbolinks:load", function () {

    if ($('#project-customer-id').data('somedata')) {
        $("#customer_select_invoice").val([$('#project-customer-id').data('somedata')]);
        $('#customer_select_invoice').select2({theme: "bootstrap", width: '100%', selectOnClose: true}).trigger('change');
    }

    if ($('#project-id').data('somedata')) {
        $("#select_projects_invoice").val([$('#project-id').data('somedata')]);
    }
});
