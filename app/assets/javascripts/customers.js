$(document).on("turbolinks:load", function () {
    $("#customer_form_name").select2({
        theme: "bootstrap",
        width: '100%',
        tags: true,
        selectOnClose: true,
        language: $('.locale').data('locale')
    });
    $("#customer_form_locality").select2({
        theme: "bootstrap",
        width: '100%',
        tags: true,
        selectOnClose: true,
        language: $('.locale').data('locale')
    });
});